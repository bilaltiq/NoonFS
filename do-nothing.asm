# A test assembly program that does not much.

	.Code


_start:
	 li a7, 69
	  li	t0,	13
	  addi	sp,	sp,	-4
	  sw	t0,	0(sp)
	  lw	a1,	0(sp)
	# If you subtract string_bruh and start you can get the offset of the space that they are in, this is because we assume in print function that we are getting the offset and then we add the base to it!
	  la	t1, string_bruh
	  la 	t2, _start
	  sub a1, t1, t2
	  li	a0,	0xca110003	# Set the print syscall code	
	  ecall
	 li a1, 0
	 li	a0,	0xca110001	# Set the exit syscall code	
#	j _start
	ecall
	
	.Text

	string_bruh:			"this is a string bruh momento mori. \n"


	