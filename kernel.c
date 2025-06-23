/* =============================================================================================================================== */
/* INCLUDES */
// #include <stdio.h>
#include <stdint.h>
#include "kernel-stub.h"
#include "directory.h"
#include "types.h"
#include "linked_list.h"

/* =============================================================================================================================== */

/* =============================================================================================================================== */
/* CONSTANTS */

#define BITS_PER_BYTE 8
#define BITS_PER_NYBBLE 4
#define CLOCK_QUANTA 10

#define ADDR_SIZE (sizeof(address_t))
#define ALIGN_UP(addr) (addr % ADDR_SIZE == 0 ? addr : (addr + ADDR_SIZE) & (ADDR_SIZE - 1))

#define HEADER_TO_BLOCK(p) ((void *)((address_t)p + sizeof(header_s)))
#define BLOCK_TO_HEADER(p) ((header_s *)((address_t)p - sizeof(header_s)))

static char hex_digits[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
header_s free_head = {.next = NULL, .prev = NULL, .size = 0};
header_s free_tail = {.next = NULL, .prev = NULL, .size = 0};

// Pointer to head of free block list
MemoryBlock_s *free_block_list = NULL;

// ptr to process list (circular)
static process_info_s *process_list = NULL;

// ptr for current process
process_info_s *current_process = NULL;

extern void set_registers(address_t base, address_t limit, address_t epc, address_t sp);
extern void clock_alarm_handler(void);
extern void syscall_handler_halt(void);

/* The current limit of the heap. */
address_t heap_limit = (address_t)NULL;
extern address_t statics_limit;

/* =============================================================================================================================== */
/* =============================================================================================================================== */
void int_to_hex(word_t value, char *buffer)
{

  /* Traverse the value from most to least significant bits. */
  for (int shift = BYTES_PER_WORD * BITS_PER_BYTE - BITS_PER_NYBBLE; shift >= 0; shift -= BITS_PER_NYBBLE)
  {

    /* Grab the next nybble and add its corresponding digit to the string, advancing the string's pointer. */
    word_t nybble = (value >> shift) & 0xf;
    *buffer++ = hex_digits[nybble];
  }

  /* Finish the string with a null termination. */
  *buffer = '\0';

} /* int_to_hex () */
/* =============================================================================================================================== */
// void setup_heap_area()
// {
//   statics_limit = (address_t)&statics_limit;
//   char buf[9];
//   int_to_hex(statics_limit, buf);
//   print("Heap starts at: ");
//   print(buf);
//   print("\n");
// }
/* =============================================================================================================================== */
void run_programs()
{

  static word_t next_program_ROM = 3;

  /* Find the next program ROM in the device table. */
  char str_buffer[9];
  print("Searching for ROM #");
  int_to_hex(next_program_ROM, str_buffer);
  print(str_buffer);
  print("\n");
  dt_entry_s *dt_ROM_ptr = find_device(ROM_device_code, next_program_ROM++);
  if (dt_ROM_ptr == NULL)
  {
    return;
  }

  // print("Running program...\n");
  current_ROM = next_program_ROM;

  /* Copy the program into the free RAM space after the kernel. */
  DMA_portal_ptr->src = dt_ROM_ptr->base;
  DMA_portal_ptr->dst = kernel_limit;
  DMA_portal_ptr->length = dt_ROM_ptr->limit - dt_ROM_ptr->base; // Trigger

  /* Jump to the copied code at the kernel limit / program base. */
  userspace_jump(kernel_limit);

} /* run_programs () */
/* =============================================================================================================================== */

void run_specific_program(word_t romNumber, address_t dest)
{

  /* Find the next program ROM in the device table. */
  char str_buffer[9];
  // print("Searching for Ro");
  // print("We are searching for this specific program:\n");
  int_to_hex(romNumber, str_buffer);
  print(str_buffer);
  print("\n");
  dt_entry_s *dt_ROM_ptr = find_device(ROM_device_code, romNumber);
  if (dt_ROM_ptr == NULL)
  {
    // print("ROM not found.\n");
    return;
  }

  current_ROM = romNumber;

  /* Copy the program into the free RAM space after the kernel. */
  DMA_portal_ptr->src = dt_ROM_ptr->base;
  DMA_portal_ptr->dst = dest;
  DMA_portal_ptr->length = dt_ROM_ptr->limit - dt_ROM_ptr->base; // Trigger

  /* Jump to the copied code at the kernel limit / program base. */
  // userspace_jump(kernel_limit);
}
/* =============================================================================================================================== */

void do_print(address_t msg)
{

  // dt_entry_s *dt_ROM_ptr = find_device(ROM_device_code, current_ROM);

  // address_t base = dt_ROM_ptr->base;

  address_t pmsg = msg + current_process->ram_block->base;

  print((char *)pmsg);
}

/* =============================================================================================================================== */

/**
 * Initialize the heap.  If it is already initialized, do nothing.
 */

void heap_init()
{

  /* Continue only if the heap is uninitialized. */
  if (heap_limit != (address_t)NULL)
    return;

  /* Start the heap where the statics end. */
  heap_limit = (address_t)&statics_limit;

  /* Initialize the sentinels that bookend the free block list. */
  free_head.next = &free_tail;
  free_tail.prev = &free_head;

} /* heap_init () */

/*
=============================================================================================================================== */

void *allocate(int size)
{
  heap_init();
  size = ALIGN_UP(size);
  header_s *current = free_head.next;

  // Search the free list for a block of sufficient size.
  while (current != &free_tail)
  {
    if (current->size >= size)
    {
      // Block is large enough. Remove it from the free list.
      current->prev->next = current->next;
      current->next->prev = current->prev;
      current->next = NULL;
      current->prev = NULL;
      break;
    }
    else
    {
      current = current->next;
    }
  }

  // If no suitable free block was found, allocate a new block.
  if (current == &free_tail)
  {
    int block_size = sizeof(header_s) + size;
    current = (header_s *)heap_limit;
    current->size = size;
    heap_limit += block_size;
  }

  return HEADER_TO_BLOCK(current);
}
/* allocate() */

/*
=============================================================================================================================== */

void deallocate(void *ptr)
{

  /* Do nothing if there is no block. */
  if (ptr == NULL)
    return;

  /* Find the header. */
  header_s *header = BLOCK_TO_HEADER(ptr);

  /* Insert the block at the front of the free list. */
  header->next = free_head.next;
  header->prev = &free_head;
  free_head.next->prev = header;
  free_head.next = header;

} /* deallocate () */

/*
=============================================================================================================================== */

void *malloc_custom(int size)
{
  return allocate(size);
}

void free_custom(void *ptr)
{
  deallocate(ptr);
}

/*
=============================================================================================================================== */

uint32_t unendianify(uint32_t value)
{
  return ((value & 0x000000FFU) << 24) |
         ((value & 0x0000FF00U) << 8) |
         ((value & 0x00FF0000U) >> 8) |
         ((value & 0xFF000000U) >> 24);
}

/*
=============================================================================================================================== */

void init_RAM_blocks()

{

  address_t start = kernel_limit;

  word_t RAM_instance = 1;

  dt_entry_s *dt_RAM_ptr = find_device(RAM_device_code, RAM_instance);

  address_t RAM_limit = dt_RAM_ptr->limit;

  // Initialize free block list to empty
  free_block_list = NULL;

  word_t number_blocks = 0;

  char hello[9];
  print("kernel_limit = ");
  int_to_hex(kernel_limit, hello);
  print(hello);
  print("\n");

  print("RAM_limit = ");
  int_to_hex(RAM_limit, hello);
  print(hello);
  print("\n");

  for (address_t addr = start; addr + BLOCK_SIZE <= RAM_limit; addr += BLOCK_SIZE)
  {
    // Iterate over RAM and divide into blocks

    number_blocks++;
    // print("loop iteration. \n");

    MemoryBlock_s *new_block = (MemoryBlock_s *)malloc_custom(sizeof(MemoryBlock_s));

    // printing this showed that the allocator isn't actually allocating a new
    // block for each call, it's just reusing the same block over and over again
    char ptrbuf[9];
    int_to_hex((word_t)new_block, ptrbuf);
    print("Allocated block at address = ");
    print(ptrbuf);
    print("\n");

    if (new_block == NULL)
    {
      print("block could not be allocated");
      break;
    }

    new_block->base = addr;
    new_block->next = NULL;
    new_block->prev = NULL;

    INSERT(free_block_list, new_block);

    char freeblockbuf[9];
    print("freeblocklisthead= ");
    int_to_hex(free_block_list->base, freeblockbuf);
    print(freeblockbuf);
    print("\n");

    // if (free_block_list->next != NULL)
    // {
    //   char next[9];
    //   print("freeblocklistnext= ");
    //   int_to_hex(free_block_list->next->base, next);
    //   print(next);
    //   print("\n");
    // }

    // if (free_block_list->prev != NULL)
    // {
    //   char prev[9];
    //   print("freeblocklistprev= ");
    //   int_to_hex(free_block_list->prev->base, prev);
    //   print(prev);
    //   print("\n");
    // }
  }

  print("free block list initialized:\n");
  MemoryBlock_s *cur = free_block_list;
  while (cur != NULL)
  {
    print("Block base: ");
    char buf[9];
    int_to_hex(cur->base, buf);
    print(buf);
    print("\n");
    cur = cur->next;
  }
}

/*
=============================================================================================================================== */
void free_RAM_block(MemoryBlock_s *ram_block)
{
  deallocate(ram_block);

  ram_block->next = free_block_list;
  // ram_block->prev = NULL;
  // if (free_block_list != NULL)
  // {
  //   free_block_list->prev = ram_block;
  // }
  free_block_list = ram_block;
}

/*
=============================================================================================================================== */

MemoryBlock_s *assign_ram_block(void)
{
  if (free_block_list == NULL)
  {
    // No blocks left
    return NULL;
  }

  // taking the head of the free list
  MemoryBlock_s *block = free_block_list;

  // removing the link from free block list
  free_block_list = block->next;
  if (free_block_list)
  {
    free_block_list->prev = NULL;
  }
  block->next = NULL;
  block->prev = NULL;

  print("Assigned RAM block\n");
  return block;
}

void load_bd_block(uint32_t block_num, address_t RAM_buffer)
{
  // Find the device table entry for the block device.
  dt_entry_s *bd_dt_entry = (dt_entry_s *)find_device(block_device_code, 1);
  if (!bd_dt_entry)
  {
    print("No block device!\n");
    return;
  }
  // Load the block number into the "service window."
  // Move back 8B to the block_num parameter space in the block device portal

  print("loading a bd block!\n");
  word_t *block_num_control = (word_t *)(bd_dt_entry->limit - 8);
  *block_num_control = block_num;
  // Move back 4B to the trigger parameter space in the block device portal.
  word_t *bd_op_control = (word_t *)(bd_dt_entry->limit - 4);
  *bd_op_control = 0; // Trigger the block device operation

  /*
  Inputting the trigger should cause the block device to return a copy of
  the block's data. Retrieve it and place it in our allocated RAM space.
  */
  // DMA the data from the "service window" return space to RAM.
  DMA_portal_ptr->src = bd_dt_entry->base;
  DMA_portal_ptr->dst = RAM_buffer;
  DMA_portal_ptr->length = 4096; // The buffer space in the portal is 4KB.
}

inode_s *load_inode(uint32_t inode_num, address_t inode_buffer)
{
  // print("debug load inode");
  // no need to allocate ram in here bc the space should already be alloced from copying in the directory
  // inode_buffer should be the limit of the buffer/ the base of the inode space

  uint32_t unendian = unendianify(inode_num);

  // # load the inode block into the allocated space in ram
  load_bd_block(unendian, inode_buffer);
  inode_s *inode = (inode_s *)inode_buffer;

  // # return pointer to inode space as an inode_s
  return inode;
}

void load_file(inode_s *inode)
{

  print("bruhloading a file");
  // Take the inode and load blocks into ram
  // THE 4KB is the block size
  // uint32_t starting_address = inode
  // to get the number of blocks we divide blocks / 4096

  uint32_t num_blocks = unendianify(inode->length) / 4096;

  // make sure to take upper cieling of the block
  if (unendianify(inode->length) % 4096 != 0)
  {
    num_blocks++;
  }

  // if num_blocks = 0 return error
  if (num_blocks == 0)
  {
    print("no user data blocks\n");
    return;
  }

  MemoryBlock_s *memptr = assign_ram_block();
  address_t current_ptr = memptr->base;

  for (uint32_t i = 0; i < num_blocks; i++)
  {
    load_bd_block(unendianify(inode->blocks[i]), current_ptr);

    current_ptr += 4096;
  }

  print("Successfully loaded all file blocks \n");
}

static directory_entry_s *directory;
static inode_s dir_inode;
static address_t dir_limit;

void preload_directory(block_number_t directory_inode_block_num, MemoryBlock_s *assigned_ram_block)
{
  print("directory inode block number:");
  char inode_buf[9];
  int_to_hex(unendianify(directory_inode_block_num), inode_buf);
  print(inode_buf);
  print("\n");

  address_t curr_addr = assigned_ram_block->base;
  inode_s *cur_inode = load_inode(directory_inode_block_num, curr_addr);

  curr_addr = curr_addr + 4096;
  load_file(cur_inode);
}

extern uint32_t block_device_code;
extern DMA_portal_s *DMA_portal_ptr;

void preload_fs()
{
  print("Allocating RAM space for file system startup..\n");
  MemoryBlock_s *fs_buffer = assign_ram_block();
  if (fs_buffer == NULL)
  {
    print("No free RAM blocks available for filesystem.\n");
    return;
  }
  print("Filesystem buffer assigned at address: ");
  char buf[9];
  int_to_hex(fs_buffer->base, buf);
  print(buf);
  print("\n");

  load_bd_block(0, fs_buffer->base);
  print("Superblock loaded into RAM.\n");

  superblock_s *superblock_ptr = (superblock_s *)fs_buffer->base;

  print("Magic cookie:");
  char cookie_buf[9];
  int_to_hex(unendianify(superblock_ptr->magic_cookie), cookie_buf);
  print(cookie_buf);
  print("\n");

  print("Superblock length:");
  char length_buf[9];
  int_to_hex(unendianify(superblock_ptr->length), length_buf);
  print(length_buf);
  print("\n");

  // UNDER CONSTRUCTION:
  preload_directory(superblock_ptr->directory_block, fs_buffer);

  // load directory file
}

/*
=============================================================================================================================== */

MemoryBlock_s *RAM_load_block(address_t dest, word_t size, word_t romNumber)
{
  MemoryBlock_s *block = assign_ram_block();
  if (!block)
  {
    print("RAM_load_block: out of blocks!\n");
    return NULL;
  }

  current_process->ram_block = block;

  int ROM_device_code = 5;

  dt_entry_s *dt_ROM_ptr = find_device(ROM_device_code, romNumber);

  /* Copy the program into the free RAM space after the kernel. */
  DMA_portal_ptr->src = dt_ROM_ptr->base;
  DMA_portal_ptr->dst = dest;
  DMA_portal_ptr->length = dt_ROM_ptr->limit - dt_ROM_ptr->base; // Trigger

  return block;
}

/*
=============================================================================================================================== */

address_t allocate_process_stack()
{
  address_t stack_memory = (address_t)malloc_custom(STACK_SIZE);
  if (stack_memory == (address_t)NULL)
  {
    print("stack allocation failed! \n");
  }

  return stack_memory;
}

/*
=============================================================================================================================== */

void add_process(process_info_s *process)
{
  if (process_list == NULL)
  {
    // The reason why next and prev point to process is because it's circular
    process_list = process;
    process->next = process;
    process->prev = process;
  }
  else
  {
    process_info_s *tail = process_list->prev;
    tail->next = process;
    process->prev = tail;
    process->next = process_list;
    process_list->prev = process;
  }
}

void remove_process(process_info_s *process)
{
  if (process->next == process && process->prev == process)
  {
    // setting process_lust to null because no processes left now
    process_list = NULL;
  }
  else
  {
    process->prev->next = process->next;
    process->next->prev = process->prev;
    if (process_list == process)
    {
      process_list = process->next;
    }
  }
}

/*
=============================================================================================================================== */

void create_process(int process_id, word_t rom_instance)
{

  // allocating memory for process
  process_info_s *process = (process_info_s *)malloc_custom(sizeof(process_info_s));
  if (process == NULL)
  {
    print("process control structure allocation failed\n");
    return;
  }
  // assigning process_id
  process->process_id = process_id;

  // allocating stack using allocate process stack function
  address_t stack_memory = allocate_process_stack();
  if (stack_memory == (address_t)NULL)
  {
    print("process stack allocation is doing bruh burh \n");
  }

  // adjusting stack pointers accordingly
  process->stack_limit = stack_memory;                // bottom
  process->stack_base = stack_memory + STACK_SIZE;    // top
  process->saved_stack_pointer = process->stack_base; // sp is top

  // assigning the process to the ram
  if (free_block_list != NULL)
  {
    MemoryBlock_s *assigned_block = free_block_list;
    free_block_list = free_block_list->next;

    assigned_block->next = assigned_block->prev = NULL;
    process->ram_block = assigned_block;

    char buf[9];
    print("process assigned to ram_block at = ");
    int_to_hex(process->ram_block->base, buf);
    print(buf);
    print("\n");
  }
  else
  {
    print("no RAM blocks are available for this process.\n");
  }

  run_specific_program(rom_instance, process->ram_block->base);

  process->entry_point = process->ram_block->base;
  process->saved_pc = process->entry_point;           // epc is entry point
  process->saved_stack_pointer = process->stack_base; // sp is top
  add_process(process);

  char buf[9];
  print("Process ");
  int_to_hex(process_id, buf);
  print(buf);
  print(" loaded from ROM instance ");
  int_to_hex(rom_instance, buf);
  print(buf);
  print(" assigned to RAM block at address = ");
  int_to_hex(process->ram_block->base, buf);
  print(buf);
  print("\n");
}

/*
=============================================================================================================================== */

void print_process_list(void)
{
  if (process_list == NULL)
  {
    print("Process list is empty.\n");
    return;
  }

  process_info_s *cur = process_list;

  char buf[9];
  print("Processes in list:\n");

  do
  {
    print("Process ID: ");
    int_to_hex(cur->process_id, buf);
    print(buf);
    print(" | Stack Base: ");
    int_to_hex(cur->stack_base, buf);
    print(buf);
    print(" | Stack Limit: ");
    int_to_hex(cur->stack_limit, buf);
    print(buf);
    print("\n");
    cur = cur->next;
  } while (cur != process_list);
}

/*
=============================================================================================================================== */

/*
=============================================================================================================================== */

void schedule_next(void)
{

  print("alarm TRIGGERED. \n");

  if (process_list == NULL)
  {
    print("no processes to shcedule. \n");
    return;
  }

  if (current_process == NULL)
  {
    current_process = process_list;
  }
  else
  {
    current_process = current_process->next;
  }

  char buf[9];
  print("Current process is: ");
  int_to_hex(current_process->process_id, buf);
  print(buf);
  print("Stack pointer is:");
  int_to_hex(current_process->saved_stack_pointer, buf);
  print(buf);
  print("\n");

  // setting up MMU base and limit reg for virtual addressing
  if (current_process->ram_block != NULL)
  {
    address_t base = current_process->ram_block->base;
    address_t limit = base + BLOCK_SIZE;

    // need to call a function in assembly to set MMU base and register values, also have to update the environment program counter
    set_registers(base, limit, current_process->saved_pc, current_process->saved_stack_pointer);
  }
  else
  {
    print("process has no assigned RAM block \n");
  }

  // userspace_jump(current_process->saved_stack_pointer);
}

/*
=============================================================================================================================== */

void alarm_scheduler(void)
{
  clock_alarm_handler();
}

/*
=============================================================================================================================== */

void tester(void)
{

  init_RAM_blocks();

  preload_fs();
}

/*
=============================================================================================================================== */

void custom_do_exit(int exit_code)
{
  free_RAM_block(current_process->ram_block);
  remove_process(current_process);

  if (exit_code == 0)
  {
    print("Exit was successful with exit code 0.\n");
  }
  else
  {
    char buf[9];
    int_to_hex(exit_code, buf);
    print("Exit was unsuccesful with exit code non-zero.\n");
    print(buf);
    print("\n");
  }

  if (process_list == NULL)
  {
    syscall_handler_halt();
  }
  else
  {
    schedule_next();
  }
}