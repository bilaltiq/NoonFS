#include "types.h"
#include "block-device.h"
#include "directory.h"
#include "inode.h"

uint32_t stringn_compare(char *a, char *b, uint32_t maxlen)
{
  uint32_t i = 0;
  while (i < maxlen && a[i] == b[i])
  {
    if (a[i] == '\0')
    {
      return 1;
    }
    i = i + 1;
  }
  return 0;
}

block_number_t directory_search(directory_entry_s *directory_base, char *filename, inode_s *size)
{
  // directory is length 60
  // each entry is length
  // dereference array to iterate through it using a list
  // if match reference address
  uint32_t len1 = size->length;
  uint32_t len = len1 / sizeof(directory_entry_s);
  directory_entry_s *tracker = directory_base;
  uint32_t maxlen = 60;
  for (uint32_t i = 0; i < len; i++)
  {
    char *check = tracker->filename;
    if (stringn_compare(filename, check, maxlen) == 1)
    {
      return tracker->inode_block;
    }
    tracker = tracker + 1;
  }
  return 0; // SYSCHECK???
}
