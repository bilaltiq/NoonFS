#include "kernel.c"

inode_s *load_inode(uint32_t inode_num, address_t *inode_buffer)
{

	// no need to allocate ram in here bc the space should already be alloced from copying in the directory
	// inode_buffer should be the limit of the buffer/ the base of the inode space

	// # load the inode block into the allocated space in ram
	load_bd_block(inode_num, inode_buffer);
	inode_s *inode = (inode_s *)inode_buffer;

	// # return pointer to inode space as an inode_s
	return inode;
}
