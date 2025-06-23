#include "kernel.c"
#include "inode.h"

void load_file(inode_s *inode)
{

    // Take the inode and load blocks into ram
    // THE 4KB is the block size
    // uint32_t starting_address = inode
    // to get the number of blocks we divide blocks / 4096
    uint32_t num_blocks = inode->length / 4096;

    // make sure to take upper cieling of the block
    if (inode->length % 4096 != 0)
    {
        num_blocks++;
    }

    // if num_blocks = 0 return error
    if (num_blocks == 0)
    {
        print("no user data blocks to load");
        return NULL;
    }

    MemoryBlock_s *memptr = assign_ram_block();
    address_t current_ptr = memptr->base;

    for (uint32_t i = 0; i < num_blocks; i++)
    {
        load_bd_block(inode->blocks[i], current_ptr);
        current_ptr += 4096;
    }
}