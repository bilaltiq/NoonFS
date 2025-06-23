	.Code
int_to_hex:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
	sw	a1, -16(s0) 
	li	a0, 28 
	sw	a0, -20(s0) 
	j	kernel_LBB0_1 
kernel_LBB0_1:
	lw	a0, -20(s0) 
	bltz	a0, kernel_LBB0_4 
	j	kernel_LBB0_2 
kernel_LBB0_2:
	lw	a0, -12(s0) 
	lw	a1, -20(s0) 
	srl	a0, a0, a1 
	andi	a0, a0, 15 
	sw	a0, -24(s0) 
	lw	a1, -24(s0) 
kernel_autoL0:
	auipc	a0, %hi(%pcrel(hex_digits))
	addi	a0, a0, %lo(%larel(hex_digits,kernel_autoL0))
	add	a0, a0, a1 
	lbu	a0, 0(a0) 
	lw	a1, -16(s0) 
	addi	a2, a1, 1 
	sw	a2, -16(s0) 
	sb	a0, 0(a1) 
	j	kernel_LBB0_3 
kernel_LBB0_3:
	lw	a0, -20(s0) 
	addi	a0, a0, -4 
	sw	a0, -20(s0) 
	j	kernel_LBB0_1 
kernel_LBB0_4:
	lw	a1, -16(s0) 
	li	a0, 0 
	sb	a0, 0(a1) 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
kernel_Lfunc_end0:
	#	-- End function 
run_programs:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
kernel_autoL1:
	auipc	a0, %hi(%pcrel(kernel_L.str))
	addi	a0, a0, %lo(%larel(kernel_L.str,kernel_autoL1))
	call	print 
kernel_autoL2:
	auipc	a0, %hi(%pcrel(run_programs.next_program_ROM))
	sw	a0, -28(s0) # 4-byte Folded Spill 
	lw	a0, %lo(%larel(run_programs.next_program_ROM,kernel_autoL2))(a0)
	addi	a1, s0, -17 
	sw	a1, -32(s0) # 4-byte Folded Spill 
	call	int_to_hex 
	lw	a0, -32(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL3:
	auipc	a0, %hi(%pcrel(kernel_L.str.1))
	addi	a0, a0, %lo(%larel(kernel_L.str.1,kernel_autoL3))
	call	print 
	lw	a3, -28(s0) # 4-byte Folded Reload 
kernel_autoL4:
	auipc	a0, %hi(%pcrel(ROM_device_code))
	lw	a0, %lo(%larel(ROM_device_code,kernel_autoL4))(a0)
	lw	a1, %lo(%larel(run_programs.next_program_ROM,kernel_autoL2))(a3)
	addi	a2, a1, 1 
	sw	a2, %lo(%larel(run_programs.next_program_ROM,kernel_autoL2))(a3)
	call	find_device 
	sw	a0, -24(s0) 
	lw	a0, -24(s0) 
	bnez	a0, kernel_LBB1_2 
	j	kernel_LBB1_1 
kernel_LBB1_1:
	j	kernel_LBB1_3 
kernel_LBB1_2:
kernel_autoL5:
	auipc	a0, %hi(%pcrel(run_programs.next_program_ROM))
	lw	a0, %lo(%larel(run_programs.next_program_ROM,kernel_autoL5))(a0)
kernel_autoL6:
	auipc	a1, %hi(%pcrel(current_ROM))
	sw	a0, %lo(%larel(current_ROM,kernel_autoL6))(a1)
	lw	a0, -24(s0) 
	lw	a0, 4(a0) 
kernel_autoL7:
	auipc	a2, %hi(%pcrel(DMA_portal_ptr))
	lw	a1, %lo(%larel(DMA_portal_ptr,kernel_autoL7))(a2)
	sw	a0, 0(a1) 
kernel_autoL8:
	auipc	a0, %hi(%pcrel(kernel_limit))
	lw	a1, %lo(%larel(kernel_limit,kernel_autoL8))(a0)
	lw	a3, %lo(%larel(DMA_portal_ptr,kernel_autoL7))(a2)
	sw	a1, 4(a3) 
	lw	a3, -24(s0) 
	lw	a1, 8(a3) 
	lw	a3, 4(a3) 
	sub	a1, a1, a3 
	lw	a2, %lo(%larel(DMA_portal_ptr,kernel_autoL7))(a2)
	sw	a1, 8(a2) 
	lw	a0, %lo(%larel(kernel_limit,kernel_autoL8))(a0)
	call	userspace_jump 
	j	kernel_LBB1_3 
kernel_LBB1_3:
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
kernel_Lfunc_end1:
	#	-- End function 
run_specific_program:
	#	%bb.0: 
	addi	sp, sp, -48 
	sw	ra, 44(sp) # 4-byte Folded Spill 
	sw	s0, 40(sp) # 4-byte Folded Spill 
	addi	s0, sp, 48 
	sw	a0, -12(s0) 
	sw	a1, -16(s0) 
	lw	a0, -12(s0) 
	addi	a1, s0, -25 
	sw	a1, -36(s0) # 4-byte Folded Spill 
	call	int_to_hex 
	lw	a0, -36(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL9:
	auipc	a0, %hi(%pcrel(kernel_L.str.1))
	addi	a0, a0, %lo(%larel(kernel_L.str.1,kernel_autoL9))
	call	print 
kernel_autoL10:
	auipc	a0, %hi(%pcrel(ROM_device_code))
	lw	a0, %lo(%larel(ROM_device_code,kernel_autoL10))(a0)
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
kernel_autoL11:
	auipc	a1, %hi(%pcrel(current_ROM))
	sw	a0, %lo(%larel(current_ROM,kernel_autoL11))(a1)
	lw	a0, -32(s0) 
	lw	a0, 4(a0) 
kernel_autoL12:
	auipc	a1, %hi(%pcrel(DMA_portal_ptr))
	lw	a2, %lo(%larel(DMA_portal_ptr,kernel_autoL12))(a1)
	sw	a0, 0(a2) 
	lw	a0, -16(s0) 
	lw	a2, %lo(%larel(DMA_portal_ptr,kernel_autoL12))(a1)
	sw	a0, 4(a2) 
	lw	a2, -32(s0) 
	lw	a0, 8(a2) 
	lw	a2, 4(a2) 
	sub	a0, a0, a2 
	lw	a1, %lo(%larel(DMA_portal_ptr,kernel_autoL12))(a1)
	sw	a0, 8(a1) 
	j	kernel_LBB2_3 
kernel_LBB2_3:
	lw	ra, 44(sp) # 4-byte Folded Reload 
	lw	s0, 40(sp) # 4-byte Folded Reload 
	addi	sp, sp, 48 
	ret	
kernel_Lfunc_end2:
	#	-- End function 
do_print:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
	sw	a0, -12(s0) 
	lw	a0, -12(s0) 
kernel_autoL13:
	auipc	a1, %hi(%pcrel(current_process))
	lw	a1, %lo(%larel(current_process,kernel_autoL13))(a1)
	lw	a1, 32(a1) 
	lw	a1, 8(a1) 
	add	a0, a0, a1 
	sw	a0, -16(s0) 
	lw	a0, -16(s0) 
	call	print 
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end3:
	#	-- End function 
heap_init:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
kernel_autoL14:
	auipc	a0, %hi(%pcrel(heap_limit))
	lw	a0, %lo(%larel(heap_limit,kernel_autoL14))(a0)
	beqz	a0, kernel_LBB4_2 
	j	kernel_LBB4_1 
kernel_LBB4_1:
	j	kernel_LBB4_3 
kernel_LBB4_2:
kernel_autoL15:
	auipc	a1, %hi(%pcrel(heap_limit))
kernel_autoL16:
	auipc	a0, %hi(%pcrel(statics_limit))
	addi	a0, a0, %lo(%larel(statics_limit,kernel_autoL16))
	sw	a0, %lo(%larel(heap_limit,kernel_autoL15))(a1)
kernel_autoL17:
	auipc	a0, %hi(%pcrel(free_head))
	addi	a0, a0, %lo(%larel(free_head,kernel_autoL17))
kernel_autoL18:
	auipc	a1, %hi(%pcrel(free_tail))
	addi	a1, a1, %lo(%larel(free_tail,kernel_autoL18))
	sw	a1, 4(a0) 
	sw	a0, 8(a1) 
	j	kernel_LBB4_3 
kernel_LBB4_3:
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end4:
	#	-- End function 
allocate:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
	call	heap_init 
	lbu	a0, -12(s0) 
	andi	a0, a0, 3 
	bnez	a0, kernel_LBB5_2 
	j	kernel_LBB5_1 
kernel_LBB5_1:
	lw	a0, -12(s0) 
	sw	a0, -24(s0) # 4-byte Folded Spill 
	j	kernel_LBB5_3 
kernel_LBB5_2:
	lw	a0, -12(s0) 
	addi	a0, a0, 4 
	andi	a0, a0, 3 
	sw	a0, -24(s0) # 4-byte Folded Spill 
	j	kernel_LBB5_3 
kernel_LBB5_3:
	lw	a0, -24(s0) # 4-byte Folded Reload 
	sw	a0, -12(s0) 
kernel_autoL19:
	auipc	a0, %hi(%pcrel(free_head))
	addi	a0, a0, %lo(%larel(free_head,kernel_autoL19))
	lw	a0, 4(a0) 
	sw	a0, -16(s0) 
	j	kernel_LBB5_4 
kernel_LBB5_4:
	lw	a0, -16(s0) 
kernel_autoL20:
	auipc	a1, %hi(%pcrel(free_tail))
	addi	a1, a1, %lo(%larel(free_tail,kernel_autoL20))
	beq	a0, a1, kernel_LBB5_9 
	j	kernel_LBB5_5 
kernel_LBB5_5:
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
kernel_LBB5_7:
	lw	a0, -16(s0) 
	lw	a0, 4(a0) 
	sw	a0, -16(s0) 
	j	kernel_LBB5_8 
kernel_LBB5_8:
	j	kernel_LBB5_4 
kernel_LBB5_9:
	lw	a0, -16(s0) 
kernel_autoL21:
	auipc	a1, %hi(%pcrel(free_tail))
	addi	a1, a1, %lo(%larel(free_tail,kernel_autoL21))
	bne	a0, a1, kernel_LBB5_11 
	j	kernel_LBB5_10 
kernel_LBB5_10:
	lw	a0, -12(s0) 
	addi	a0, a0, 12 
	sw	a0, -20(s0) 
kernel_autoL22:
	auipc	a1, %hi(%pcrel(heap_limit))
	lw	a0, %lo(%larel(heap_limit,kernel_autoL22))(a1)
	sw	a0, -16(s0) 
	lw	a0, -12(s0) 
	lw	a2, -16(s0) 
	sw	a0, 0(a2) 
	lw	a2, -20(s0) 
	lw	a0, %lo(%larel(heap_limit,kernel_autoL22))(a1)
	add	a0, a0, a2 
	sw	a0, %lo(%larel(heap_limit,kernel_autoL22))(a1)
	j	kernel_LBB5_11 
kernel_LBB5_11:
	lw	a0, -16(s0) 
	addi	a0, a0, 12 
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
kernel_Lfunc_end5:
	#	-- End function 
deallocate:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
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
kernel_autoL23:
	auipc	a1, %hi(%pcrel(free_head))
	addi	a1, a1, %lo(%larel(free_head,kernel_autoL23))
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
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end6:
	#	-- End function 
malloc_custom:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
	sw	a0, -12(s0) 
	lw	a0, -12(s0) 
	call	allocate 
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end7:
	#	-- End function 
free_custom:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
	sw	a0, -12(s0) 
	lw	a0, -12(s0) 
	call	deallocate 
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end8:
	#	-- End function 
unendianify:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
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
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end9:
	#	-- End function 
init_RAM_blocks:
	#	%bb.0: 
	addi	sp, sp, -112 
	sw	ra, 108(sp) # 4-byte Folded Spill 
	sw	s0, 104(sp) # 4-byte Folded Spill 
	addi	s0, sp, 112 
kernel_autoL24:
	auipc	a0, %hi(%pcrel(kernel_limit))
	sw	a0, -96(s0) # 4-byte Folded Spill 
	lw	a0, %lo(%larel(kernel_limit,kernel_autoL24))(a0)
	sw	a0, -12(s0) 
	li	a0, 1 
	sw	a0, -16(s0) 
kernel_autoL25:
	auipc	a0, %hi(%pcrel(RAM_device_code))
	lw	a0, %lo(%larel(RAM_device_code,kernel_autoL25))(a0)
	lw	a1, -16(s0) 
	call	find_device 
	sw	a0, -20(s0) 
	lw	a0, -20(s0) 
	lw	a0, 8(a0) 
	sw	a0, -24(s0) 
kernel_autoL26:
	auipc	a1, %hi(%pcrel(free_block_list))
	li	a0, 0 
	sw	a0, %lo(%larel(free_block_list,kernel_autoL26))(a1)
	sw	a0, -28(s0) 
kernel_autoL27:
	auipc	a0, %hi(%pcrel(kernel_L.str.2))
	addi	a0, a0, %lo(%larel(kernel_L.str.2,kernel_autoL27))
	call	print 
	lw	a0, -96(s0) # 4-byte Folded Reload 
	lw	a0, %lo(%larel(kernel_limit,kernel_autoL24))(a0)
	addi	a1, s0, -37 
	sw	a1, -92(s0) # 4-byte Folded Spill 
	call	int_to_hex 
	lw	a0, -92(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL28:
	auipc	a0, %hi(%pcrel(kernel_L.str.1))
	addi	a0, a0, %lo(%larel(kernel_L.str.1,kernel_autoL28))
	sw	a0, -88(s0) # 4-byte Folded Spill 
	call	print 
kernel_autoL29:
	auipc	a0, %hi(%pcrel(kernel_L.str.3))
	addi	a0, a0, %lo(%larel(kernel_L.str.3,kernel_autoL29))
	call	print 
	lw	a1, -92(s0) # 4-byte Folded Reload 
	lw	a0, -24(s0) 
	call	int_to_hex 
	lw	a0, -92(s0) # 4-byte Folded Reload 
	call	print 
	lw	a0, -88(s0) # 4-byte Folded Reload 
	call	print 
	lw	a0, -12(s0) 
	sw	a0, -44(s0) 
	j	kernel_LBB10_1 
kernel_LBB10_1:
	lw	a0, -44(s0) 
	lui	a1, 8 
	add	a1, a0, a1 
	lw	a0, -24(s0) 
	bltu	a0, a1, kernel_LBB10_8 
	j	kernel_LBB10_2 
kernel_LBB10_2:
	lw	a0, -28(s0) 
	addi	a0, a0, 1 
	sw	a0, -28(s0) 
	li	a0, 12 
	call	malloc_custom 
	sw	a0, -48(s0) 
	lw	a0, -48(s0) 
	addi	a1, s0, -57 
	sw	a1, -100(s0) # 4-byte Folded Spill 
	call	int_to_hex 
kernel_autoL30:
	auipc	a0, %hi(%pcrel(kernel_L.str.4))
	addi	a0, a0, %lo(%larel(kernel_L.str.4,kernel_autoL30))
	call	print 
	lw	a0, -100(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL31:
	auipc	a0, %hi(%pcrel(kernel_L.str.1))
	addi	a0, a0, %lo(%larel(kernel_L.str.1,kernel_autoL31))
	call	print 
	lw	a0, -48(s0) 
	bnez	a0, kernel_LBB10_4 
	j	kernel_LBB10_3 
kernel_LBB10_3:
kernel_autoL32:
	auipc	a0, %hi(%pcrel(kernel_L.str.5))
	addi	a0, a0, %lo(%larel(kernel_L.str.5,kernel_autoL32))
	call	print 
	j	kernel_LBB10_8 
kernel_LBB10_4:
	lw	a0, -44(s0) 
	lw	a1, -48(s0) 
	sw	a0, 8(a1) 
	lw	a0, -48(s0) 
	li	a1, 0 
	sw	a1, 0(a0) 
	lw	a0, -48(s0) 
	sw	a1, 4(a0) 
kernel_autoL33:
	auipc	a0, %hi(%pcrel(free_block_list))
	lw	a2, %lo(%larel(free_block_list,kernel_autoL33))(a0)
	lw	a3, -48(s0) 
	sw	a2, 0(a3) 
	lw	a2, -48(s0) 
	sw	a1, 4(a2) 
	lw	a0, %lo(%larel(free_block_list,kernel_autoL33))(a0)
	beqz	a0, kernel_LBB10_6 
	j	kernel_LBB10_5 
kernel_LBB10_5:
	lw	a0, -48(s0) 
kernel_autoL34:
	auipc	a1, %hi(%pcrel(free_block_list))
	lw	a1, %lo(%larel(free_block_list,kernel_autoL34))(a1)
	sw	a0, 4(a1) 
	j	kernel_LBB10_6 
kernel_LBB10_6:
	lw	a0, -48(s0) 
kernel_autoL35:
	auipc	a1, %hi(%pcrel(free_block_list))
	sw	a1, -108(s0) # 4-byte Folded Spill 
	sw	a0, %lo(%larel(free_block_list,kernel_autoL35))(a1)
kernel_autoL36:
	auipc	a0, %hi(%pcrel(kernel_L.str.6))
	addi	a0, a0, %lo(%larel(kernel_L.str.6,kernel_autoL36))
	call	print 
	lw	a0, -108(s0) # 4-byte Folded Reload 
	lw	a0, %lo(%larel(free_block_list,kernel_autoL35))(a0)
	lw	a0, 8(a0) 
	addi	a1, s0, -66 
	sw	a1, -104(s0) # 4-byte Folded Spill 
	call	int_to_hex 
	lw	a0, -104(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL37:
	auipc	a0, %hi(%pcrel(kernel_L.str.1))
	addi	a0, a0, %lo(%larel(kernel_L.str.1,kernel_autoL37))
	call	print 
	j	kernel_LBB10_7 
kernel_LBB10_7:
	lw	a0, -44(s0) 
	lui	a1, 8 
	add	a0, a0, a1 
	sw	a0, -44(s0) 
	j	kernel_LBB10_1 
kernel_LBB10_8:
kernel_autoL38:
	auipc	a0, %hi(%pcrel(kernel_L.str.7))
	addi	a0, a0, %lo(%larel(kernel_L.str.7,kernel_autoL38))
	call	print 
kernel_autoL39:
	auipc	a0, %hi(%pcrel(free_block_list))
	lw	a0, %lo(%larel(free_block_list,kernel_autoL39))(a0)
	sw	a0, -72(s0) 
	j	kernel_LBB10_9 
kernel_LBB10_9:
	lw	a0, -72(s0) 
	beqz	a0, kernel_LBB10_11 
	j	kernel_LBB10_10 
kernel_LBB10_10:
kernel_autoL40:
	auipc	a0, %hi(%pcrel(kernel_L.str.8))
	addi	a0, a0, %lo(%larel(kernel_L.str.8,kernel_autoL40))
	call	print 
	lw	a0, -72(s0) 
	lw	a0, 8(a0) 
	addi	a1, s0, -81 
	sw	a1, -112(s0) # 4-byte Folded Spill 
	call	int_to_hex 
	lw	a0, -112(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL41:
	auipc	a0, %hi(%pcrel(kernel_L.str.1))
	addi	a0, a0, %lo(%larel(kernel_L.str.1,kernel_autoL41))
	call	print 
	lw	a0, -72(s0) 
	lw	a0, 0(a0) 
	sw	a0, -72(s0) 
	j	kernel_LBB10_9 
kernel_LBB10_11:
	lw	ra, 108(sp) # 4-byte Folded Reload 
	lw	s0, 104(sp) # 4-byte Folded Reload 
	addi	sp, sp, 112 
	ret	
kernel_Lfunc_end10:
	#	-- End function 
free_RAM_block:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
	sw	a0, -12(s0) 
	lw	a0, -12(s0) 
	call	deallocate 
kernel_autoL42:
	auipc	a1, %hi(%pcrel(free_block_list))
	lw	a0, %lo(%larel(free_block_list,kernel_autoL42))(a1)
	lw	a2, -12(s0) 
	sw	a0, 0(a2) 
	lw	a0, -12(s0) 
	sw	a0, %lo(%larel(free_block_list,kernel_autoL42))(a1)
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end11:
	#	-- End function 
assign_ram_block:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
kernel_autoL43:
	auipc	a0, %hi(%pcrel(free_block_list))
	lw	a0, %lo(%larel(free_block_list,kernel_autoL43))(a0)
	bnez	a0, kernel_LBB12_2 
	j	kernel_LBB12_1 
kernel_LBB12_1:
	li	a0, 0 
	sw	a0, -12(s0) 
	j	kernel_LBB12_5 
kernel_LBB12_2:
kernel_autoL44:
	auipc	a0, %hi(%pcrel(free_block_list))
	lw	a1, %lo(%larel(free_block_list,kernel_autoL44))(a0)
	sw	a1, -16(s0) 
	lw	a1, -16(s0) 
	lw	a1, 0(a1) 
	sw	a1, %lo(%larel(free_block_list,kernel_autoL44))(a0)
	lw	a0, %lo(%larel(free_block_list,kernel_autoL44))(a0)
	beqz	a0, kernel_LBB12_4 
	j	kernel_LBB12_3 
kernel_LBB12_3:
kernel_autoL45:
	auipc	a0, %hi(%pcrel(free_block_list))
	lw	a1, %lo(%larel(free_block_list,kernel_autoL45))(a0)
	li	a0, 0 
	sw	a0, 4(a1) 
	j	kernel_LBB12_4 
kernel_LBB12_4:
	lw	a1, -16(s0) 
	li	a0, 0 
	sw	a0, 0(a1) 
	lw	a1, -16(s0) 
	sw	a0, 4(a1) 
kernel_autoL46:
	auipc	a0, %hi(%pcrel(kernel_L.str.9))
	addi	a0, a0, %lo(%larel(kernel_L.str.9,kernel_autoL46))
	call	print 
	lw	a0, -16(s0) 
	sw	a0, -12(s0) 
	j	kernel_LBB12_5 
kernel_LBB12_5:
	lw	a0, -12(s0) 
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end12:
	#	-- End function 
load_bd_block:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
	sw	a1, -16(s0) 
kernel_autoL47:
	auipc	a0, %hi(%pcrel(block_device_code))
	lw	a0, %lo(%larel(block_device_code,kernel_autoL47))(a0)
	li	a1, 1 
	call	find_device 
	sw	a0, -20(s0) 
	lw	a0, -20(s0) 
	bnez	a0, kernel_LBB13_2 
	j	kernel_LBB13_1 
kernel_LBB13_1:
kernel_autoL48:
	auipc	a0, %hi(%pcrel(kernel_L.str.10))
	addi	a0, a0, %lo(%larel(kernel_L.str.10,kernel_autoL48))
	call	print 
	j	kernel_LBB13_3 
kernel_LBB13_2:
kernel_autoL49:
	auipc	a0, %hi(%pcrel(kernel_L.str.11))
	addi	a0, a0, %lo(%larel(kernel_L.str.11,kernel_autoL49))
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
kernel_autoL50:
	auipc	a0, %hi(%pcrel(DMA_portal_ptr))
	lw	a2, %lo(%larel(DMA_portal_ptr,kernel_autoL50))(a0)
	sw	a1, 0(a2) 
	lw	a1, -16(s0) 
	lw	a2, %lo(%larel(DMA_portal_ptr,kernel_autoL50))(a0)
	sw	a1, 4(a2) 
	lw	a1, %lo(%larel(DMA_portal_ptr,kernel_autoL50))(a0)
	lui	a0, 1 
	sw	a0, 8(a1) 
	j	kernel_LBB13_3 
kernel_LBB13_3:
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
kernel_Lfunc_end13:
	#	-- End function 
load_inode:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
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
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
kernel_Lfunc_end14:
	#	-- End function 
load_file:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
kernel_autoL51:
	auipc	a0, %hi(%pcrel(kernel_L.str.12))
	addi	a0, a0, %lo(%larel(kernel_L.str.12,kernel_autoL51))
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
kernel_autoL52:
	auipc	a0, %hi(%pcrel(kernel_L.str.13))
	addi	a0, a0, %lo(%larel(kernel_L.str.13,kernel_autoL52))
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
kernel_LBB15_5:
	lw	a0, -28(s0) 
	lw	a1, -16(s0) 
	bgeu	a0, a1, kernel_LBB15_8 
	j	kernel_LBB15_6 
kernel_LBB15_6:
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
kernel_LBB15_7:
	lw	a0, -28(s0) 
	addi	a0, a0, 1 
	sw	a0, -28(s0) 
	j	kernel_LBB15_5 
kernel_LBB15_8:
kernel_autoL53:
	auipc	a0, %hi(%pcrel(kernel_L.str.14))
	addi	a0, a0, %lo(%larel(kernel_L.str.14,kernel_autoL53))
	call	print 
	j	kernel_LBB15_9 
kernel_LBB15_9:
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
kernel_Lfunc_end15:
	#	-- End function 
preload_directory:
	#	%bb.0: 
	addi	sp, sp, -48 
	sw	ra, 44(sp) # 4-byte Folded Spill 
	sw	s0, 40(sp) # 4-byte Folded Spill 
	addi	s0, sp, 48 
	sw	a0, -12(s0) 
	sw	a1, -16(s0) 
kernel_autoL54:
	auipc	a0, %hi(%pcrel(kernel_L.str.15))
	addi	a0, a0, %lo(%larel(kernel_L.str.15,kernel_autoL54))
	call	print 
	lw	a0, -12(s0) 
	call	unendianify 
	addi	a1, s0, -25 
	sw	a1, -40(s0) # 4-byte Folded Spill 
	call	int_to_hex 
	lw	a0, -40(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL55:
	auipc	a0, %hi(%pcrel(kernel_L.str.1))
	addi	a0, a0, %lo(%larel(kernel_L.str.1,kernel_autoL55))
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
	lw	ra, 44(sp) # 4-byte Folded Reload 
	lw	s0, 40(sp) # 4-byte Folded Reload 
	addi	sp, sp, 48 
	ret	
kernel_Lfunc_end16:
	#	-- End function 
preload_fs:
	#	%bb.0: 
	addi	sp, sp, -64 
	sw	ra, 60(sp) # 4-byte Folded Spill 
	sw	s0, 56(sp) # 4-byte Folded Spill 
	addi	s0, sp, 64 
kernel_autoL56:
	auipc	a0, %hi(%pcrel(kernel_L.str.16))
	addi	a0, a0, %lo(%larel(kernel_L.str.16,kernel_autoL56))
	call	print 
	call	assign_ram_block 
	sw	a0, -12(s0) 
	lw	a0, -12(s0) 
	bnez	a0, kernel_LBB17_2 
	j	kernel_LBB17_1 
kernel_LBB17_1:
kernel_autoL57:
	auipc	a0, %hi(%pcrel(kernel_L.str.17))
	addi	a0, a0, %lo(%larel(kernel_L.str.17,kernel_autoL57))
	call	print 
	j	kernel_LBB17_3 
kernel_LBB17_2:
kernel_autoL58:
	auipc	a0, %hi(%pcrel(kernel_L.str.18))
	addi	a0, a0, %lo(%larel(kernel_L.str.18,kernel_autoL58))
	call	print 
	lw	a0, -12(s0) 
	lw	a0, 8(a0) 
	addi	a1, s0, -21 
	sw	a1, -64(s0) # 4-byte Folded Spill 
	call	int_to_hex 
	lw	a0, -64(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL59:
	auipc	a0, %hi(%pcrel(kernel_L.str.1))
	addi	a0, a0, %lo(%larel(kernel_L.str.1,kernel_autoL59))
	sw	a0, -52(s0) # 4-byte Folded Spill 
	call	print 
	lw	a0, -12(s0) 
	lw	a1, 8(a0) 
	li	a0, 0 
	call	load_bd_block 
kernel_autoL60:
	auipc	a0, %hi(%pcrel(kernel_L.str.19))
	addi	a0, a0, %lo(%larel(kernel_L.str.19,kernel_autoL60))
	call	print 
	lw	a0, -12(s0) 
	lw	a0, 8(a0) 
	sw	a0, -28(s0) 
kernel_autoL61:
	auipc	a0, %hi(%pcrel(kernel_L.str.20))
	addi	a0, a0, %lo(%larel(kernel_L.str.20,kernel_autoL61))
	call	print 
	lw	a0, -28(s0) 
	lw	a0, 0(a0) 
	call	unendianify 
	addi	a1, s0, -37 
	sw	a1, -60(s0) # 4-byte Folded Spill 
	call	int_to_hex 
	lw	a0, -60(s0) # 4-byte Folded Reload 
	call	print 
	lw	a0, -52(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL62:
	auipc	a0, %hi(%pcrel(kernel_L.str.21))
	addi	a0, a0, %lo(%larel(kernel_L.str.21,kernel_autoL62))
	call	print 
	lw	a0, -28(s0) 
	lw	a0, 4(a0) 
	call	unendianify 
	addi	a1, s0, -46 
	sw	a1, -56(s0) # 4-byte Folded Spill 
	call	int_to_hex 
	lw	a0, -56(s0) # 4-byte Folded Reload 
	call	print 
	lw	a0, -52(s0) # 4-byte Folded Reload 
	call	print 
	lw	a0, -28(s0) 
	lw	a0, 12(a0) 
	lw	a1, -12(s0) 
	call	preload_directory 
	j	kernel_LBB17_3 
kernel_LBB17_3:
	lw	ra, 60(sp) # 4-byte Folded Reload 
	lw	s0, 56(sp) # 4-byte Folded Reload 
	addi	sp, sp, 64 
	ret	
kernel_Lfunc_end17:
	#	-- End function 
RAM_load_block:
	#	%bb.0: 
	addi	sp, sp, -48 
	sw	ra, 44(sp) # 4-byte Folded Spill 
	sw	s0, 40(sp) # 4-byte Folded Spill 
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
kernel_autoL63:
	auipc	a0, %hi(%pcrel(kernel_L.str.22))
	addi	a0, a0, %lo(%larel(kernel_L.str.22,kernel_autoL63))
	call	print 
	li	a0, 0 
	sw	a0, -12(s0) 
	j	kernel_LBB18_3 
kernel_LBB18_2:
	lw	a0, -28(s0) 
kernel_autoL64:
	auipc	a1, %hi(%pcrel(current_process))
	lw	a1, %lo(%larel(current_process,kernel_autoL64))(a1)
	sw	a0, 32(a1) 
	li	a0, 5 
	sw	a0, -32(s0) 
	lw	a0, -32(s0) 
	lw	a1, -24(s0) 
	call	find_device 
	sw	a0, -36(s0) 
	lw	a0, -36(s0) 
	lw	a0, 4(a0) 
kernel_autoL65:
	auipc	a1, %hi(%pcrel(DMA_portal_ptr))
	lw	a2, %lo(%larel(DMA_portal_ptr,kernel_autoL65))(a1)
	sw	a0, 0(a2) 
	lw	a0, -16(s0) 
	lw	a2, %lo(%larel(DMA_portal_ptr,kernel_autoL65))(a1)
	sw	a0, 4(a2) 
	lw	a2, -36(s0) 
	lw	a0, 8(a2) 
	lw	a2, 4(a2) 
	sub	a0, a0, a2 
	lw	a1, %lo(%larel(DMA_portal_ptr,kernel_autoL65))(a1)
	sw	a0, 8(a1) 
	lw	a0, -28(s0) 
	sw	a0, -12(s0) 
	j	kernel_LBB18_3 
kernel_LBB18_3:
	lw	a0, -12(s0) 
	lw	ra, 44(sp) # 4-byte Folded Reload 
	lw	s0, 40(sp) # 4-byte Folded Reload 
	addi	sp, sp, 48 
	ret	
kernel_Lfunc_end18:
	#	-- End function 
allocate_process_stack:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
	lui	a0, 2 
	call	malloc_custom 
	sw	a0, -12(s0) 
	lw	a0, -12(s0) 
	bnez	a0, kernel_LBB19_2 
	j	kernel_LBB19_1 
kernel_LBB19_1:
kernel_autoL66:
	auipc	a0, %hi(%pcrel(kernel_L.str.23))
	addi	a0, a0, %lo(%larel(kernel_L.str.23,kernel_autoL66))
	call	print 
	j	kernel_LBB19_2 
kernel_LBB19_2:
	lw	a0, -12(s0) 
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end19:
	#	-- End function 
add_process:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
	sw	a0, -12(s0) 
kernel_autoL67:
	auipc	a0, %hi(%pcrel(process_list))
	lw	a0, %lo(%larel(process_list,kernel_autoL67))(a0)
	bnez	a0, kernel_LBB20_2 
	j	kernel_LBB20_1 
kernel_LBB20_1:
	lw	a0, -12(s0) 
kernel_autoL68:
	auipc	a1, %hi(%pcrel(process_list))
	sw	a0, %lo(%larel(process_list,kernel_autoL68))(a1)
	lw	a0, -12(s0) 
	sw	a0, 4(a0) 
	lw	a0, -12(s0) 
	sw	a0, 8(a0) 
	j	kernel_LBB20_3 
kernel_LBB20_2:
kernel_autoL69:
	auipc	a1, %hi(%pcrel(process_list))
	lw	a0, %lo(%larel(process_list,kernel_autoL69))(a1)
	lw	a0, 8(a0) 
	sw	a0, -16(s0) 
	lw	a0, -12(s0) 
	lw	a2, -16(s0) 
	sw	a0, 4(a2) 
	lw	a0, -16(s0) 
	lw	a2, -12(s0) 
	sw	a0, 8(a2) 
	lw	a0, %lo(%larel(process_list,kernel_autoL69))(a1)
	lw	a2, -12(s0) 
	sw	a0, 4(a2) 
	lw	a0, -12(s0) 
	lw	a1, %lo(%larel(process_list,kernel_autoL69))(a1)
	sw	a0, 8(a1) 
	j	kernel_LBB20_3 
kernel_LBB20_3:
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end20:
	#	-- End function 
remove_process:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
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
kernel_autoL70:
	auipc	a1, %hi(%pcrel(process_list))
	li	a0, 0 
	sw	a0, %lo(%larel(process_list,kernel_autoL70))(a1)
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
kernel_autoL71:
	auipc	a0, %hi(%pcrel(process_list))
	lw	a0, %lo(%larel(process_list,kernel_autoL71))(a0)
	lw	a1, -12(s0) 
	bne	a0, a1, kernel_LBB21_5 
	j	kernel_LBB21_4 
kernel_LBB21_4:
	lw	a0, -12(s0) 
	lw	a0, 4(a0) 
kernel_autoL72:
	auipc	a1, %hi(%pcrel(process_list))
	sw	a0, %lo(%larel(process_list,kernel_autoL72))(a1)
	j	kernel_LBB21_5 
kernel_LBB21_5:
	j	kernel_LBB21_6 
kernel_LBB21_6:
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end21:
	#	-- End function 
create_process:
	#	%bb.0: 
	addi	sp, sp, -64 
	sw	ra, 60(sp) # 4-byte Folded Spill 
	sw	s0, 56(sp) # 4-byte Folded Spill 
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
kernel_autoL73:
	auipc	a0, %hi(%pcrel(kernel_L.str.24))
	addi	a0, a0, %lo(%larel(kernel_L.str.24,kernel_autoL73))
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
kernel_autoL74:
	auipc	a0, %hi(%pcrel(kernel_L.str.25))
	addi	a0, a0, %lo(%larel(kernel_L.str.25,kernel_autoL74))
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
kernel_autoL75:
	auipc	a0, %hi(%pcrel(free_block_list))
	lw	a0, %lo(%larel(free_block_list,kernel_autoL75))(a0)
	beqz	a0, kernel_LBB22_6 
	j	kernel_LBB22_5 
kernel_LBB22_5:
kernel_autoL76:
	auipc	a1, %hi(%pcrel(free_block_list))
	lw	a0, %lo(%larel(free_block_list,kernel_autoL76))(a1)
	sw	a0, -28(s0) 
	lw	a0, %lo(%larel(free_block_list,kernel_autoL76))(a1)
	lw	a0, 0(a0) 
	sw	a0, %lo(%larel(free_block_list,kernel_autoL76))(a1)
	lw	a1, -28(s0) 
	li	a0, 0 
	sw	a0, 4(a1) 
	lw	a1, -28(s0) 
	sw	a0, 0(a1) 
	lw	a0, -28(s0) 
	lw	a1, -20(s0) 
	sw	a0, 32(a1) 
kernel_autoL77:
	auipc	a0, %hi(%pcrel(kernel_L.str.26))
	addi	a0, a0, %lo(%larel(kernel_L.str.26,kernel_autoL77))
	call	print 
	lw	a0, -20(s0) 
	lw	a0, 32(a0) 
	lw	a0, 8(a0) 
	addi	a1, s0, -37 
	sw	a1, -52(s0) # 4-byte Folded Spill 
	call	int_to_hex 
	lw	a0, -52(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL78:
	auipc	a0, %hi(%pcrel(kernel_L.str.1))
	addi	a0, a0, %lo(%larel(kernel_L.str.1,kernel_autoL78))
	call	print 
	j	kernel_LBB22_7 
kernel_LBB22_6:
kernel_autoL79:
	auipc	a0, %hi(%pcrel(kernel_L.str.27))
	addi	a0, a0, %lo(%larel(kernel_L.str.27,kernel_autoL79))
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
kernel_autoL80:
	auipc	a0, %hi(%pcrel(kernel_L.str.28))
	addi	a0, a0, %lo(%larel(kernel_L.str.28,kernel_autoL80))
	call	print 
	lw	a0, -12(s0) 
	addi	a1, s0, -46 
	sw	a1, -56(s0) # 4-byte Folded Spill 
	call	int_to_hex 
	lw	a0, -56(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL81:
	auipc	a0, %hi(%pcrel(kernel_L.str.29))
	addi	a0, a0, %lo(%larel(kernel_L.str.29,kernel_autoL81))
	call	print 
	lw	a1, -56(s0) # 4-byte Folded Reload 
	lw	a0, -16(s0) 
	call	int_to_hex 
	lw	a0, -56(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL82:
	auipc	a0, %hi(%pcrel(kernel_L.str.30))
	addi	a0, a0, %lo(%larel(kernel_L.str.30,kernel_autoL82))
	call	print 
	lw	a1, -56(s0) # 4-byte Folded Reload 
	lw	a0, -20(s0) 
	lw	a0, 32(a0) 
	lw	a0, 8(a0) 
	call	int_to_hex 
	lw	a0, -56(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL83:
	auipc	a0, %hi(%pcrel(kernel_L.str.1))
	addi	a0, a0, %lo(%larel(kernel_L.str.1,kernel_autoL83))
	call	print 
	j	kernel_LBB22_8 
kernel_LBB22_8:
	lw	ra, 60(sp) # 4-byte Folded Reload 
	lw	s0, 56(sp) # 4-byte Folded Reload 
	addi	sp, sp, 64 
	ret	
kernel_Lfunc_end22:
	#	-- End function 
print_process_list:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
kernel_autoL84:
	auipc	a0, %hi(%pcrel(process_list))
	lw	a0, %lo(%larel(process_list,kernel_autoL84))(a0)
	bnez	a0, kernel_LBB23_2 
	j	kernel_LBB23_1 
kernel_LBB23_1:
kernel_autoL85:
	auipc	a0, %hi(%pcrel(kernel_L.str.31))
	addi	a0, a0, %lo(%larel(kernel_L.str.31,kernel_autoL85))
	call	print 
	j	kernel_LBB23_5 
kernel_LBB23_2:
kernel_autoL86:
	auipc	a0, %hi(%pcrel(process_list))
	lw	a0, %lo(%larel(process_list,kernel_autoL86))(a0)
	sw	a0, -12(s0) 
kernel_autoL87:
	auipc	a0, %hi(%pcrel(kernel_L.str.32))
	addi	a0, a0, %lo(%larel(kernel_L.str.32,kernel_autoL87))
	call	print 
	j	kernel_LBB23_3 
kernel_LBB23_3:
kernel_autoL88:
	auipc	a0, %hi(%pcrel(kernel_L.str.33))
	addi	a0, a0, %lo(%larel(kernel_L.str.33,kernel_autoL88))
	call	print 
	lw	a0, -12(s0) 
	lw	a0, 0(a0) 
	addi	a1, s0, -21 
	sw	a1, -28(s0) # 4-byte Folded Spill 
	call	int_to_hex 
	lw	a0, -28(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL89:
	auipc	a0, %hi(%pcrel(kernel_L.str.34))
	addi	a0, a0, %lo(%larel(kernel_L.str.34,kernel_autoL89))
	call	print 
	lw	a1, -28(s0) # 4-byte Folded Reload 
	lw	a0, -12(s0) 
	lw	a0, 12(a0) 
	call	int_to_hex 
	lw	a0, -28(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL90:
	auipc	a0, %hi(%pcrel(kernel_L.str.35))
	addi	a0, a0, %lo(%larel(kernel_L.str.35,kernel_autoL90))
	call	print 
	lw	a1, -28(s0) # 4-byte Folded Reload 
	lw	a0, -12(s0) 
	lw	a0, 16(a0) 
	call	int_to_hex 
	lw	a0, -28(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL91:
	auipc	a0, %hi(%pcrel(kernel_L.str.1))
	addi	a0, a0, %lo(%larel(kernel_L.str.1,kernel_autoL91))
	call	print 
	lw	a0, -12(s0) 
	lw	a0, 4(a0) 
	sw	a0, -12(s0) 
	j	kernel_LBB23_4 
kernel_LBB23_4:
	lw	a0, -12(s0) 
kernel_autoL92:
	auipc	a1, %hi(%pcrel(process_list))
	lw	a1, %lo(%larel(process_list,kernel_autoL92))(a1)
	bne	a0, a1, kernel_LBB23_3 
	j	kernel_LBB23_5 
kernel_LBB23_5:
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
kernel_Lfunc_end23:
	#	-- End function 
schedule_next:
	#	%bb.0: 
	addi	sp, sp, -48 
	sw	ra, 44(sp) # 4-byte Folded Spill 
	sw	s0, 40(sp) # 4-byte Folded Spill 
	addi	s0, sp, 48 
kernel_autoL93:
	auipc	a0, %hi(%pcrel(kernel_L.str.36))
	addi	a0, a0, %lo(%larel(kernel_L.str.36,kernel_autoL93))
	call	print 
kernel_autoL94:
	auipc	a0, %hi(%pcrel(process_list))
	lw	a0, %lo(%larel(process_list,kernel_autoL94))(a0)
	bnez	a0, kernel_LBB24_2 
	j	kernel_LBB24_1 
kernel_LBB24_1:
kernel_autoL95:
	auipc	a0, %hi(%pcrel(kernel_L.str.37))
	addi	a0, a0, %lo(%larel(kernel_L.str.37,kernel_autoL95))
	call	print 
	j	kernel_LBB24_8 
kernel_LBB24_2:
kernel_autoL96:
	auipc	a0, %hi(%pcrel(current_process))
	lw	a0, %lo(%larel(current_process,kernel_autoL96))(a0)
	bnez	a0, kernel_LBB24_4 
	j	kernel_LBB24_3 
kernel_LBB24_3:
kernel_autoL97:
	auipc	a0, %hi(%pcrel(process_list))
	lw	a0, %lo(%larel(process_list,kernel_autoL97))(a0)
kernel_autoL98:
	auipc	a1, %hi(%pcrel(current_process))
	sw	a0, %lo(%larel(current_process,kernel_autoL98))(a1)
	j	kernel_LBB24_5 
kernel_LBB24_4:
kernel_autoL99:
	auipc	a1, %hi(%pcrel(current_process))
	lw	a0, %lo(%larel(current_process,kernel_autoL99))(a1)
	lw	a0, 4(a0) 
	sw	a0, %lo(%larel(current_process,kernel_autoL99))(a1)
	j	kernel_LBB24_5 
kernel_LBB24_5:
kernel_autoL100:
	auipc	a0, %hi(%pcrel(kernel_L.str.38))
	addi	a0, a0, %lo(%larel(kernel_L.str.38,kernel_autoL100))
	call	print 
kernel_autoL101:
	auipc	a0, %hi(%pcrel(current_process))
	sw	a0, -32(s0) # 4-byte Folded Spill 
	lw	a0, %lo(%larel(current_process,kernel_autoL101))(a0)
	lw	a0, 0(a0) 
	addi	a1, s0, -17 
	sw	a1, -36(s0) # 4-byte Folded Spill 
	call	int_to_hex 
	lw	a0, -36(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL102:
	auipc	a0, %hi(%pcrel(kernel_L.str.39))
	addi	a0, a0, %lo(%larel(kernel_L.str.39,kernel_autoL102))
	call	print 
	lw	a1, -36(s0) # 4-byte Folded Reload 
	lw	a0, -32(s0) # 4-byte Folded Reload 
	lw	a0, %lo(%larel(current_process,kernel_autoL101))(a0)
	lw	a0, 20(a0) 
	call	int_to_hex 
	lw	a0, -36(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL103:
	auipc	a0, %hi(%pcrel(kernel_L.str.1))
	addi	a0, a0, %lo(%larel(kernel_L.str.1,kernel_autoL103))
	call	print 
	lw	a0, -32(s0) # 4-byte Folded Reload 
	lw	a0, %lo(%larel(current_process,kernel_autoL101))(a0)
	lw	a0, 32(a0) 
	beqz	a0, kernel_LBB24_7 
	j	kernel_LBB24_6 
kernel_LBB24_6:
kernel_autoL104:
	auipc	a2, %hi(%pcrel(current_process))
	lw	a0, %lo(%larel(current_process,kernel_autoL104))(a2)
	lw	a0, 32(a0) 
	lw	a0, 8(a0) 
	sw	a0, -24(s0) 
	lw	a0, -24(s0) 
	lui	a1, 8 
	add	a0, a0, a1 
	sw	a0, -28(s0) 
	lw	a0, -24(s0) 
	lw	a1, -28(s0) 
	lw	a3, %lo(%larel(current_process,kernel_autoL104))(a2)
	lw	a2, 24(a3) 
	lw	a3, 20(a3) 
	call	set_registers 
	j	kernel_LBB24_8 
kernel_LBB24_7:
kernel_autoL105:
	auipc	a0, %hi(%pcrel(kernel_L.str.40))
	addi	a0, a0, %lo(%larel(kernel_L.str.40,kernel_autoL105))
	call	print 
	j	kernel_LBB24_8 
kernel_LBB24_8:
	lw	ra, 44(sp) # 4-byte Folded Reload 
	lw	s0, 40(sp) # 4-byte Folded Reload 
	addi	sp, sp, 48 
	ret	
kernel_Lfunc_end24:
	#	-- End function 
alarm_scheduler:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
	call	clock_alarm_handler 
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end25:
	#	-- End function 
tester:
	#	%bb.0: 
	addi	sp, sp, -16 
	sw	ra, 12(sp) # 4-byte Folded Spill 
	sw	s0, 8(sp) # 4-byte Folded Spill 
	addi	s0, sp, 16 
	call	init_RAM_blocks 
	call	preload_fs 
	lw	ra, 12(sp) # 4-byte Folded Reload 
	lw	s0, 8(sp) # 4-byte Folded Reload 
	addi	sp, sp, 16 
	ret	
kernel_Lfunc_end26:
	#	-- End function 
custom_do_exit:
	#	%bb.0: 
	addi	sp, sp, -32 
	sw	ra, 28(sp) # 4-byte Folded Spill 
	sw	s0, 24(sp) # 4-byte Folded Spill 
	addi	s0, sp, 32 
	sw	a0, -12(s0) 
kernel_autoL106:
	auipc	a0, %hi(%pcrel(current_process))
	sw	a0, -28(s0) # 4-byte Folded Spill 
	lw	a0, %lo(%larel(current_process,kernel_autoL106))(a0)
	lw	a0, 32(a0) 
	call	free_RAM_block 
	lw	a0, -28(s0) # 4-byte Folded Reload 
	lw	a0, %lo(%larel(current_process,kernel_autoL106))(a0)
	call	remove_process 
	lw	a0, -12(s0) 
	bnez	a0, kernel_LBB27_2 
	j	kernel_LBB27_1 
kernel_LBB27_1:
kernel_autoL107:
	auipc	a0, %hi(%pcrel(kernel_L.str.41))
	addi	a0, a0, %lo(%larel(kernel_L.str.41,kernel_autoL107))
	call	print 
	j	kernel_LBB27_3 
kernel_LBB27_2:
	lw	a0, -12(s0) 
	addi	a1, s0, -21 
	sw	a1, -32(s0) # 4-byte Folded Spill 
	call	int_to_hex 
kernel_autoL108:
	auipc	a0, %hi(%pcrel(kernel_L.str.42))
	addi	a0, a0, %lo(%larel(kernel_L.str.42,kernel_autoL108))
	call	print 
	lw	a0, -32(s0) # 4-byte Folded Reload 
	call	print 
kernel_autoL109:
	auipc	a0, %hi(%pcrel(kernel_L.str.1))
	addi	a0, a0, %lo(%larel(kernel_L.str.1,kernel_autoL109))
	call	print 
	j	kernel_LBB27_3 
kernel_LBB27_3:
kernel_autoL110:
	auipc	a0, %hi(%pcrel(process_list))
	lw	a0, %lo(%larel(process_list,kernel_autoL110))(a0)
	bnez	a0, kernel_LBB27_5 
	j	kernel_LBB27_4 
kernel_LBB27_4:
	call	syscall_handler_halt 
	j	kernel_LBB27_6 
kernel_LBB27_5:
	call	schedule_next 
	j	kernel_LBB27_6 
kernel_LBB27_6:
	lw	ra, 28(sp) # 4-byte Folded Reload 
	lw	s0, 24(sp) # 4-byte Folded Reload 
	addi	sp, sp, 32 
	ret	
kernel_Lfunc_end27:
	#	-- End function 
free_head:
	.Numeric
	.byte 0 0 0 0 0 0 0 0 0 0 0 0 
free_tail:
	.byte 0 0 0 0 0 0 0 0 0 0 0 0 
free_block_list:
	.word	0
current_process:
	.word	0
heap_limit:
	.word	0                               # 0x0
hex_digits:
	.Text
	.ascii	"0123456789abcdef"
run_programs.next_program_ROM:
	.Numeric
	.word	3                               # 0x3
kernel_L.str:
	.Text
	.asciz	"Searching for ROM #"
kernel_L.str.1:
	.asciz	"\n"
kernel_L.str.2:
	.asciz	"kernel_limit = "
kernel_L.str.3:
	.asciz	"RAM_limit = "
kernel_L.str.4:
	.asciz	"Allocated block at address = "
kernel_L.str.5:
	.asciz	"block could not be allocated"
kernel_L.str.6:
	.asciz	"freeblocklisthead= "
kernel_L.str.7:
	.asciz	"free block list initialized:\n"
kernel_L.str.8:
	.asciz	"Block base: "
kernel_L.str.9:
	.asciz	"Assigned RAM block\n"
kernel_L.str.10:
	.asciz	"No block device!\n"
kernel_L.str.11:
	.asciz	"loading a bd block!\n"
kernel_L.str.12:
	.asciz	"bruhloading a file"
kernel_L.str.13:
	.asciz	"no user data blocks\n"
kernel_L.str.14:
	.asciz	"Successfully loaded all file blocks \n"
kernel_L.str.15:
	.asciz	"directory inode block number:"
kernel_L.str.16:
	.asciz	"Allocating RAM space for file system startup..\n"
kernel_L.str.17:
	.asciz	"No free RAM blocks available for filesystem.\n"
kernel_L.str.18:
	.asciz	"Filesystem buffer assigned at address: "
kernel_L.str.19:
	.asciz	"Superblock loaded into RAM.\n"
kernel_L.str.20:
	.asciz	"Magic cookie:"
kernel_L.str.21:
	.asciz	"Superblock length:"
kernel_L.str.22:
	.asciz	"RAM_load_block: out of blocks!\n"
kernel_L.str.23:
	.asciz	"stack allocation failed! \n"
process_list:
	.Numeric
	.word	0
kernel_L.str.24:
	.Text
	.asciz	"process control structure allocation failed\n"
kernel_L.str.25:
	.asciz	"process stack allocation is doing bruh burh \n"
kernel_L.str.26:
	.asciz	"process assigned to ram_block at = "
kernel_L.str.27:
	.asciz	"no RAM blocks are available for this process.\n"
kernel_L.str.28:
	.asciz	"Process "
kernel_L.str.29:
	.asciz	" loaded from ROM instance "
kernel_L.str.30:
	.asciz	" assigned to RAM block at address = "
kernel_L.str.31:
	.asciz	"Process list is empty.\n"
kernel_L.str.32:
	.asciz	"Processes in list:\n"
kernel_L.str.33:
	.asciz	"Process ID: "
kernel_L.str.34:
	.asciz	" | Stack Base: "
kernel_L.str.35:
	.asciz	" | Stackkernel_Limit: "
kernel_L.str.36:
	.asciz	"alarm TRIGGERED. \n"
kernel_L.str.37:
	.asciz	"no processes to shcedule. \n"
kernel_L.str.38:
	.asciz	"Current process is: "
kernel_L.str.39:
	.asciz	"Stack pointer is:"
kernel_L.str.40:
	.asciz	"process has no assigned RAM block \n"
kernel_L.str.41:
	.asciz	"Exit was successful with exit code 0.\n"
kernel_L.str.42:
	.asciz	"Exit was unsuccesful with exit code non-zero.\n"
