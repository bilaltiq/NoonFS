#if !defined(_TYPES_H)
#define _TYPES_H

#include <stdint.h>
#include <stdbool.h>
#include "block-device.h"
#include "inode.h"

#define NULL 0
#define HEAP_SIZE (1024 * 1024) // 1MB Heap  Size
#define STACK_SIZE (8 * 1024)   // 8 KB stack size
#define BLOCK_SIZE (32 * 1024)  // 32 KB block size

typedef uint32_t address_t;
typedef uint32_t word_t;

typedef struct superblock
{

  /** File system identifier. */
  uint32_t magic_cookie;

  /** Size of the device (in number of blocks). */
  uint32_t length;

  /** The starting block of the used/free bitmap. */
  block_number_t bitmap_block;

  /** The inode of the root directory. */
  block_number_t directory_block;

  /** The most recently allocated block number. */
  block_number_t mra_block;

} superblock_s;

typedef struct dt_entry
{
  word_t type;
  address_t base;
  address_t limit;
} dt_entry_s;

typedef struct DMA_portal
{
  address_t src;
  address_t dst;
  word_t length;
} DMA_portal_s;

typedef struct header
{
  word_t size;
  struct header *next;
  struct header *prev;
} header_s;

typedef struct MemoryBlock
{
  struct MemoryBlock *next;
  struct MemoryBlock *prev;
  address_t base;
} MemoryBlock_s;

typedef struct process_info
{
  int process_id;            // offset 0
  struct process_info *next; // offset 4
  struct process_info *prev; // offset 8

  address_t stack_base;  // offset 12
  address_t stack_limit; // offset 16

  address_t saved_stack_pointer; // offset 20
  address_t saved_pc;            // offset 24  <-- new field

  address_t entry_point; // offset 28

  MemoryBlock_s *ram_block; // offset 32
} process_info_s;

#endif
