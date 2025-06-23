// ==================================================================================================================================
/**
 * A set of structs and functions for managing a directory system.
 *
 * \file directory.h
 **/
// ==================================================================================================================================


// ==================================================================================================================================
// Avoid multiple inclusion.

#pragma once
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES

#include "block-device.h"
#include "inode.h"
// ==================================================================================================================================



// ==================================================================================================================================
// TYPES AND STRUCTURES

/** The maximum length of a filename. */
#define MAX_FILENAME_LEN 60

/** The form of a single entry in a directory. */
typedef struct directory_entry {

  /** The inode/file to which this entry maps; 0 if empty. */
  block_number_t inode_block;

  /** The filename, represented as a null-terminated string. */
  char           filename[MAX_FILENAME_LEN + 1];
  
} directory_entry_s;
// ==================================================================================================================================



// ==================================================================================================================================
// EXPORTED FUNCTIONS

/**
 * Initializes a directory on a given block device.  The initial directory will be empty.
 * 
 * \param bd The block device on which to create the root directory.
 */
void initialize_directory (block_device_s* bd); 

/**
 * Add an entry to the directory.
 *
 * \param bd          The block device containing the file system.
 * \param filename    Name of the file to add.
 * \param inode_block The block number of the inode for the file to add.
 * \return `true` if the entry was added; `false` if an entry with that name already existed and was re-used.
 */
bool add_directory_entry (block_device_s* bd, const char* filename, block_number_t inode_block);

/**
 * Removes a directory entry by name.
 *
 * \param bd       The block device containing the file system
 * \param filename Name of the file to remove.
 * \return the block number of the inode attached to the removed entry if found; 0 if not found.
 */
block_number_t remove_directory_entry (block_device_s* bd, const char* filename);

/**
 * Search for a directory entry by name.
 *
 * \param bd       The block device containing the file system.
 * \param filename The filename for which to search.
 * \return the block number of the inode attached to the sought entry if found; 0 if not found.
 */
block_number_t search_directory (block_device_s* bd, const char* filename);

/**
 * List the contents of the directory.
 *
 * \param bd The block device containing the file system.
 */
void list_directory (block_device_s* bd);
//==================================================================================================================================
