// ==================================================================================================================================
/**
 * Some pre-packaged functions that are useful everywhere.
 *
 * \file utilities.h
 **/
// ==================================================================================================================================

// ==================================================================================================================================
// Avoid multiple inclusion.

#pragma once
// ==================================================================================================================================

// ==================================================================================================================================
// INCLUDES

// #include <stdio.h>
// #include <stdlib.h>
// ==================================================================================================================================

// ==================================================================================================================================
// MACROS

/** The system's page size. */
#define PAGE_SIZE sysconf(_SC_PAGE_SIZE)

/** Calculate the number of bytes in `n` kilobytes. */
#define KB(n) ((size_t)n * 1024)

/** Calculate the number of bytes in `n` megabytes. */
#define MB(n) (KB(n) * 1024)

/** Calculate the number of bytes in `n` gigabytes. */
#define GB(n) (MB(n) * 1024)

/** The number of bits in a byte. */
#define BITS_PER_BYTE 8

/** The size of an address/word on this architecture. */
#define BYTES_PER_WORD sizeof(uintptr_t)

/** The number of bits in an address/word on this architecture. */
#define BITS_PER_WORD (BYTES_PER_WORD * BITS_PER_BYTE)

/** The minimum of two values. */
#define MIN(a, b) ((a < b) ? a : b)

/** The maximum of two values. */
#define MAX(a, b) ((a > b) ? a : b)

/** Emit an error message. */
#define ERROR(...)                  \
  {                                 \
    fprintf(stderr, "ERROR: ");     \
    fprintf(stderr, ##__VA_ARGS__); \
    exit(EXIT_FAILURE);             \
  }

/** Emit a debugging message (or, if disabled, remove such output). */
#if defined(DEBUG_MSGS)
#define DEBUG(...)                  \
  {                                 \
    fprintf(stderr, "DEBUG: ");     \
    fprintf(stderr, ##__VA_ARGS__); \
  }
#else
#define DEBUG(...)
#endif /* DEBUG_MSGS */
// ==================================================================================================================================

// ==================================================================================================================================
// EXPORTED FUNCTIONS

/**
 * Print an debugging message.
 *
 * \param msg  The string to emit as a message to `stderr`.
 * \param argc Count of the variadic arguments.
 * \param ...  The variadic arguments (0 or more) of integers to be appended to the output.
 */
void debug(const char *msg, int argc, ...);

/**
 * Print an error message and abort the process.  **Does not return**
 *
 * \param msg The string to emit as a message to `stderr`.
 * \param argc Count of the variadic arguments.
 * \param ...  The variadic arguments (0 or more) of integers to be appended to the output.
 */
void error(const char *msg, int argc, ...);
// ==================================================================================================================================
