// ==================================================================================================================================
/**
 * NevilleFS external tool
 * Allow the use of a file as a simulated block device to be formatted and used from outside of a block-device simulator.
 *
 * \file main.c
 **/
// ==================================================================================================================================



// ==================================================================================================================================
// INCLUDES
#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>

#include "bitmap.h"
#include "block-device.h"
#include "directory.h"
#include "inode.h"
#include "utilities.h"
// ==================================================================================================================================



// ==================================================================================================================================
/**
 * Initialize a new file system on the given block device.
 *
 * \param bd The block device on which to create a new file system.
 */
void format (block_device_s* bd) {
  
  initialize_superblock(bd);
  initialize_bitmap(bd);
  initialize_directory(bd);

} // format ()
// ==================================================================================================================================



// ==================================================================================================================================
/**
 * Given a path for a file in the host file system, copy that file into the block device's file system.
 *
 * \param bd       The block device.
 * \param src_path The host pathname to copy from.
 * \param dst_name The guest filename to copy to.
 */
void copy_in (block_device_s* bd, char* src_path, char* dst_name) {
  
  // Open the host file.
  int fd = open(src_path, O_RDONLY);
  if (fd == -1) ERROR("copy_in(): Failed to open file %s", src_path);

  // Get the file's size.
  struct stat filestat;
  if (fstat(fd, &filestat) != 0) ERROR("copy_in(): Failed to get the file length of %s\n", src_path);
  size_t length = filestat.st_size;

  // Copy the file's contents into a buffer.
  void* buffer = malloc(length);
  if (buffer == NULL) ERROR("copy_in(): Failed to allocate buffer\n");
  if (read(fd, buffer, length) != length) ERROR("copy_in(): Failed to read source file into buffer\n");
  
  // Allocate an inode for the new file.
  block_number_t inode_block = create_inode(bd);
  if (inode_block == 0) ERROR("copy_in(): Failed to allocate inode");

  // Add this file to the directory.
  add_directory_entry(bd, dst_name, inode_block);
  
  // Copy the contents of the source host file into the destination guest file.
  write_file(bd, buffer, length, inode_block);

  // Clean up.
  if (close(fd) != 0) ERROR("copy_in(): failed to close %s\n", src_path);

} // copy_in ()
// ==================================================================================================================================



// ==================================================================================================================================
/**
 * Given a file name in the guest file system, copy that file to the path in the host.
 *
 * \param bd       The block device.
 * \param dst_path The host pathname to copy to.
 * \param src_name The guest filename to copy from.
 */
void copy_out (block_device_s* bd, char* dst_path, char* src_name) {

  // Look up the source file and get its length.
  block_number_t inode_block = search_directory(bd, src_name);
  if(inode_block == 0) ERROR("copy_out(): Source file %s not found\n", src_name);
  int length = get_length(bd, inode_block);

  // Reads the entire file from the block device into a buffer.
  void* buffer = malloc(length);
  if (buffer == NULL) ERROR("copy_out(): Could not allocate buffer\n");
  read_file(bd, buffer, inode_block);

  // Open the host destination file and write the file contents.
  int fd = open(dst_path, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
  if (fd == -1) ERROR("copy_out(): Failed to open file %s", dst_path);
  if (write(fd, buffer, length) != length) ERROR("copy_out(): Failed to write destination file from buffer");

  // Clean up.
  if (close(fd) != 0) ERROR("copy_out(): failed to close %s\n", dst_path);
  
} // copy_out ()
// ==================================================================================================================================



// ==================================================================================================================================
/**
 * Remove a file from the directory, unlinking it from and potentially deleting the file object.
 *
 * \param bd       The block device on which the file system is stored.
 * \param filename The name to remove from the directory.
 */
void delete_file (block_device_s* bd, char* filename) {
  
  // Remove the directory entry, grabbing the inode block to which the entry led (if any).
  block_number_t inode_block = remove_directory_entry(bd, filename);
  if (inode_block == 0) ERROR("delete_file(): No such file in the directory");

  // Unlink from the inode.
  unlink_inode(bd, inode_block);

} // delete_file ()
// ==================================================================================================================================



// ==================================================================================================================================
/**
 * Emit the correct usage and exit.  *This function does not return*.
 *
 * \param msg        The error message about what necessitated this called.
 * \param invocation The string that invoked the program.
 */
void show_usage_and_exit (char* msg, char* invocation) {

  fprintf(stderr,
	  "ERROR: %s\n"
	  "USAGE: %s format <block device path>\n"
	  "          list   <block device path>\n"
	  "          cpin   <block device path> <source path> <destination filename>\n"
	  "          cpout  <block device path> <destination path> <source filename>\n"
	  "          delete <block device path> <filename>\n",
	  msg,
	  invocation);
  exit(EXIT_FAILURE);
  
} // show_usage_and_exit ()
// ==================================================================================================================================



// ==================================================================================================================================
/**
 * The entry point to the file system tool.
 *
 * \param argc The number of command-line arguments passed.
 * \param argv The command-line arguments themselves.
 */
int main (int argc, char** argv) {

  // Check usage and parse arguments.
  char* invocation = argv[0];
  if (argc < 3) show_usage_and_exit("Insufficient arguments", invocation);
  char* command   = argv[1];
  char* bd_path   = argv[2];

  // Map the block device.
  block_device_s* bd = bd_map(bd_path);
  if (bd == NULL) show_usage_and_exit("Block device could not be mapped", invocation);

  // +++++++++++ FORMAT +++++++++++
  if (strcmp(command, "format") == 0) {

    if (argc != 3) show_usage_and_exit("Too many arguments for format command", invocation);
    format(bd);

  }
  // +++++++++++ LIST +++++++++++
  else if (strcmp(command, "list") == 0) {

    if (argc != 3) show_usage_and_exit("Too many arguments for list command", invocation);
    list_directory(bd);

  }
  // +++++++++++ COPY IN +++++++++++
  else if (strcmp(command, "cpin") == 0) {

    if (argc != 5) show_usage_and_exit("Insufficient arguments for cpin command", invocation);
    char* source_path          = argv[3];
    char* destination_filename = argv[4];
    copy_in(bd, source_path, destination_filename);

  }
  // +++++++++++ COPY OUT +++++++++++
  else if (strcmp(command, "cpout") == 0) {

    if (argc != 5) show_usage_and_exit("Insufficient arguments for cpout command", invocation);
    char* destination_path = argv[3];
    char* source_filename  = argv[4];
    copy_out(bd, destination_path, source_filename);

  }
  // +++++++++++ DELETE +++++++++++
  else if (strcmp(command, "delete") == 0) {
    
    if (argc != 4) show_usage_and_exit("Insufficient arguments for delete command", invocation);
    char* filename = argv[3];
    delete_file(bd, filename);

  } else {
    
    show_usage_and_exit("Invalid command", invocation);

  }

  // Clean up.
  bd_unmap(bd);

} // main ()
// ==================================================================================================================================

