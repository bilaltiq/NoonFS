#include "types.h"
#include "load_inode.c"
#include "kernel.c"
#include "load_file.c"
#include "directory.h"

static directory_entry_s *directory;
static address_t dir_limit;
void preload_directory(block_number_t directory_inode_block_num, address_t superblock_buffer)
{
  // UNDER CONSTRUCTION: Rewrite this to load inode for directory
  // cast to int?
  int block_num = (int)directory_inode_block_num;
  // get limit of block
  dir_limit = (32 * 1024) + superblock_buffer;
  // get inode from directory block
  dir_inode = load_inode(block_num, dir_limit + 1);
  // replace superblock with directory
  load_file(dir_inode);
  directory = (directory_entry_s *)superblock_buffer;
}