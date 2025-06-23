// ==================================================================================================================================
/**
 * Inode/file functions.
 *
 * \file inode.c
 */
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include <stdint.h>
#include <string.h>
#include <assert.h>
#include "bitmap.h"
#include "block-device.h"
#include "inode.h"
// ==================================================================================================================================



// ==================================================================================================================================
block_number_t create_inode (block_device_s* bd) {

  // Get a new block for this inode.
  block_number_t inode_block = alloc_block(bd);
  if (inode_block == 0) ERROR("create_inode(): Failed to allocate a block\n");

  // Initialize the inode's fields.
  inode_s* inode = bd_block_to_ptr(bd, inode_block);
  assert(inode != NULL);
  inode->length        = 0;
  inode->link_count    = 0;
  inode->creation_time = 0;
  inode->modified_time = 0;
  inode->accessed_time = 0;
  for (int i = 0; i < DIRECT_BLOCK_SIZE; i += 1) {
    inode->blocks[i] = 0;
  }

  return inode_block;
}
// ==================================================================================================================================



// ==================================================================================================================================
void read_file (block_device_s* bd, void* dst, block_number_t inode_block) {

  assert(bd  != NULL);
  assert(dst != NULL);

  // Grab the inode.
  inode_s* inode = bd_block_to_ptr(bd, inode_block);
  assert(inode != NULL);

  // Copy bytes from blocks, one block at a time, into the buffer.
  int bytes_remaining = inode->length;
  int block_number    = 0;
  while (bytes_remaining > 0) {

    // Read all the bytes from this block that are part of the file.
    int   bytes_to_copy = MIN(bytes_remaining, bd->block_size);
    void* src           = bd_block_to_ptr(bd, inode->blocks[block_number]);
    assert(src != NULL);
    memcpy(dst, src, bytes_to_copy);

    // Advance to the next block.
    dst             += bytes_to_copy;
    bytes_remaining -= bytes_to_copy;
    block_number    += 1;
    
  }
  
} // read_file ()
// ==================================================================================================================================



// ==================================================================================================================================
void write_file (block_device_s* bd, void* src, uint32_t length, block_number_t inode_block) {

  // Sanity checks.
  assert(bd  != NULL);
  assert(src != NULL);
  if (length > MAX_FILE_SIZE(bd)) ERROR("write_file(): Source length exceeds maximum file size\n");
  
  // Grab the inode.
  inode_s* inode = bd_block_to_ptr(bd, inode_block);
  assert(inode != NULL);

  // Determine how much copying needs to be done.
  inode->length = length;

  // Copy bytes from blocks, one block at a time, into the buffer.
  int bytes_remaining = inode->length;
  int block_number    = 0;
  while (bytes_remaining > 0) {

    // Allocate the next data block if needed.
    if (inode->blocks[block_number] == 0) {
      inode->blocks[block_number] = alloc_block(bd);
      if (inode->blocks[block_number] == 0) ERROR("write_file(): Failed to allocate data block\n");
    }
    
    // Write all the bytes to this block that are part of the file.
    int   bytes_to_copy = MIN(bytes_remaining, bd->block_size);
    void* dst           = bd_block_to_ptr(bd, inode->blocks[block_number]);
    assert(dst != NULL);
    memcpy(dst, src, bytes_to_copy);

    // Advance to the next block.
    src             += bytes_to_copy;
    bytes_remaining -= bytes_to_copy;
    block_number    += 1;
    
  }

  // Deallocate any old data blocks that are no longer in use by the inode.
  while (block_number < DIRECT_BLOCK_SIZE && inode->blocks[block_number] != 0) {
    free_block(bd, inode->blocks[block_number++]);
  }
  
} // write_file ()
// ==================================================================================================================================



// ==================================================================================================================================
uint32_t get_length (block_device_s* bd, block_number_t inode_block) {

  // Grab the inode and return the file's length.
  inode_s* inode = bd_block_to_ptr(bd, inode_block);
  assert(inode != NULL);
  return inode->length;
  
} // get_length ()
// ==================================================================================================================================



// ==================================================================================================================================
void link_inode (block_device_s* bd, block_number_t inode_block) {

  // Grab the inode and increment its link count.
  inode_s* inode = bd_block_to_ptr(bd, inode_block);
  assert(inode != NULL);
  inode->link_count += 1;

} // link_inode ()
// ==================================================================================================================================



// ==================================================================================================================================
void unlink_inode (block_device_s* bd, block_number_t inode_block) {

    // Grab the inode and decrement its link count.
    inode_s* inode = bd_block_to_ptr(bd, inode_block);
    assert(inode != NULL);
    inode->link_count -= 1;

    // If there are no links to this file, delete it.
    if(inode->link_count == 0){

      // Deallocate any allocated data blocks.  As a sanity check, make sure that once we find an empty slot, the rest are also
      // empty.
      bool zero_found = false;
      for (int block_number = 0; block_number < DIRECT_BLOCK_SIZE; block_number += 1) {

	// If there is a data block at this slot, free it.
	if (inode->blocks[block_number] != 0) {
	    assert(!zero_found);
            free_block(bd, inode->blocks[block_number]);
        } else {
	  zero_found = true;
	}

      }

      // Free the inode itself.
      free_block(bd, inode_block);

    }
    
} // unlink_inode ()
// ==================================================================================================================================

