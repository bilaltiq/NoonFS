	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_zmmul1p0"
	.file	"kernel.c"
	.globl	int_to_hex                      # -- Begin function int_to_hex
	.p2align	2
	.type	int_to_hex,@function
int_to_hex:                             # @int_to_hex
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 28
	sw	a0, -20(s0)
	j	kernel_LBB0_1
kernel_LBB0_1:                                # =>This Innerkernel_Loop Header: Depth=1
	lw	a0, -20(s0)
	bltz	a0, kernel_LBB0_4
	j	kernel_LBB0_2
kernel_LBB0_2:                                #   inkernel_Loop: Header=BB0_1 Depth=1
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	srl	a0, a0, a1
	andi	a0, a0, 15
	sw	a0, -24(s0)
	lw	a1, -24(s0)
	lui	a0, %hi(hex_digits)
	addi	a0, a0, %lo(hex_digits)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	lw	a1, -16(s0)
	addi	a2, a1, 1
	sw	a2, -16(s0)
	sb	a0, 0(a1)
	j	kernel_LBB0_3
kernel_LBB0_3:                                #   inkernel_Loop: Header=BB0_1 Depth=1
	lw	a0, -20(s0)
	addi	a0, a0, -4
	sw	a0, -20(s0)
	j	kernel_LBB0_1
kernel_LBB0_4:
	lw	a1, -16(s0)
	li	a0, 0
	sb	a0, 0(a1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
kernel_Lfunc_end0:
	.size	int_to_hex, kernel_Lfunc_end0-int_to_hex
                                        # -- End function
	.globl	run_programs                    # -- Begin function run_programs
	.p2align	2
	.type	run_programs,@function
run_programs:                           # @run_programs
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	lui	a0, %hi(kernel_L.str)
	addi	a0, a0, %lo(kernel_L.str)
	call	print
	lui	a0, %hi(run_programs.next_program_ROM)
	sw	a0, -28(s0)                     # 4-byte Folded Spill
	lw	a0, %lo(run_programs.next_program_ROM)(a0)
	addi	a1, s0, -17
	sw	a1, -32(s0)                     # 4-byte Folded Spill
	call	int_to_hex
	lw	a0, -32(s0)                     # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.1)
	addi	a0, a0, %lo(kernel_L.str.1)
	call	print
	lw	a3, -28(s0)                     # 4-byte Folded Reload
	lui	a0, %hi(ROM_device_code)
	lw	a0, %lo(ROM_device_code)(a0)
	lw	a1, %lo(run_programs.next_program_ROM)(a3)
	addi	a2, a1, 1
	sw	a2, %lo(run_programs.next_program_ROM)(a3)
	call	find_device
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	bnez	a0, kernel_LBB1_2
	j	kernel_LBB1_1
kernel_LBB1_1:
	j	kernel_LBB1_3
kernel_LBB1_2:
	lui	a0, %hi(run_programs.next_program_ROM)
	lw	a0, %lo(run_programs.next_program_ROM)(a0)
	lui	a1, %hi(current_ROM)
	sw	a0, %lo(current_ROM)(a1)
	lw	a0, -24(s0)
	lw	a0, 4(a0)
	lui	a2, %hi(DMA_portal_ptr)
	lw	a1, %lo(DMA_portal_ptr)(a2)
	sw	a0, 0(a1)
	lui	a0, %hi(kernel_limit)
	lw	a1, %lo(kernel_limit)(a0)
	lw	a3, %lo(DMA_portal_ptr)(a2)
	sw	a1, 4(a3)
	lw	a3, -24(s0)
	lw	a1, 8(a3)
	lw	a3, 4(a3)
	sub	a1, a1, a3
	lw	a2, %lo(DMA_portal_ptr)(a2)
	sw	a1, 8(a2)
	lw	a0, %lo(kernel_limit)(a0)
	call	userspace_jump
	j	kernel_LBB1_3
kernel_LBB1_3:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
kernel_Lfunc_end1:
	.size	run_programs, kernel_Lfunc_end1-run_programs
                                        # -- End function
	.globl	run_specific_program            # -- Begin function run_specific_program
	.p2align	2
	.type	run_specific_program,@function
run_specific_program:                   # @run_specific_program
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 48
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a0, -12(s0)
	addi	a1, s0, -25
	sw	a1, -36(s0)                     # 4-byte Folded Spill
	call	int_to_hex
	lw	a0, -36(s0)                     # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.1)
	addi	a0, a0, %lo(kernel_L.str.1)
	call	print
	lui	a0, %hi(ROM_device_code)
	lw	a0, %lo(ROM_device_code)(a0)
	lw	a1, -12(s0)
	call	find_device
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	bnez	a0, kernel_LBB2_2
	j	kernel_LBB2_1
kernel_LBB2_1:
	j	kernel_LBB2_3
kernel_LBB2_2:
	lw	a0, -12(s0)
	lui	a1, %hi(current_ROM)
	sw	a0, %lo(current_ROM)(a1)
	lw	a0, -32(s0)
	lw	a0, 4(a0)
	lui	a1, %hi(DMA_portal_ptr)
	lw	a2, %lo(DMA_portal_ptr)(a1)
	sw	a0, 0(a2)
	lw	a0, -16(s0)
	lw	a2, %lo(DMA_portal_ptr)(a1)
	sw	a0, 4(a2)
	lw	a2, -32(s0)
	lw	a0, 8(a2)
	lw	a2, 4(a2)
	sub	a0, a0, a2
	lw	a1, %lo(DMA_portal_ptr)(a1)
	sw	a0, 8(a1)
	j	kernel_LBB2_3
kernel_LBB2_3:
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
kernel_Lfunc_end2:
	.size	run_specific_program, kernel_Lfunc_end2-run_specific_program
                                        # -- End function
	.globl	do_print                        # -- Begin function do_print
	.p2align	2
	.type	do_print,@function
do_print:                               # @do_print
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	lui	a1, %hi(current_process)
	lw	a1, %lo(current_process)(a1)
	lw	a1, 32(a1)
	lw	a1, 8(a1)
	add	a0, a0, a1
	sw	a0, -16(s0)
	lw	a0, -16(s0)
	call	print
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end3:
	.size	do_print, kernel_Lfunc_end3-do_print
                                        # -- End function
	.globl	heap_init                       # -- Begin function heap_init
	.p2align	2
	.type	heap_init,@function
heap_init:                              # @heap_init
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	lui	a0, %hi(heap_limit)
	lw	a0, %lo(heap_limit)(a0)
	beqz	a0, kernel_LBB4_2
	j	kernel_LBB4_1
kernel_LBB4_1:
	j	kernel_LBB4_3
kernel_LBB4_2:
	lui	a1, %hi(heap_limit)
	lui	a0, %hi(statics_limit)
	addi	a0, a0, %lo(statics_limit)
	sw	a0, %lo(heap_limit)(a1)
	lui	a0, %hi(free_head)
	addi	a0, a0, %lo(free_head)
	lui	a1, %hi(free_tail)
	addi	a1, a1, %lo(free_tail)
	sw	a1, 4(a0)
	sw	a0, 8(a1)
	j	kernel_LBB4_3
kernel_LBB4_3:
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end4:
	.size	heap_init, kernel_Lfunc_end4-heap_init
                                        # -- End function
	.globl	allocate                        # -- Begin function allocate
	.p2align	2
	.type	allocate,@function
allocate:                               # @allocate
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	call	heap_init
	lbu	a0, -12(s0)
	andi	a0, a0, 3
	bnez	a0, kernel_LBB5_2
	j	kernel_LBB5_1
kernel_LBB5_1:
	lw	a0, -12(s0)
	sw	a0, -24(s0)                     # 4-byte Folded Spill
	j	kernel_LBB5_3
kernel_LBB5_2:
	lw	a0, -12(s0)
	addi	a0, a0, 4
	andi	a0, a0, 3
	sw	a0, -24(s0)                     # 4-byte Folded Spill
	j	kernel_LBB5_3
kernel_LBB5_3:
	lw	a0, -24(s0)                     # 4-byte Folded Reload
	sw	a0, -12(s0)
	lui	a0, %hi(free_head)
	addi	a0, a0, %lo(free_head)
	lw	a0, 4(a0)
	sw	a0, -16(s0)
	j	kernel_LBB5_4
kernel_LBB5_4:                                # =>This Innerkernel_Loop Header: Depth=1
	lw	a0, -16(s0)
	lui	a1, %hi(free_tail)
	addi	a1, a1, %lo(free_tail)
	beq	a0, a1, kernel_LBB5_9
	j	kernel_LBB5_5
kernel_LBB5_5:                                #   inkernel_Loop: Header=BB5_4 Depth=1
	lw	a0, -16(s0)
	lw	a0, 0(a0)
	lw	a1, -12(s0)
	bltu	a0, a1, kernel_LBB5_7
	j	kernel_LBB5_6
kernel_LBB5_6:
	lw	a1, -16(s0)
	lw	a0, 4(a1)
	lw	a1, 8(a1)
	sw	a0, 4(a1)
	lw	a1, -16(s0)
	lw	a0, 8(a1)
	lw	a1, 4(a1)
	sw	a0, 8(a1)
	lw	a1, -16(s0)
	li	a0, 0
	sw	a0, 4(a1)
	lw	a1, -16(s0)
	sw	a0, 8(a1)
	j	kernel_LBB5_9
kernel_LBB5_7:                                #   inkernel_Loop: Header=BB5_4 Depth=1
	lw	a0, -16(s0)
	lw	a0, 4(a0)
	sw	a0, -16(s0)
	j	kernel_LBB5_8
kernel_LBB5_8:                                #   inkernel_Loop: Header=BB5_4 Depth=1
	j	kernel_LBB5_4
kernel_LBB5_9:
	lw	a0, -16(s0)
	lui	a1, %hi(free_tail)
	addi	a1, a1, %lo(free_tail)
	bne	a0, a1, kernel_LBB5_11
	j	kernel_LBB5_10
kernel_LBB5_10:
	lw	a0, -12(s0)
	addi	a0, a0, 12
	sw	a0, -20(s0)
	lui	a1, %hi(heap_limit)
	lw	a0, %lo(heap_limit)(a1)
	sw	a0, -16(s0)
	lw	a0, -12(s0)
	lw	a2, -16(s0)
	sw	a0, 0(a2)
	lw	a2, -20(s0)
	lw	a0, %lo(heap_limit)(a1)
	add	a0, a0, a2
	sw	a0, %lo(heap_limit)(a1)
	j	kernel_LBB5_11
kernel_LBB5_11:
	lw	a0, -16(s0)
	addi	a0, a0, 12
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
kernel_Lfunc_end5:
	.size	allocate, kernel_Lfunc_end5-allocate
                                        # -- End function
	.globl	deallocate                      # -- Begin function deallocate
	.p2align	2
	.type	deallocate,@function
deallocate:                             # @deallocate
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	bnez	a0, kernel_LBB6_2
	j	kernel_LBB6_1
kernel_LBB6_1:
	j	kernel_LBB6_3
kernel_LBB6_2:
	lw	a0, -12(s0)
	addi	a0, a0, -12
	sw	a0, -16(s0)
	lui	a1, %hi(free_head)
	addi	a1, a1, %lo(free_head)
	lw	a0, 4(a1)
	lw	a2, -16(s0)
	sw	a0, 4(a2)
	lw	a0, -16(s0)
	sw	a1, 8(a0)
	lw	a0, -16(s0)
	lw	a2, 4(a1)
	sw	a0, 8(a2)
	lw	a0, -16(s0)
	sw	a0, 4(a1)
	j	kernel_LBB6_3
kernel_LBB6_3:
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end6:
	.size	deallocate, kernel_Lfunc_end6-deallocate
                                        # -- End function
	.globl	malloc_custom                   # -- Begin function malloc_custom
	.p2align	2
	.type	malloc_custom,@function
malloc_custom:                          # @malloc_custom
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	call	allocate
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end7:
	.size	malloc_custom, kernel_Lfunc_end7-malloc_custom
                                        # -- End function
	.globl	free_custom                     # -- Begin function free_custom
	.p2align	2
	.type	free_custom,@function
free_custom:                            # @free_custom
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	call	deallocate
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end8:
	.size	free_custom, kernel_Lfunc_end8-free_custom
                                        # -- End function
	.globl	unendianify                     # -- Begin function unendianify
	.p2align	2
	.type	unendianify,@function
unendianify:                            # @unendianify
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a1, -12(s0)
	slli	a0, a1, 24
	lui	a2, 16
	addi	a2, a2, -256
	and	a2, a1, a2
	slli	a2, a2, 8
	or	a0, a0, a2
	lui	a2, 4080
	and	a2, a1, a2
	srli	a2, a2, 8
	or	a0, a0, a2
	srli	a1, a1, 24
	or	a0, a0, a1
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end9:
	.size	unendianify, kernel_Lfunc_end9-unendianify
                                        # -- End function
	.globl	init_RAM_blocks                 # -- Begin function init_RAM_blocks
	.p2align	2
	.type	init_RAM_blocks,@function
init_RAM_blocks:                        # @init_RAM_blocks
# %bb.0:
	addi	sp, sp, -112
	sw	ra, 108(sp)                     # 4-byte Folded Spill
	sw	s0, 104(sp)                     # 4-byte Folded Spill
	addi	s0, sp, 112
	lui	a0, %hi(kernel_limit)
	sw	a0, -96(s0)                     # 4-byte Folded Spill
	lw	a0, %lo(kernel_limit)(a0)
	sw	a0, -12(s0)
	li	a0, 1
	sw	a0, -16(s0)
	lui	a0, %hi(RAM_device_code)
	lw	a0, %lo(RAM_device_code)(a0)
	lw	a1, -16(s0)
	call	find_device
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	lw	a0, 8(a0)
	sw	a0, -24(s0)
	lui	a1, %hi(free_block_list)
	li	a0, 0
	sw	a0, %lo(free_block_list)(a1)
	sw	a0, -28(s0)
	lui	a0, %hi(kernel_L.str.2)
	addi	a0, a0, %lo(kernel_L.str.2)
	call	print
	lw	a0, -96(s0)                     # 4-byte Folded Reload
	lw	a0, %lo(kernel_limit)(a0)
	addi	a1, s0, -37
	sw	a1, -92(s0)                     # 4-byte Folded Spill
	call	int_to_hex
	lw	a0, -92(s0)                     # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.1)
	addi	a0, a0, %lo(kernel_L.str.1)
	sw	a0, -88(s0)                     # 4-byte Folded Spill
	call	print
	lui	a0, %hi(kernel_L.str.3)
	addi	a0, a0, %lo(kernel_L.str.3)
	call	print
	lw	a1, -92(s0)                     # 4-byte Folded Reload
	lw	a0, -24(s0)
	call	int_to_hex
	lw	a0, -92(s0)                     # 4-byte Folded Reload
	call	print
	lw	a0, -88(s0)                     # 4-byte Folded Reload
	call	print
	lw	a0, -12(s0)
	sw	a0, -44(s0)
	j	kernel_LBB10_1
kernel_LBB10_1:                               # =>This Innerkernel_Loop Header: Depth=1
	lw	a0, -44(s0)
	lui	a1, 8
	add	a1, a0, a1
	lw	a0, -24(s0)
	bltu	a0, a1, kernel_LBB10_8
	j	kernel_LBB10_2
kernel_LBB10_2:                               #   inkernel_Loop: Header=BB10_1 Depth=1
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	li	a0, 12
	call	malloc_custom
	sw	a0, -48(s0)
	lw	a0, -48(s0)
	addi	a1, s0, -57
	sw	a1, -100(s0)                    # 4-byte Folded Spill
	call	int_to_hex
	lui	a0, %hi(kernel_L.str.4)
	addi	a0, a0, %lo(kernel_L.str.4)
	call	print
	lw	a0, -100(s0)                    # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.1)
	addi	a0, a0, %lo(kernel_L.str.1)
	call	print
	lw	a0, -48(s0)
	bnez	a0, kernel_LBB10_4
	j	kernel_LBB10_3
kernel_LBB10_3:
	lui	a0, %hi(kernel_L.str.5)
	addi	a0, a0, %lo(kernel_L.str.5)
	call	print
	j	kernel_LBB10_8
kernel_LBB10_4:                               #   inkernel_Loop: Header=BB10_1 Depth=1
	lw	a0, -44(s0)
	lw	a1, -48(s0)
	sw	a0, 8(a1)
	lw	a0, -48(s0)
	li	a1, 0
	sw	a1, 0(a0)
	lw	a0, -48(s0)
	sw	a1, 4(a0)
	lui	a0, %hi(free_block_list)
	lw	a2, %lo(free_block_list)(a0)
	lw	a3, -48(s0)
	sw	a2, 0(a3)
	lw	a2, -48(s0)
	sw	a1, 4(a2)
	lw	a0, %lo(free_block_list)(a0)
	beqz	a0, kernel_LBB10_6
	j	kernel_LBB10_5
kernel_LBB10_5:                               #   inkernel_Loop: Header=BB10_1 Depth=1
	lw	a0, -48(s0)
	lui	a1, %hi(free_block_list)
	lw	a1, %lo(free_block_list)(a1)
	sw	a0, 4(a1)
	j	kernel_LBB10_6
kernel_LBB10_6:                               #   inkernel_Loop: Header=BB10_1 Depth=1
	lw	a0, -48(s0)
	lui	a1, %hi(free_block_list)
	sw	a1, -108(s0)                    # 4-byte Folded Spill
	sw	a0, %lo(free_block_list)(a1)
	lui	a0, %hi(kernel_L.str.6)
	addi	a0, a0, %lo(kernel_L.str.6)
	call	print
	lw	a0, -108(s0)                    # 4-byte Folded Reload
	lw	a0, %lo(free_block_list)(a0)
	lw	a0, 8(a0)
	addi	a1, s0, -66
	sw	a1, -104(s0)                    # 4-byte Folded Spill
	call	int_to_hex
	lw	a0, -104(s0)                    # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.1)
	addi	a0, a0, %lo(kernel_L.str.1)
	call	print
	j	kernel_LBB10_7
kernel_LBB10_7:                               #   inkernel_Loop: Header=BB10_1 Depth=1
	lw	a0, -44(s0)
	lui	a1, 8
	add	a0, a0, a1
	sw	a0, -44(s0)
	j	kernel_LBB10_1
kernel_LBB10_8:
	lui	a0, %hi(kernel_L.str.7)
	addi	a0, a0, %lo(kernel_L.str.7)
	call	print
	lui	a0, %hi(free_block_list)
	lw	a0, %lo(free_block_list)(a0)
	sw	a0, -72(s0)
	j	kernel_LBB10_9
kernel_LBB10_9:                               # =>This Innerkernel_Loop Header: Depth=1
	lw	a0, -72(s0)
	beqz	a0, kernel_LBB10_11
	j	kernel_LBB10_10
kernel_LBB10_10:                              #   inkernel_Loop: Header=BB10_9 Depth=1
	lui	a0, %hi(kernel_L.str.8)
	addi	a0, a0, %lo(kernel_L.str.8)
	call	print
	lw	a0, -72(s0)
	lw	a0, 8(a0)
	addi	a1, s0, -81
	sw	a1, -112(s0)                    # 4-byte Folded Spill
	call	int_to_hex
	lw	a0, -112(s0)                    # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.1)
	addi	a0, a0, %lo(kernel_L.str.1)
	call	print
	lw	a0, -72(s0)
	lw	a0, 0(a0)
	sw	a0, -72(s0)
	j	kernel_LBB10_9
kernel_LBB10_11:
	lw	ra, 108(sp)                     # 4-byte Folded Reload
	lw	s0, 104(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 112
	ret
kernel_Lfunc_end10:
	.size	init_RAM_blocks, kernel_Lfunc_end10-init_RAM_blocks
                                        # -- End function
	.globl	free_RAM_block                  # -- Begin function free_RAM_block
	.p2align	2
	.type	free_RAM_block,@function
free_RAM_block:                         # @free_RAM_block
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	call	deallocate
	lui	a1, %hi(free_block_list)
	lw	a0, %lo(free_block_list)(a1)
	lw	a2, -12(s0)
	sw	a0, 0(a2)
	lw	a0, -12(s0)
	sw	a0, %lo(free_block_list)(a1)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end11:
	.size	free_RAM_block, kernel_Lfunc_end11-free_RAM_block
                                        # -- End function
	.globl	assign_ram_block                # -- Begin function assign_ram_block
	.p2align	2
	.type	assign_ram_block,@function
assign_ram_block:                       # @assign_ram_block
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	lui	a0, %hi(free_block_list)
	lw	a0, %lo(free_block_list)(a0)
	bnez	a0, kernel_LBB12_2
	j	kernel_LBB12_1
kernel_LBB12_1:
	li	a0, 0
	sw	a0, -12(s0)
	j	kernel_LBB12_5
kernel_LBB12_2:
	lui	a0, %hi(free_block_list)
	lw	a1, %lo(free_block_list)(a0)
	sw	a1, -16(s0)
	lw	a1, -16(s0)
	lw	a1, 0(a1)
	sw	a1, %lo(free_block_list)(a0)
	lw	a0, %lo(free_block_list)(a0)
	beqz	a0, kernel_LBB12_4
	j	kernel_LBB12_3
kernel_LBB12_3:
	lui	a0, %hi(free_block_list)
	lw	a1, %lo(free_block_list)(a0)
	li	a0, 0
	sw	a0, 4(a1)
	j	kernel_LBB12_4
kernel_LBB12_4:
	lw	a1, -16(s0)
	li	a0, 0
	sw	a0, 0(a1)
	lw	a1, -16(s0)
	sw	a0, 4(a1)
	lui	a0, %hi(kernel_L.str.9)
	addi	a0, a0, %lo(kernel_L.str.9)
	call	print
	lw	a0, -16(s0)
	sw	a0, -12(s0)
	j	kernel_LBB12_5
kernel_LBB12_5:
	lw	a0, -12(s0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end12:
	.size	assign_ram_block, kernel_Lfunc_end12-assign_ram_block
                                        # -- End function
	.globl	load_bd_block                   # -- Begin function load_bd_block
	.p2align	2
	.type	load_bd_block,@function
load_bd_block:                          # @load_bd_block
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lui	a0, %hi(block_device_code)
	lw	a0, %lo(block_device_code)(a0)
	li	a1, 1
	call	find_device
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	bnez	a0, kernel_LBB13_2
	j	kernel_LBB13_1
kernel_LBB13_1:
	lui	a0, %hi(kernel_L.str.10)
	addi	a0, a0, %lo(kernel_L.str.10)
	call	print
	j	kernel_LBB13_3
kernel_LBB13_2:
	lui	a0, %hi(kernel_L.str.11)
	addi	a0, a0, %lo(kernel_L.str.11)
	call	print
	lw	a0, -20(s0)
	lw	a0, 8(a0)
	addi	a0, a0, -8
	sw	a0, -24(s0)
	lw	a0, -12(s0)
	lw	a1, -24(s0)
	sw	a0, 0(a1)
	lw	a0, -20(s0)
	lw	a0, 8(a0)
	addi	a0, a0, -4
	sw	a0, -28(s0)
	lw	a1, -28(s0)
	li	a0, 0
	sw	a0, 0(a1)
	lw	a0, -20(s0)
	lw	a1, 4(a0)
	lui	a0, %hi(DMA_portal_ptr)
	lw	a2, %lo(DMA_portal_ptr)(a0)
	sw	a1, 0(a2)
	lw	a1, -16(s0)
	lw	a2, %lo(DMA_portal_ptr)(a0)
	sw	a1, 4(a2)
	lw	a1, %lo(DMA_portal_ptr)(a0)
	lui	a0, 1
	sw	a0, 8(a1)
	j	kernel_LBB13_3
kernel_LBB13_3:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
kernel_Lfunc_end13:
	.size	load_bd_block, kernel_Lfunc_end13-load_bd_block
                                        # -- End function
	.globl	load_inode                      # -- Begin function load_inode
	.p2align	2
	.type	load_inode,@function
load_inode:                             # @load_inode
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a0, -12(s0)
	call	unendianify
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	lw	a1, -16(s0)
	call	load_bd_block
	lw	a0, -16(s0)
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
kernel_Lfunc_end14:
	.size	load_inode, kernel_Lfunc_end14-load_inode
                                        # -- End function
	.globl	load_file                       # -- Begin function load_file
	.p2align	2
	.type	load_file,@function
load_file:                              # @load_file
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	lui	a0, %hi(kernel_L.str.12)
	addi	a0, a0, %lo(kernel_L.str.12)
	call	print
	lw	a0, -12(s0)
	lw	a0, 0(a0)
	call	unendianify
	srli	a0, a0, 12
	sw	a0, -16(s0)
	lw	a0, -12(s0)
	lw	a0, 0(a0)
	call	unendianify
	slli	a0, a0, 20
	beqz	a0, kernel_LBB15_2
	j	kernel_LBB15_1
kernel_LBB15_1:
	lw	a0, -16(s0)
	addi	a0, a0, 1
	sw	a0, -16(s0)
	j	kernel_LBB15_2
kernel_LBB15_2:
	lw	a0, -16(s0)
	bnez	a0, kernel_LBB15_4
	j	kernel_LBB15_3
kernel_LBB15_3:
	lui	a0, %hi(kernel_L.str.13)
	addi	a0, a0, %lo(kernel_L.str.13)
	call	print
	j	kernel_LBB15_9
kernel_LBB15_4:
	call	assign_ram_block
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	lw	a0, 8(a0)
	sw	a0, -24(s0)
	li	a0, 0
	sw	a0, -28(s0)
	j	kernel_LBB15_5
kernel_LBB15_5:                               # =>This Innerkernel_Loop Header: Depth=1
	lw	a0, -28(s0)
	lw	a1, -16(s0)
	bgeu	a0, a1, kernel_LBB15_8
	j	kernel_LBB15_6
kernel_LBB15_6:                               #   inkernel_Loop: Header=BB15_5 Depth=1
	lw	a0, -12(s0)
	lw	a1, -28(s0)
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 32(a0)
	call	unendianify
	lw	a1, -24(s0)
	call	load_bd_block
	lw	a0, -24(s0)
	lui	a1, 1
	add	a0, a0, a1
	sw	a0, -24(s0)
	j	kernel_LBB15_7
kernel_LBB15_7:                               #   inkernel_Loop: Header=BB15_5 Depth=1
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	j	kernel_LBB15_5
kernel_LBB15_8:
	lui	a0, %hi(kernel_L.str.14)
	addi	a0, a0, %lo(kernel_L.str.14)
	call	print
	j	kernel_LBB15_9
kernel_LBB15_9:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
kernel_Lfunc_end15:
	.size	load_file, kernel_Lfunc_end15-load_file
                                        # -- End function
	.globl	preload_directory               # -- Begin function preload_directory
	.p2align	2
	.type	preload_directory,@function
preload_directory:                      # @preload_directory
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 48
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lui	a0, %hi(kernel_L.str.15)
	addi	a0, a0, %lo(kernel_L.str.15)
	call	print
	lw	a0, -12(s0)
	call	unendianify
	addi	a1, s0, -25
	sw	a1, -40(s0)                     # 4-byte Folded Spill
	call	int_to_hex
	lw	a0, -40(s0)                     # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.1)
	addi	a0, a0, %lo(kernel_L.str.1)
	call	print
	lw	a0, -16(s0)
	lw	a0, 8(a0)
	sw	a0, -32(s0)
	lw	a0, -12(s0)
	lw	a1, -32(s0)
	call	load_inode
	sw	a0, -36(s0)
	lw	a0, -32(s0)
	lui	a1, 1
	add	a0, a0, a1
	sw	a0, -32(s0)
	lw	a0, -36(s0)
	call	load_file
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
kernel_Lfunc_end16:
	.size	preload_directory, kernel_Lfunc_end16-preload_directory
                                        # -- End function
	.globl	preload_fs                      # -- Begin function preload_fs
	.p2align	2
	.type	preload_fs,@function
preload_fs:                             # @preload_fs
# %bb.0:
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 64
	lui	a0, %hi(kernel_L.str.16)
	addi	a0, a0, %lo(kernel_L.str.16)
	call	print
	call	assign_ram_block
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	bnez	a0, kernel_LBB17_2
	j	kernel_LBB17_1
kernel_LBB17_1:
	lui	a0, %hi(kernel_L.str.17)
	addi	a0, a0, %lo(kernel_L.str.17)
	call	print
	j	kernel_LBB17_3
kernel_LBB17_2:
	lui	a0, %hi(kernel_L.str.18)
	addi	a0, a0, %lo(kernel_L.str.18)
	call	print
	lw	a0, -12(s0)
	lw	a0, 8(a0)
	addi	a1, s0, -21
	sw	a1, -64(s0)                     # 4-byte Folded Spill
	call	int_to_hex
	lw	a0, -64(s0)                     # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.1)
	addi	a0, a0, %lo(kernel_L.str.1)
	sw	a0, -52(s0)                     # 4-byte Folded Spill
	call	print
	lw	a0, -12(s0)
	lw	a1, 8(a0)
	li	a0, 0
	call	load_bd_block
	lui	a0, %hi(kernel_L.str.19)
	addi	a0, a0, %lo(kernel_L.str.19)
	call	print
	lw	a0, -12(s0)
	lw	a0, 8(a0)
	sw	a0, -28(s0)
	lui	a0, %hi(kernel_L.str.20)
	addi	a0, a0, %lo(kernel_L.str.20)
	call	print
	lw	a0, -28(s0)
	lw	a0, 0(a0)
	call	unendianify
	addi	a1, s0, -37
	sw	a1, -60(s0)                     # 4-byte Folded Spill
	call	int_to_hex
	lw	a0, -60(s0)                     # 4-byte Folded Reload
	call	print
	lw	a0, -52(s0)                     # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.21)
	addi	a0, a0, %lo(kernel_L.str.21)
	call	print
	lw	a0, -28(s0)
	lw	a0, 4(a0)
	call	unendianify
	addi	a1, s0, -46
	sw	a1, -56(s0)                     # 4-byte Folded Spill
	call	int_to_hex
	lw	a0, -56(s0)                     # 4-byte Folded Reload
	call	print
	lw	a0, -52(s0)                     # 4-byte Folded Reload
	call	print
	lw	a0, -28(s0)
	lw	a0, 12(a0)
	lw	a1, -12(s0)
	call	preload_directory
	j	kernel_LBB17_3
kernel_LBB17_3:
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
kernel_Lfunc_end17:
	.size	preload_fs, kernel_Lfunc_end17-preload_fs
                                        # -- End function
	.globl	RAM_load_block                  # -- Begin function RAM_load_block
	.p2align	2
	.type	RAM_load_block,@function
RAM_load_block:                         # @RAM_load_block
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 48
	sw	a0, -16(s0)
	sw	a1, -20(s0)
	sw	a2, -24(s0)
	call	assign_ram_block
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	bnez	a0, kernel_LBB18_2
	j	kernel_LBB18_1
kernel_LBB18_1:
	lui	a0, %hi(kernel_L.str.22)
	addi	a0, a0, %lo(kernel_L.str.22)
	call	print
	li	a0, 0
	sw	a0, -12(s0)
	j	kernel_LBB18_3
kernel_LBB18_2:
	lw	a0, -28(s0)
	lui	a1, %hi(current_process)
	lw	a1, %lo(current_process)(a1)
	sw	a0, 32(a1)
	li	a0, 5
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	lw	a1, -24(s0)
	call	find_device
	sw	a0, -36(s0)
	lw	a0, -36(s0)
	lw	a0, 4(a0)
	lui	a1, %hi(DMA_portal_ptr)
	lw	a2, %lo(DMA_portal_ptr)(a1)
	sw	a0, 0(a2)
	lw	a0, -16(s0)
	lw	a2, %lo(DMA_portal_ptr)(a1)
	sw	a0, 4(a2)
	lw	a2, -36(s0)
	lw	a0, 8(a2)
	lw	a2, 4(a2)
	sub	a0, a0, a2
	lw	a1, %lo(DMA_portal_ptr)(a1)
	sw	a0, 8(a1)
	lw	a0, -28(s0)
	sw	a0, -12(s0)
	j	kernel_LBB18_3
kernel_LBB18_3:
	lw	a0, -12(s0)
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
kernel_Lfunc_end18:
	.size	RAM_load_block, kernel_Lfunc_end18-RAM_load_block
                                        # -- End function
	.globl	allocate_process_stack          # -- Begin function allocate_process_stack
	.p2align	2
	.type	allocate_process_stack,@function
allocate_process_stack:                 # @allocate_process_stack
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	lui	a0, 2
	call	malloc_custom
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	bnez	a0, kernel_LBB19_2
	j	kernel_LBB19_1
kernel_LBB19_1:
	lui	a0, %hi(kernel_L.str.23)
	addi	a0, a0, %lo(kernel_L.str.23)
	call	print
	j	kernel_LBB19_2
kernel_LBB19_2:
	lw	a0, -12(s0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end19:
	.size	allocate_process_stack, kernel_Lfunc_end19-allocate_process_stack
                                        # -- End function
	.globl	add_process                     # -- Begin function add_process
	.p2align	2
	.type	add_process,@function
add_process:                            # @add_process
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lui	a0, %hi(process_list)
	lw	a0, %lo(process_list)(a0)
	bnez	a0, kernel_LBB20_2
	j	kernel_LBB20_1
kernel_LBB20_1:
	lw	a0, -12(s0)
	lui	a1, %hi(process_list)
	sw	a0, %lo(process_list)(a1)
	lw	a0, -12(s0)
	sw	a0, 4(a0)
	lw	a0, -12(s0)
	sw	a0, 8(a0)
	j	kernel_LBB20_3
kernel_LBB20_2:
	lui	a1, %hi(process_list)
	lw	a0, %lo(process_list)(a1)
	lw	a0, 8(a0)
	sw	a0, -16(s0)
	lw	a0, -12(s0)
	lw	a2, -16(s0)
	sw	a0, 4(a2)
	lw	a0, -16(s0)
	lw	a2, -12(s0)
	sw	a0, 8(a2)
	lw	a0, %lo(process_list)(a1)
	lw	a2, -12(s0)
	sw	a0, 4(a2)
	lw	a0, -12(s0)
	lw	a1, %lo(process_list)(a1)
	sw	a0, 8(a1)
	j	kernel_LBB20_3
kernel_LBB20_3:
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end20:
	.size	add_process, kernel_Lfunc_end20-add_process
                                        # -- End function
	.globl	remove_process                  # -- Begin function remove_process
	.p2align	2
	.type	remove_process,@function
remove_process:                         # @remove_process
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a1, -12(s0)
	lw	a0, 4(a1)
	bne	a0, a1, kernel_LBB21_3
	j	kernel_LBB21_1
kernel_LBB21_1:
	lw	a1, -12(s0)
	lw	a0, 8(a1)
	bne	a0, a1, kernel_LBB21_3
	j	kernel_LBB21_2
kernel_LBB21_2:
	lui	a1, %hi(process_list)
	li	a0, 0
	sw	a0, %lo(process_list)(a1)
	j	kernel_LBB21_6
kernel_LBB21_3:
	lw	a1, -12(s0)
	lw	a0, 4(a1)
	lw	a1, 8(a1)
	sw	a0, 4(a1)
	lw	a1, -12(s0)
	lw	a0, 8(a1)
	lw	a1, 4(a1)
	sw	a0, 8(a1)
	lui	a0, %hi(process_list)
	lw	a0, %lo(process_list)(a0)
	lw	a1, -12(s0)
	bne	a0, a1, kernel_LBB21_5
	j	kernel_LBB21_4
kernel_LBB21_4:
	lw	a0, -12(s0)
	lw	a0, 4(a0)
	lui	a1, %hi(process_list)
	sw	a0, %lo(process_list)(a1)
	j	kernel_LBB21_5
kernel_LBB21_5:
	j	kernel_LBB21_6
kernel_LBB21_6:
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end21:
	.size	remove_process, kernel_Lfunc_end21-remove_process
                                        # -- End function
	.globl	create_process                  # -- Begin function create_process
	.p2align	2
	.type	create_process,@function
create_process:                         # @create_process
# %bb.0:
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 64
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 36
	call	malloc_custom
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	bnez	a0, kernel_LBB22_2
	j	kernel_LBB22_1
kernel_LBB22_1:
	lui	a0, %hi(kernel_L.str.24)
	addi	a0, a0, %lo(kernel_L.str.24)
	call	print
	j	kernel_LBB22_8
kernel_LBB22_2:
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	sw	a0, 0(a1)
	call	allocate_process_stack
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	bnez	a0, kernel_LBB22_4
	j	kernel_LBB22_3
kernel_LBB22_3:
	lui	a0, %hi(kernel_L.str.25)
	addi	a0, a0, %lo(kernel_L.str.25)
	call	print
	j	kernel_LBB22_4
kernel_LBB22_4:
	lw	a0, -24(s0)
	lw	a1, -20(s0)
	sw	a0, 16(a1)
	lw	a0, -24(s0)
	lui	a1, 2
	add	a0, a0, a1
	lw	a1, -20(s0)
	sw	a0, 12(a1)
	lw	a1, -20(s0)
	lw	a0, 12(a1)
	sw	a0, 20(a1)
	lui	a0, %hi(free_block_list)
	lw	a0, %lo(free_block_list)(a0)
	beqz	a0, kernel_LBB22_6
	j	kernel_LBB22_5
kernel_LBB22_5:
	lui	a1, %hi(free_block_list)
	lw	a0, %lo(free_block_list)(a1)
	sw	a0, -28(s0)
	lw	a0, %lo(free_block_list)(a1)
	lw	a0, 0(a0)
	sw	a0, %lo(free_block_list)(a1)
	lw	a1, -28(s0)
	li	a0, 0
	sw	a0, 4(a1)
	lw	a1, -28(s0)
	sw	a0, 0(a1)
	lw	a0, -28(s0)
	lw	a1, -20(s0)
	sw	a0, 32(a1)
	lui	a0, %hi(kernel_L.str.26)
	addi	a0, a0, %lo(kernel_L.str.26)
	call	print
	lw	a0, -20(s0)
	lw	a0, 32(a0)
	lw	a0, 8(a0)
	addi	a1, s0, -37
	sw	a1, -52(s0)                     # 4-byte Folded Spill
	call	int_to_hex
	lw	a0, -52(s0)                     # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.1)
	addi	a0, a0, %lo(kernel_L.str.1)
	call	print
	j	kernel_LBB22_7
kernel_LBB22_6:
	lui	a0, %hi(kernel_L.str.27)
	addi	a0, a0, %lo(kernel_L.str.27)
	call	print
	j	kernel_LBB22_7
kernel_LBB22_7:
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	lw	a1, 32(a1)
	lw	a1, 8(a1)
	call	run_specific_program
	lw	a1, -20(s0)
	lw	a0, 32(a1)
	lw	a0, 8(a0)
	sw	a0, 28(a1)
	lw	a1, -20(s0)
	lw	a0, 28(a1)
	sw	a0, 24(a1)
	lw	a1, -20(s0)
	lw	a0, 12(a1)
	sw	a0, 20(a1)
	lw	a0, -20(s0)
	call	add_process
	lui	a0, %hi(kernel_L.str.28)
	addi	a0, a0, %lo(kernel_L.str.28)
	call	print
	lw	a0, -12(s0)
	addi	a1, s0, -46
	sw	a1, -56(s0)                     # 4-byte Folded Spill
	call	int_to_hex
	lw	a0, -56(s0)                     # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.29)
	addi	a0, a0, %lo(kernel_L.str.29)
	call	print
	lw	a1, -56(s0)                     # 4-byte Folded Reload
	lw	a0, -16(s0)
	call	int_to_hex
	lw	a0, -56(s0)                     # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.30)
	addi	a0, a0, %lo(kernel_L.str.30)
	call	print
	lw	a1, -56(s0)                     # 4-byte Folded Reload
	lw	a0, -20(s0)
	lw	a0, 32(a0)
	lw	a0, 8(a0)
	call	int_to_hex
	lw	a0, -56(s0)                     # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.1)
	addi	a0, a0, %lo(kernel_L.str.1)
	call	print
	j	kernel_LBB22_8
kernel_LBB22_8:
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
kernel_Lfunc_end22:
	.size	create_process, kernel_Lfunc_end22-create_process
                                        # -- End function
	.globl	print_process_list              # -- Begin function print_process_list
	.p2align	2
	.type	print_process_list,@function
print_process_list:                     # @print_process_list
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	lui	a0, %hi(process_list)
	lw	a0, %lo(process_list)(a0)
	bnez	a0, kernel_LBB23_2
	j	kernel_LBB23_1
kernel_LBB23_1:
	lui	a0, %hi(kernel_L.str.31)
	addi	a0, a0, %lo(kernel_L.str.31)
	call	print
	j	kernel_LBB23_5
kernel_LBB23_2:
	lui	a0, %hi(process_list)
	lw	a0, %lo(process_list)(a0)
	sw	a0, -12(s0)
	lui	a0, %hi(kernel_L.str.32)
	addi	a0, a0, %lo(kernel_L.str.32)
	call	print
	j	kernel_LBB23_3
kernel_LBB23_3:                               # =>This Innerkernel_Loop Header: Depth=1
	lui	a0, %hi(kernel_L.str.33)
	addi	a0, a0, %lo(kernel_L.str.33)
	call	print
	lw	a0, -12(s0)
	lw	a0, 0(a0)
	addi	a1, s0, -21
	sw	a1, -28(s0)                     # 4-byte Folded Spill
	call	int_to_hex
	lw	a0, -28(s0)                     # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.34)
	addi	a0, a0, %lo(kernel_L.str.34)
	call	print
	lw	a1, -28(s0)                     # 4-byte Folded Reload
	lw	a0, -12(s0)
	lw	a0, 12(a0)
	call	int_to_hex
	lw	a0, -28(s0)                     # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.35)
	addi	a0, a0, %lo(kernel_L.str.35)
	call	print
	lw	a1, -28(s0)                     # 4-byte Folded Reload
	lw	a0, -12(s0)
	lw	a0, 16(a0)
	call	int_to_hex
	lw	a0, -28(s0)                     # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.1)
	addi	a0, a0, %lo(kernel_L.str.1)
	call	print
	lw	a0, -12(s0)
	lw	a0, 4(a0)
	sw	a0, -12(s0)
	j	kernel_LBB23_4
kernel_LBB23_4:                               #   inkernel_Loop: Header=BB23_3 Depth=1
	lw	a0, -12(s0)
	lui	a1, %hi(process_list)
	lw	a1, %lo(process_list)(a1)
	bne	a0, a1, kernel_LBB23_3
	j	kernel_LBB23_5
kernel_LBB23_5:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
kernel_Lfunc_end23:
	.size	print_process_list, kernel_Lfunc_end23-print_process_list
                                        # -- End function
	.globl	schedule_next                   # -- Begin function schedule_next
	.p2align	2
	.type	schedule_next,@function
schedule_next:                          # @schedule_next
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 48
	lui	a0, %hi(kernel_L.str.36)
	addi	a0, a0, %lo(kernel_L.str.36)
	call	print
	lui	a0, %hi(process_list)
	lw	a0, %lo(process_list)(a0)
	bnez	a0, kernel_LBB24_2
	j	kernel_LBB24_1
kernel_LBB24_1:
	lui	a0, %hi(kernel_L.str.37)
	addi	a0, a0, %lo(kernel_L.str.37)
	call	print
	j	kernel_LBB24_8
kernel_LBB24_2:
	lui	a0, %hi(current_process)
	lw	a0, %lo(current_process)(a0)
	bnez	a0, kernel_LBB24_4
	j	kernel_LBB24_3
kernel_LBB24_3:
	lui	a0, %hi(process_list)
	lw	a0, %lo(process_list)(a0)
	lui	a1, %hi(current_process)
	sw	a0, %lo(current_process)(a1)
	j	kernel_LBB24_5
kernel_LBB24_4:
	lui	a1, %hi(current_process)
	lw	a0, %lo(current_process)(a1)
	lw	a0, 4(a0)
	sw	a0, %lo(current_process)(a1)
	j	kernel_LBB24_5
kernel_LBB24_5:
	lui	a0, %hi(kernel_L.str.38)
	addi	a0, a0, %lo(kernel_L.str.38)
	call	print
	lui	a0, %hi(current_process)
	sw	a0, -32(s0)                     # 4-byte Folded Spill
	lw	a0, %lo(current_process)(a0)
	lw	a0, 0(a0)
	addi	a1, s0, -17
	sw	a1, -36(s0)                     # 4-byte Folded Spill
	call	int_to_hex
	lw	a0, -36(s0)                     # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.39)
	addi	a0, a0, %lo(kernel_L.str.39)
	call	print
	lw	a1, -36(s0)                     # 4-byte Folded Reload
	lw	a0, -32(s0)                     # 4-byte Folded Reload
	lw	a0, %lo(current_process)(a0)
	lw	a0, 20(a0)
	call	int_to_hex
	lw	a0, -36(s0)                     # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.1)
	addi	a0, a0, %lo(kernel_L.str.1)
	call	print
	lw	a0, -32(s0)                     # 4-byte Folded Reload
	lw	a0, %lo(current_process)(a0)
	lw	a0, 32(a0)
	beqz	a0, kernel_LBB24_7
	j	kernel_LBB24_6
kernel_LBB24_6:
	lui	a2, %hi(current_process)
	lw	a0, %lo(current_process)(a2)
	lw	a0, 32(a0)
	lw	a0, 8(a0)
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	lui	a1, 8
	add	a0, a0, a1
	sw	a0, -28(s0)
	lw	a0, -24(s0)
	lw	a1, -28(s0)
	lw	a3, %lo(current_process)(a2)
	lw	a2, 24(a3)
	lw	a3, 20(a3)
	call	set_registers
	j	kernel_LBB24_8
kernel_LBB24_7:
	lui	a0, %hi(kernel_L.str.40)
	addi	a0, a0, %lo(kernel_L.str.40)
	call	print
	j	kernel_LBB24_8
kernel_LBB24_8:
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
kernel_Lfunc_end24:
	.size	schedule_next, kernel_Lfunc_end24-schedule_next
                                        # -- End function
	.globl	alarm_scheduler                 # -- Begin function alarm_scheduler
	.p2align	2
	.type	alarm_scheduler,@function
alarm_scheduler:                        # @alarm_scheduler
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	call	clock_alarm_handler
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end25:
	.size	alarm_scheduler, kernel_Lfunc_end25-alarm_scheduler
                                        # -- End function
	.globl	tester                          # -- Begin function tester
	.p2align	2
	.type	tester,@function
tester:                                 # @tester
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	call	init_RAM_blocks
	call	preload_fs
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
kernel_Lfunc_end26:
	.size	tester, kernel_Lfunc_end26-tester
                                        # -- End function
	.globl	custom_do_exit                  # -- Begin function custom_do_exit
	.p2align	2
	.type	custom_do_exit,@function
custom_do_exit:                         # @custom_do_exit
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	lui	a0, %hi(current_process)
	sw	a0, -28(s0)                     # 4-byte Folded Spill
	lw	a0, %lo(current_process)(a0)
	lw	a0, 32(a0)
	call	free_RAM_block
	lw	a0, -28(s0)                     # 4-byte Folded Reload
	lw	a0, %lo(current_process)(a0)
	call	remove_process
	lw	a0, -12(s0)
	bnez	a0, kernel_LBB27_2
	j	kernel_LBB27_1
kernel_LBB27_1:
	lui	a0, %hi(kernel_L.str.41)
	addi	a0, a0, %lo(kernel_L.str.41)
	call	print
	j	kernel_LBB27_3
kernel_LBB27_2:
	lw	a0, -12(s0)
	addi	a1, s0, -21
	sw	a1, -32(s0)                     # 4-byte Folded Spill
	call	int_to_hex
	lui	a0, %hi(kernel_L.str.42)
	addi	a0, a0, %lo(kernel_L.str.42)
	call	print
	lw	a0, -32(s0)                     # 4-byte Folded Reload
	call	print
	lui	a0, %hi(kernel_L.str.1)
	addi	a0, a0, %lo(kernel_L.str.1)
	call	print
	j	kernel_LBB27_3
kernel_LBB27_3:
	lui	a0, %hi(process_list)
	lw	a0, %lo(process_list)(a0)
	bnez	a0, kernel_LBB27_5
	j	kernel_LBB27_4
kernel_LBB27_4:
	call	syscall_handler_halt
	j	kernel_LBB27_6
kernel_LBB27_5:
	call	schedule_next
	j	kernel_LBB27_6
kernel_LBB27_6:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
kernel_Lfunc_end27:
	.size	custom_do_exit, kernel_Lfunc_end27-custom_do_exit
                                        # -- End function
	.type	free_head,@object               # @free_head
	.bss
	.globl	free_head
	.p2align	2, 0x0
free_head:
	.zero	12
	.size	free_head, 12

	.type	free_tail,@object               # @free_tail
	.globl	free_tail
	.p2align	2, 0x0
free_tail:
	.zero	12
	.size	free_tail, 12

	.type	free_block_list,@object         # @free_block_list
	.section	.sbss,"aw",@nobits
	.globl	free_block_list
	.p2align	2, 0x0
free_block_list:
	.word	0
	.size	free_block_list, 4

	.type	current_process,@object         # @current_process
	.globl	current_process
	.p2align	2, 0x0
current_process:
	.word	0
	.size	current_process, 4

	.type	heap_limit,@object              # @heap_limit
	.globl	heap_limit
	.p2align	2, 0x0
heap_limit:
	.word	0                               # 0x0
	.size	heap_limit, 4

	.type	hex_digits,@object              # @hex_digits
	.data
hex_digits:
	.ascii	"0123456789abcdef"
	.size	hex_digits, 16

	.type	run_programs.next_program_ROM,@object # @run_programs.next_program_ROM
	.section	.sdata,"aw",@progbits
	.p2align	2, 0x0
run_programs.next_program_ROM:
	.word	3                               # 0x3
	.size	run_programs.next_program_ROM, 4

	.type	kernel_L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
kernel_L.str:
	.asciz	"Searching for ROM #"
	.size	kernel_L.str, 20

	.type	kernel_L.str.1,@object                # @.str.1
kernel_L.str.1:
	.asciz	"\n"
	.size	kernel_L.str.1, 2

	.type	kernel_L.str.2,@object                # @.str.2
kernel_L.str.2:
	.asciz	"kernel_limit = "
	.size	kernel_L.str.2, 16

	.type	kernel_L.str.3,@object                # @.str.3
kernel_L.str.3:
	.asciz	"RAM_limit = "
	.size	kernel_L.str.3, 13

	.type	kernel_L.str.4,@object                # @.str.4
kernel_L.str.4:
	.asciz	"Allocated block at address = "
	.size	kernel_L.str.4, 30

	.type	kernel_L.str.5,@object                # @.str.5
kernel_L.str.5:
	.asciz	"block could not be allocated"
	.size	kernel_L.str.5, 29

	.type	kernel_L.str.6,@object                # @.str.6
kernel_L.str.6:
	.asciz	"freeblocklisthead= "
	.size	kernel_L.str.6, 20

	.type	kernel_L.str.7,@object                # @.str.7
kernel_L.str.7:
	.asciz	"free block list initialized:\n"
	.size	kernel_L.str.7, 30

	.type	kernel_L.str.8,@object                # @.str.8
kernel_L.str.8:
	.asciz	"Block base: "
	.size	kernel_L.str.8, 13

	.type	kernel_L.str.9,@object                # @.str.9
kernel_L.str.9:
	.asciz	"Assigned RAM block\n"
	.size	kernel_L.str.9, 20

	.type	kernel_L.str.10,@object               # @.str.10
kernel_L.str.10:
	.asciz	"No block device!\n"
	.size	kernel_L.str.10, 18

	.type	kernel_L.str.11,@object               # @.str.11
kernel_L.str.11:
	.asciz	"loading a bd block!\n"
	.size	kernel_L.str.11, 21

	.type	kernel_L.str.12,@object               # @.str.12
kernel_L.str.12:
	.asciz	"bruhloading a file"
	.size	kernel_L.str.12, 19

	.type	kernel_L.str.13,@object               # @.str.13
kernel_L.str.13:
	.asciz	"no user data blocks\n"
	.size	kernel_L.str.13, 21

	.type	kernel_L.str.14,@object               # @.str.14
kernel_L.str.14:
	.asciz	"Successfully loaded all file blocks \n"
	.size	kernel_L.str.14, 38

	.type	kernel_L.str.15,@object               # @.str.15
kernel_L.str.15:
	.asciz	"directory inode block number:"
	.size	kernel_L.str.15, 30

	.type	kernel_L.str.16,@object               # @.str.16
kernel_L.str.16:
	.asciz	"Allocating RAM space for file system startup..\n"
	.size	kernel_L.str.16, 48

	.type	kernel_L.str.17,@object               # @.str.17
kernel_L.str.17:
	.asciz	"No free RAM blocks available for filesystem.\n"
	.size	kernel_L.str.17, 46

	.type	kernel_L.str.18,@object               # @.str.18
kernel_L.str.18:
	.asciz	"Filesystem buffer assigned at address: "
	.size	kernel_L.str.18, 40

	.type	kernel_L.str.19,@object               # @.str.19
kernel_L.str.19:
	.asciz	"Superblock loaded into RAM.\n"
	.size	kernel_L.str.19, 29

	.type	kernel_L.str.20,@object               # @.str.20
kernel_L.str.20:
	.asciz	"Magic cookie:"
	.size	kernel_L.str.20, 14

	.type	kernel_L.str.21,@object               # @.str.21
kernel_L.str.21:
	.asciz	"Superblock length:"
	.size	kernel_L.str.21, 19

	.type	kernel_L.str.22,@object               # @.str.22
kernel_L.str.22:
	.asciz	"RAM_load_block: out of blocks!\n"
	.size	kernel_L.str.22, 32

	.type	kernel_L.str.23,@object               # @.str.23
kernel_L.str.23:
	.asciz	"stack allocation failed! \n"
	.size	kernel_L.str.23, 27

	.type	process_list,@object            # @process_list
	.section	.sbss,"aw",@nobits
	.p2align	2, 0x0
process_list:
	.word	0
	.size	process_list, 4

	.type	kernel_L.str.24,@object               # @.str.24
	.section	.rodata.str1.1,"aMS",@progbits,1
kernel_L.str.24:
	.asciz	"process control structure allocation failed\n"
	.size	kernel_L.str.24, 45

	.type	kernel_L.str.25,@object               # @.str.25
kernel_L.str.25:
	.asciz	"process stack allocation is doing bruh burh \n"
	.size	kernel_L.str.25, 46

	.type	kernel_L.str.26,@object               # @.str.26
kernel_L.str.26:
	.asciz	"process assigned to ram_block at = "
	.size	kernel_L.str.26, 36

	.type	kernel_L.str.27,@object               # @.str.27
kernel_L.str.27:
	.asciz	"no RAM blocks are available for this process.\n"
	.size	kernel_L.str.27, 47

	.type	kernel_L.str.28,@object               # @.str.28
kernel_L.str.28:
	.asciz	"Process "
	.size	kernel_L.str.28, 9

	.type	kernel_L.str.29,@object               # @.str.29
kernel_L.str.29:
	.asciz	" loaded from ROM instance "
	.size	kernel_L.str.29, 27

	.type	kernel_L.str.30,@object               # @.str.30
kernel_L.str.30:
	.asciz	" assigned to RAM block at address = "
	.size	kernel_L.str.30, 37

	.type	kernel_L.str.31,@object               # @.str.31
kernel_L.str.31:
	.asciz	"Process list is empty.\n"
	.size	kernel_L.str.31, 24

	.type	kernel_L.str.32,@object               # @.str.32
kernel_L.str.32:
	.asciz	"Processes in list:\n"
	.size	kernel_L.str.32, 20

	.type	kernel_L.str.33,@object               # @.str.33
kernel_L.str.33:
	.asciz	"Process ID: "
	.size	kernel_L.str.33, 13

	.type	kernel_L.str.34,@object               # @.str.34
kernel_L.str.34:
	.asciz	" | Stack Base: "
	.size	kernel_L.str.34, 16

	.type	kernel_L.str.35,@object               # @.str.35
kernel_L.str.35:
	.asciz	" | Stackkernel_Limit: "
	.size	kernel_L.str.35, 17

	.type	kernel_L.str.36,@object               # @.str.36
kernel_L.str.36:
	.asciz	"alarm TRIGGERED. \n"
	.size	kernel_L.str.36, 19

	.type	kernel_L.str.37,@object               # @.str.37
kernel_L.str.37:
	.asciz	"no processes to shcedule. \n"
	.size	kernel_L.str.37, 28

	.type	kernel_L.str.38,@object               # @.str.38
kernel_L.str.38:
	.asciz	"Current process is: "
	.size	kernel_L.str.38, 21

	.type	kernel_L.str.39,@object               # @.str.39
kernel_L.str.39:
	.asciz	"Stack pointer is:"
	.size	kernel_L.str.39, 18

	.type	kernel_L.str.40,@object               # @.str.40
kernel_L.str.40:
	.asciz	"process has no assigned RAM block \n"
	.size	kernel_L.str.40, 36

	.type	kernel_L.str.41,@object               # @.str.41
kernel_L.str.41:
	.asciz	"Exit was successful with exit code 0.\n"
	.size	kernel_L.str.41, 39

	.type	kernel_L.str.42,@object               # @.str.42
kernel_L.str.42:
	.asciz	"Exit was unsuccesful with exit code non-zero.\n"
	.size	kernel_L.str.42, 47

	.ident	"clang version 19.1.6"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym int_to_hex
	.addrsig_sym print
	.addrsig_sym find_device
	.addrsig_sym userspace_jump
	.addrsig_sym run_specific_program
	.addrsig_sym heap_init
	.addrsig_sym allocate
	.addrsig_sym deallocate
	.addrsig_sym malloc_custom
	.addrsig_sym unendianify
	.addrsig_sym init_RAM_blocks
	.addrsig_sym free_RAM_block
	.addrsig_sym assign_ram_block
	.addrsig_sym load_bd_block
	.addrsig_sym load_inode
	.addrsig_sym load_file
	.addrsig_sym preload_directory
	.addrsig_sym preload_fs
	.addrsig_sym allocate_process_stack
	.addrsig_sym add_process
	.addrsig_sym remove_process
	.addrsig_sym schedule_next
	.addrsig_sym set_registers
	.addrsig_sym clock_alarm_handler
	.addrsig_sym syscall_handler_halt
	.addrsig_sym free_head
	.addrsig_sym free_tail
	.addrsig_sym free_block_list
	.addrsig_sym current_process
	.addrsig_sym heap_limit
	.addrsig_sym hex_digits
	.addrsig_sym run_programs.next_program_ROM
	.addrsig_sym ROM_device_code
	.addrsig_sym current_ROM
	.addrsig_sym DMA_portal_ptr
	.addrsig_sym kernel_limit
	.addrsig_sym statics_limit
	.addrsig_sym RAM_device_code
	.addrsig_sym block_device_code
	.addrsig_sym process_list
