// ==================================================================================================================================
/**
 * Interface for the bitmap functions file
 * 
 * \file bitmap.h
 **/
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include <stdint.h>
#include <stdbool.h>
#include "superblock.h"
#include "utilities.h"
// ==================================================================================================================================



// ==================================================================================================================================
// TYPES AND CONSTANTS

/** The block number at which the bitmap begins. */
#define BITMAP_BLOCK 1
// ==================================================================================================================================



// ==================================================================================================================================
// FUNCTION PROTOTYPES

/**
 * Initialize a new bitmap.
 *
 * \param bd The block device on which to initialize the bitmap.
 */
void initialize_bitmap (block_device_s* bd);

/**
 * Allocate a single a single block and mark the block as used in the bitmap.
 *
 * \param bd The block device from which to allocate a block.
 * \return the allocated block's number upon success; 0 upon failure.
 */
block_number_t alloc_block (block_device_s* bd);

/**
 * Deallocate a block, marking it as free in the bitmap.
 *
 * \param bd The block device that contains the block to be deallocated.
 * \param block_number of block that needs to be deallocated
 */
void free_block (block_device_s* bd, uint32_t block_number);
// ==================================================================================================================================
