// ==================================================================================================================================
/**
 * Inode/file types and functions.
 *
 * \file inode.h
 */
// ==================================================================================================================================



// ==================================================================================================================================
// Avoid multiple inclusion

#pragma once
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include <stdint.h>
#include "block-device.h"
// ==================================================================================================================================



// ==================================================================================================================================
// TYPES

#define DIRECT_BLOCK_SIZE 1016
#define MAX_FILE_SIZE(bd) (DIRECT_BLOCK_SIZE * bd->block_size)

typedef struct inode {

  /** Length of the file in bytes. */
  uint32_t length;

  /** Number of directory entries pointing to this inode. */
  uint32_t link_count;

  /** The time at which the file was created. */
  uint64_t creation_time;

  /** The time at which the file was last modified. */
  uint64_t modified_time;

  /** The time at which the file was last accessed. */
  uint64_t accessed_time;

  /** Direct block numbers containing file data. */
  block_number_t blocks[DIRECT_BLOCK_SIZE]; // SK: There needs to be a less brittle way to specify the length of this array.
  
} inode_s;
// ==================================================================================================================================



// ==================================================================================================================================
// FUNCTION PROTOTYPES

/**
 * Allocates and initializes an inode block for a new, empty file.
 * 
 * \param bd The block device storing the file system.
 * \return the block number of the newly allocated inode.
 */
block_number_t create_inode (block_device_s* bd);

/**
 * Copy the file represented by a given inode into a provided buffer.
 * 
 * \param bd          The block device storing the file system.
 * \param dst         The buffer into which to copy the file's contents.
 * \param inode_block The block number of the inode representing the file to be copied.
 */
void read_file (block_device_s* bd, void* dst, block_number_t inode_block);

/**
 * Copy a given buffer into a file given by its inode.
 * 
 * \param bd          The block device storing the file system.
 * \param src         The buffer from which to copy the file's contents.
 * \param length      The number of bytes to copy from the source buffer.
 * \param inode_block The block number of the inode representing the file to be written.
 */
void write_file (block_device_s* bd, void* src, uint32_t length, block_number_t inode_block);

/**
 * Returns the size of a file (given by inode) in bytes.
 * 
 * \param bd          The block device storing the file system.
 * \param inode_block The block number of the inode representing the file.
 * \return the size of the file in bytes.
 */
uint32_t get_length (block_device_s* bd, block_number_t inode_block);

/**
 * Increment the link count of an inode, used when a directory entry points to the file.
 * 
 * \param bd          The block device storing the file system.
 * \param inode_block The block number of the inode whose link count will be incremented.
 */
void link_inode (block_device_s* bd, block_number_t inode_block);

/**
 * Decrement the link count of an inode, used when a directory entry is removed for the file.  If the count falls to zero, the
 * file's blocks are freed.
 * 
 * \param bd          The block device storing the file system.
 * \param inode_block The block number of the inode to be deleted.
 */
void unlink_inode (block_device_s* bd, block_number_t inodeBlockNum);
// ==================================================================================================================================
