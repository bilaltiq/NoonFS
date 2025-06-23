// ==================================================================================================================================
/**
 * A set of structs and functions for managing a block device.
 *
 * \file block-device.h
 **/
// ==================================================================================================================================

// ==================================================================================================================================
// Avoid multiple inclusion.

#pragma once
// ==================================================================================================================================

// ==================================================================================================================================
// INCLUDES

#include <stdint.h>
#include "utilities.h"
// ==================================================================================================================================
// DEFINING BLOCK DEVICE SIZE (NOT SAME AS RAM BLOCK SIZE AKA MEMORY BLOCK)
#define BD_BLOCK_SIZE (4 * 1024) // 4KB block size

// ==================================================================================================================================
// TYPES AND STRUCTURES

/** The representation of a block number (or block length). */
typedef uint32_t block_number_t;

/** The information describing a simulated block device, backed by a file, mapped into the address space. */
typedef struct block_device
{

  /** The pathname of the file that is backing this simulated block device. */
  char *path;

  /** The open file descriptor. */
  int fd;

  /** The length of each block (in bytes). */
  int block_size;

  /** The length of the block device (in blocks). */
  block_number_t length;

  /** The base address at which the block device is mapped. */
  void *base;

  /** The limit address of the block device's mapping. */
  void *limit;

} block_device_s;
// ==================================================================================================================================

// ==================================================================================================================================
// EXPORTED FUNCTIONS

/**
 * Map a given file into the address space as a block device.
 *
 * \param path The file to map as a block device.
 * \return A pointer to a newly allocated and initialized block device if the mapping is successful; <code>NULL</code> otherwise.
 */
block_device_s *bd_map(char *path);

/**
 * Close and unmap the given mapped block device.  The block device is freed, so pointers to it should be nullified after this
 * operation.
 *
 * \param bd A pointer to a mapped block device.
 */
void bd_unmap(block_device_s *bd);

/**
 * Translate a block number for a given block device into a pointer to where that block is mapped.
 *
 * \param bd           A pointer to a mapped block device.
 * \param block_number The block number of the device sought.
 * \return A pointer to the given block number if valid; <code>NULL</code> otherwise.
 */
void *bd_block_to_ptr(block_device_s *bd, int block_number);

/**
 * Translate a pointer to a block within a mapped block device into a block number.
 *
 * \param bd A pointer to a mapped block device.
 * \param block_ptr A pointer to a block within the device's mapped space.
 * \return A block number if the pointer falls within the block device's mapped space; <code>-1</code> otherwise.
 */
int bd_ptr_to_block(block_device_s *bd, void *block_ptr);

/**
 * Print the fields of a block device.
 *
 * \param bd  A pointer to a mapped block device.
 * \param out The stream to which to print a textual representation.
 */
// void bd_print(block_device_s *bd, FILE *out);
// ==================================================================================================================================
