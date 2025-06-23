# A test assembly program that does not much.

	.Code

_start:
	  li	t0,	13
	  addi	sp,	sp,	-4
	  sw	t0,	0(sp)
	  lw	a1,	0(sp)
	 li 	a1, 5
	 li	a0,	0xca110001	# Set the EXIT syscall code
	# j _start
	ecall
	
	

