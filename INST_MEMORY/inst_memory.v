module inst_memory (PC, inst, imem_error);

parameter MEM_LEN = 'd98; // Using memory length as a parameter to adjust easily for testing.
reg [0:7]inst_mem_module[0:MEM_LEN - 1];

// Instruction memory.
initial begin
	// Own instruction set TEST
	/* inst_mem_module[0] = 8'h10; // nop
	
	inst_mem_module[1] = 8'h30; // irmovq
	inst_mem_module[2] = 8'hF0; // noreg, %rax
	inst_mem_module[3] = 8'h23; // 35
	inst_mem_module[4] = 8'h01; // 256
	inst_mem_module[5] = 8'h00; // 0
	inst_mem_module[6] = 8'h00; // 0
	inst_mem_module[7] = 8'h00; // 0
	inst_mem_module[8] = 8'h00; // 0
	inst_mem_module[9] = 8'h00; // 0
	inst_mem_module[10] = 8'h00; // 0
	
	inst_mem_module[11] = 8'h21; // cmovle
	inst_mem_module[12] = 8'h01; // %rax, %rcx
	
	inst_mem_module[13] = 8'h30; // irmovq
	inst_mem_module[14] = 8'hF2; // noreg, %rdx
	inst_mem_module[15] = 8'h10; // 16
	inst_mem_module[16] = 8'h00; // 0
	inst_mem_module[17] = 8'h00; // 0
	inst_mem_module[18] = 8'h00; // 0
	inst_mem_module[19] = 8'h00; // 0
	inst_mem_module[20] = 8'h00; // 0
	inst_mem_module[21] = 8'h00; // 0
	inst_mem_module[22] = 8'h00; // 0
	
	inst_mem_module[23] = 8'h30; // irmovq
	inst_mem_module[24] = 8'hF3; // noreg, %rbx
	inst_mem_module[25] = 8'h00; // 0
	inst_mem_module[26] = 8'h01; // 256
	inst_mem_module[27] = 8'h00; // 0
	inst_mem_module[28] = 8'h00; // 0
	inst_mem_module[29] = 8'h00; // 0
	inst_mem_module[30] = 8'h00; // 0
	inst_mem_module[31] = 8'h00; // 0
	inst_mem_module[32] = 8'h00; // 0
	
	inst_mem_module[33] = 8'h73; // je
	inst_mem_module[34] = 8'h2C; // 44
	inst_mem_module[35] = 8'h00; // 0
	inst_mem_module[36] = 8'h00; // 0
	inst_mem_module[37] = 8'h00; // 0
	inst_mem_module[38] = 8'h00; // 0
	inst_mem_module[39] = 8'h00; // 0
	inst_mem_module[40] = 8'h00; // 0
	inst_mem_module[41] = 8'h00; // 0
	
	inst_mem_module[42] = 8'h61; // subq
	inst_mem_module[43] = 8'h32; // %rbx, %rdx
	
	inst_mem_module[44] = 8'h71; // jle
	inst_mem_module[45] = 8'h3F; // 63
	inst_mem_module[46] = 8'h00; // 0
	inst_mem_module[47] = 8'h00; // 0
	inst_mem_module[48] = 8'h00; // 0
	inst_mem_module[49] = 8'h00; // 0
	inst_mem_module[50] = 8'h00; // 0
	inst_mem_module[51] = 8'h00; // 0
	inst_mem_module[52] = 8'h00; // 0
	
	inst_mem_module[53] = 8'h30; // irmovq
	inst_mem_module[54] = 8'hF3; // noreg, %rbx
	inst_mem_module[55] = 8'h11; // 17
	inst_mem_module[56] = 8'h01; // 256
	inst_mem_module[57] = 8'h00; // 0
	inst_mem_module[58] = 8'h00; // 0
	inst_mem_module[59] = 8'h00; // 0
	inst_mem_module[60] = 8'h00; // 0
	inst_mem_module[61] = 8'h00; // 0
	inst_mem_module[62] = 8'h00; // 0
	
	inst_mem_module[63] = 8'h21; // cmovle
	inst_mem_module[64] = 8'h01; // %rax, %rcx
	
	inst_mem_module[65] = 8'h30; // irmovq
	inst_mem_module[66] = 8'hF4; // noreg, %rsp
	inst_mem_module[67] = 8'h0A; // 10
	inst_mem_module[68] = 8'h00; // 0
	inst_mem_module[69] = 8'h00; // 0
	inst_mem_module[70] = 8'h00; // 0
	inst_mem_module[71] = 8'h00; // 0
	inst_mem_module[72] = 8'h00; // 0
	inst_mem_module[73] = 8'h00; // 0
	inst_mem_module[74] = 8'h00; // 0
	
	inst_mem_module[75] = 8'h80; // call
	inst_mem_module[76] = 8'h5F; // 95
	inst_mem_module[77] = 8'h00; // 0
	inst_mem_module[78] = 8'h00; // 0
	inst_mem_module[79] = 8'h00; // 0
	inst_mem_module[80] = 8'h00; // 0
	inst_mem_module[81] = 8'h00; // 0
	inst_mem_module[82] = 8'h00; // 0
	inst_mem_module[83] = 8'h00; // 0
	
	inst_mem_module[84] = 8'h40; // rmmovq
	inst_mem_module[85] = 8'h37; // %rbx, %rdi
	inst_mem_module[86] = 8'h05; // 5
	inst_mem_module[87] = 8'h00; // 0
	inst_mem_module[88] = 8'h00; // 0
	inst_mem_module[89] = 8'h00; // 0
	inst_mem_module[90] = 8'h00; // 0
	inst_mem_module[91] = 8'h00; // 0
	inst_mem_module[92] = 8'h00; // 0
	inst_mem_module[93] = 8'h00; // 0
	
	inst_mem_module[94] = 8'h00; // halt
	
	inst_mem_module[95] = 8'h63; // xorq
	inst_mem_module[96] = 8'h01; // %rax, %rcx
	
	inst_mem_module[97] = 8'h90; // ret */
	
	/* inst_mem_module[0] = 8'h30; // irmovq
	inst_mem_module[1] = 8'hF2; // noreg, %rdx
	inst_mem_module[2] = 8'h80; // 128
	inst_mem_module[3] = 8'h00; // 0
	inst_mem_module[4] = 8'h00; // 0
	inst_mem_module[5] = 8'h00; // 0
	inst_mem_module[6] = 8'h00; // 0
	inst_mem_module[7] = 8'h00; // 0
	inst_mem_module[8] = 8'h00; // 0
	inst_mem_module[9] = 8'h00; // 0
	
	inst_mem_module[10] = 8'h30; // irmovq
	inst_mem_module[11] = 8'hF1; // noreg, %rcx
	inst_mem_module[12] = 8'h03; // 3
	inst_mem_module[13] = 8'h00; // 0
	inst_mem_module[14] = 8'h00; // 0
	inst_mem_module[15] = 8'h00; // 0
	inst_mem_module[16] = 8'h00; // 0
	inst_mem_module[17] = 8'h00; // 0
	inst_mem_module[18] = 8'h00; // 0
	inst_mem_module[19] = 8'h00; // 0
	
	inst_mem_module[20] = 8'h40; // rmmovq
	inst_mem_module[21] = 8'h2c; // %rdx, %rcx
	inst_mem_module[22] = 8'h00; // 0
	inst_mem_module[23] = 8'h00; // 0
	inst_mem_module[24] = 8'h00; // 0
	inst_mem_module[25] = 8'h00; // 0
	inst_mem_module[26] = 8'h00; // 0
	inst_mem_module[27] = 8'h00; // 0
	inst_mem_module[28] = 8'h00; // 0
	inst_mem_module[29] = 8'h00; // 0
	
	inst_mem_module[30] = 8'h30; // irmovq
	inst_mem_module[31] = 8'hF3; // noreg, %rbx
	inst_mem_module[32] = 8'h0A; // 10
	inst_mem_module[33] = 8'h00; // 0
	inst_mem_module[34] = 8'h00; // 0
	inst_mem_module[35] = 8'h00; // 0
	inst_mem_module[36] = 8'h00; // 0
	inst_mem_module[37] = 8'h00; // 0
	inst_mem_module[38] = 8'h00; // 0
	inst_mem_module[39] = 8'h00; // 0
	
	inst_mem_module[40] = 8'h50; // mrmovq
	inst_mem_module[41] = 8'h02; // %rax, %rdx
	inst_mem_module[42] = 8'h00; // 0
	inst_mem_module[43] = 8'h00; // 0
	inst_mem_module[44] = 8'h00; // 0
	inst_mem_module[45] = 8'h00; // 0
	inst_mem_module[46] = 8'h00; // 0
	inst_mem_module[47] = 8'h00; // 0
	inst_mem_module[48] = 8'h00; // 0
	inst_mem_module[49] = 8'h00; // 0
	
	inst_mem_module[50] = 8'h60; // addq
	inst_mem_module[51] = 8'h03; // %rax, %rbx
	
	inst_mem_module[52] = 8'h00; // halt */
	
	// Data Forwarding TEST
	inst_mem_module[0] = 8'h10; // nop
	
	inst_mem_module[1] = 8'h30; // irmovq
	inst_mem_module[2] = 8'hF2; // noreg, %rdx
	inst_mem_module[3] = 8'h0A; // 10
	inst_mem_module[4] = 8'h00; // 0
	inst_mem_module[5] = 8'h00; // 0
	inst_mem_module[6] = 8'h00; // 0
	inst_mem_module[7] = 8'h00; // 0
	inst_mem_module[8] = 8'h00; // 0
	inst_mem_module[9] = 8'h00; // 0
	inst_mem_module[10] = 8'h00; // 0
	
	inst_mem_module[11] = 8'h30; // irmovq
	inst_mem_module[12] = 8'hF0; // noreg, %rax
	inst_mem_module[13] = 8'h03; // 3
	inst_mem_module[14] = 8'h00; // 0
	inst_mem_module[15] = 8'h00; // 0
	inst_mem_module[16] = 8'h00; // 0
	inst_mem_module[17] = 8'h00; // 0
	inst_mem_module[18] = 8'h00; // 0
	inst_mem_module[19] = 8'h00; // 0
	inst_mem_module[20] = 8'h00; // 0
	
	inst_mem_module[21] = 8'h60; // addq
	inst_mem_module[22] = 8'h02; // %rax, %rdx
	
	inst_mem_module[23] = 8'h00; // halt */
	
	// ret TEST
	/* inst_mem_module[0] = 8'h10; // nop
	
	inst_mem_module[1] = 8'h30; // irmovq
	inst_mem_module[2] = 8'hF4; // noreg, %rsp
	inst_mem_module[3] = 8'h0A; // 10
	inst_mem_module[4] = 8'h00; // 0
	inst_mem_module[5] = 8'h00; // 0
	inst_mem_module[6] = 8'h00; // 0
	inst_mem_module[7] = 8'h00; // 0
	inst_mem_module[8] = 8'h00; // 0
	inst_mem_module[9] = 8'h00; // 0
	inst_mem_module[10] = 8'h00; // 0
	
	inst_mem_module[11] = 8'h80; // call
	inst_mem_module[12] = 8'h20; // 32
	inst_mem_module[13] = 8'h00; // 0
	inst_mem_module[14] = 8'h00; // 0
	inst_mem_module[15] = 8'h00; // 0
	inst_mem_module[16] = 8'h00; // 0
	inst_mem_module[17] = 8'h00; // 0
	inst_mem_module[18] = 8'h00; // 0
	inst_mem_module[19] = 8'h00; // 0
	
	inst_mem_module[20] = 8'h30; // irmovq
	inst_mem_module[21] = 8'hF6; // noreg, %rsi
	inst_mem_module[22] = 8'h05; // 5
	inst_mem_module[23] = 8'h00; // 0
	inst_mem_module[24] = 8'h00; // 0
	inst_mem_module[25] = 8'h00; // 0
	inst_mem_module[26] = 8'h00; // 0
	inst_mem_module[27] = 8'h00; // 0
	inst_mem_module[28] = 8'h00; // 0
	inst_mem_module[29] = 8'h00; // 0
	
	inst_mem_module[30] = 8'h00; // halt
	
	inst_mem_module[31] = 8'hF0; // invalid
	
	inst_mem_module[32] = 8'h30; // irmovq
	inst_mem_module[33] = 8'hF7; // noreg, %rdi
	inst_mem_module[34] = 8'hFF; // -1
	inst_mem_module[35] = 8'hFF; // 0
	inst_mem_module[36] = 8'hFF; // 0
	inst_mem_module[37] = 8'hFF; // 0
	inst_mem_module[38] = 8'hFF; // 0
	inst_mem_module[39] = 8'hFF; // 0
	inst_mem_module[40] = 8'hFF; // 0
	inst_mem_module[41] = 8'hFF; // 0
	
	inst_mem_module[42] = 8'h90; // ret
	
	inst_mem_module[43] = 8'h30; // irmovq
	inst_mem_module[44] = 8'hF0; // noreg, %rax
	inst_mem_module[45] = 8'h01; // 1
	inst_mem_module[46] = 8'h00; // 0
	inst_mem_module[47] = 8'h00; // 0
	inst_mem_module[48] = 8'h00; // 0
	inst_mem_module[49] = 8'h00; // 0
	inst_mem_module[50] = 8'h00; // 0
	inst_mem_module[51] = 8'h00; // 0
	inst_mem_module[52] = 8'h00; // 0
	
	inst_mem_module[53] = 8'h30; // irmovq
	inst_mem_module[54] = 8'hF1; // noreg, %rcx
	inst_mem_module[55] = 8'h02; // 2
	inst_mem_module[56] = 8'h00; // 0
	inst_mem_module[57] = 8'h00; // 0
	inst_mem_module[58] = 8'h00; // 0
	inst_mem_module[59] = 8'h00; // 0
	inst_mem_module[60] = 8'h00; // 0
	inst_mem_module[61] = 8'h00; // 0
	inst_mem_module[62] = 8'h00; // 0
	
	inst_mem_module[63] = 8'h30; // irmovq
	inst_mem_module[64] = 8'hF2; // noreg, %rdx
	inst_mem_module[65] = 8'h03; // 3
	inst_mem_module[66] = 8'h00; // 0
	inst_mem_module[67] = 8'h00; // 0
	inst_mem_module[68] = 8'h00; // 0
	inst_mem_module[69] = 8'h00; // 0
	inst_mem_module[70] = 8'h00; // 0
	inst_mem_module[71] = 8'h00; // 0
	inst_mem_module[72] = 8'h00; // 0
	
	inst_mem_module[73] = 8'h30; // irmovq
	inst_mem_module[74] = 8'hF3; // noreg, %rbx
	inst_mem_module[75] = 8'h04; // 4
	inst_mem_module[76] = 8'h00; // 0
	inst_mem_module[77] = 8'h00; // 0
	inst_mem_module[78] = 8'h00; // 0
	inst_mem_module[79] = 8'h00; // 0
	inst_mem_module[80] = 8'h00; // 0
	inst_mem_module[81] = 8'h00; // 0
	inst_mem_module[82] = 8'h00; // 0 */
	
	// Mispredicted Branch TEST
	/* inst_mem_module[0] = 8'h10; // nop
	
	inst_mem_module[1] = 8'h63; // xorq
	inst_mem_module[2] = 8'h00; // %rax, %rax
	
	inst_mem_module[3] = 8'h74; // jne
	inst_mem_module[4] = 8'h1A; // 26
	inst_mem_module[5] = 8'h00; // 0
	inst_mem_module[6] = 8'h00; // 0
	inst_mem_module[7] = 8'h00; // 0
	inst_mem_module[8] = 8'h00; // 0
	inst_mem_module[9] = 8'h00; // 0
	inst_mem_module[10] = 8'h00; // 0
	inst_mem_module[11] = 8'h00; // 0
	
	inst_mem_module[12] = 8'h30; // irmovq
	inst_mem_module[13] = 8'hF0; // noreg, %rax
	inst_mem_module[14] = 8'h01; // 1
	inst_mem_module[15] = 8'h00; // 0
	inst_mem_module[16] = 8'h00; // 0
	inst_mem_module[17] = 8'h00; // 0
	inst_mem_module[18] = 8'h00; // 0
	inst_mem_module[19] = 8'h00; // 0
	inst_mem_module[20] = 8'h00; // 0
	inst_mem_module[21] = 8'h00; // 0
	
	inst_mem_module[22] = 8'h10; // nop
	
	inst_mem_module[23] = 8'h10; // nop
	
	inst_mem_module[24] = 8'h10; // nop
	
	inst_mem_module[25] = 8'h00; // halt
	
	inst_mem_module[26] = 8'h30; // irmovq
	inst_mem_module[27] = 8'hF2; // noreg, %rdx
	inst_mem_module[28] = 8'h03; // 3
	inst_mem_module[29] = 8'h00; // 0
	inst_mem_module[30] = 8'h00; // 0
	inst_mem_module[31] = 8'h00; // 0
	inst_mem_module[32] = 8'h00; // 0
	inst_mem_module[33] = 8'h00; // 0
	inst_mem_module[34] = 8'h00; // 0
	inst_mem_module[35] = 8'h00; // 0
	
	inst_mem_module[36] = 8'h30; // irmovq
	inst_mem_module[37] = 8'hF1; // noreg, %rcx
	inst_mem_module[38] = 8'h04; // 4
	inst_mem_module[39] = 8'h00; // 0
	inst_mem_module[40] = 8'h00; // 0
	inst_mem_module[41] = 8'h00; // 0
	inst_mem_module[42] = 8'h00; // 0
	inst_mem_module[43] = 8'h00; // 0
	inst_mem_module[44] = 8'h00; // 0
	inst_mem_module[45] = 8'h00; // 0
	
	inst_mem_module[46] = 8'h30; // irmovq
	inst_mem_module[47] = 8'hF2; // noreg, %rdx
	inst_mem_module[48] = 8'h05; // 5
	inst_mem_module[49] = 8'h00; // 0
	inst_mem_module[50] = 8'h00; // 0
	inst_mem_module[51] = 8'h00; // 0
	inst_mem_module[52] = 8'h00; // 0
	inst_mem_module[53] = 8'h00; // 0
	inst_mem_module[54] = 8'h00; // 0
	inst_mem_module[55] = 8'h00; // 0 */
	
	// Mispredicted Branch and ret TEST
	/* inst_mem_module[0] = 8'h10; // nop
	
	inst_mem_module[1] = 8'h30; // irmovq
	inst_mem_module[2] = 8'hF4; // noreg, %rsp
	inst_mem_module[3] = 8'h20; // 32
	inst_mem_module[4] = 8'h00; // 0
	inst_mem_module[5] = 8'h00; // 0
	inst_mem_module[6] = 8'h00; // 0
	inst_mem_module[7] = 8'h00; // 0
	inst_mem_module[8] = 8'h00; // 0
	inst_mem_module[9] = 8'h00; // 0
	inst_mem_module[10] = 8'h00; // 0
	
	inst_mem_module[11] = 8'h30; // irmovq
	inst_mem_module[12] = 8'hF0; // noreg, %rax
	inst_mem_module[13] = 8'h39; // 57
	inst_mem_module[14] = 8'h00; // 0
	inst_mem_module[15] = 8'h00; // 0
	inst_mem_module[16] = 8'h00; // 0
	inst_mem_module[17] = 8'h00; // 0
	inst_mem_module[18] = 8'h00; // 0
	inst_mem_module[19] = 8'h00; // 0
	inst_mem_module[20] = 8'h00; // 0
	
	inst_mem_module[21] = 8'hA0; // pushq
	inst_mem_module[22] = 8'h0F; // %rax, noreg
	
	inst_mem_module[23] = 8'h63; // xorq
	inst_mem_module[24] = 8'h00; // %rax, %rax
	
	inst_mem_module[25] = 8'h74; // jne
	inst_mem_module[26] = 8'h2D; // 45
	inst_mem_module[27] = 8'h00; // 0
	inst_mem_module[28] = 8'h00; // 0
	inst_mem_module[29] = 8'h00; // 0
	inst_mem_module[30] = 8'h00; // 0
	inst_mem_module[31] = 8'h00; // 0
	inst_mem_module[32] = 8'h00; // 0
	inst_mem_module[33] = 8'h00; // 0
	
	inst_mem_module[34] = 8'h30; // irmovq
	inst_mem_module[35] = 8'hF0; // noreg, %rax
	inst_mem_module[36] = 8'h01; // 1
	inst_mem_module[37] = 8'h00; // 0
	inst_mem_module[38] = 8'h00; // 0
	inst_mem_module[39] = 8'h00; // 0
	inst_mem_module[40] = 8'h00; // 0
	inst_mem_module[41] = 8'h00; // 0
	inst_mem_module[42] = 8'h00; // 0
	inst_mem_module[43] = 8'h00; // 0
	
	inst_mem_module[44] = 8'h00; // halt
	
	inst_mem_module[45] = 8'h90; // ret
	
	inst_mem_module[46] = 8'h30; // irmovq
	inst_mem_module[47] = 8'hF3; // noreg, %rbx
	inst_mem_module[48] = 8'h02; // 2
	inst_mem_module[49] = 8'h00; // 0
	inst_mem_module[50] = 8'h00; // 0
	inst_mem_module[51] = 8'h00; // 0
	inst_mem_module[52] = 8'h00; // 0
	inst_mem_module[53] = 8'h00; // 0
	inst_mem_module[54] = 8'h00; // 0
	inst_mem_module[55] = 8'h00; // 0
	
	inst_mem_module[56] = 8'h00; // halt
	
	inst_mem_module[57] = 8'h30; // irmovq
	inst_mem_module[58] = 8'hF2; // noreg, %rdx
	inst_mem_module[59] = 8'h03; // 3
	inst_mem_module[60] = 8'h00; // 0
	inst_mem_module[61] = 8'h00; // 0
	inst_mem_module[62] = 8'h00; // 0
	inst_mem_module[63] = 8'h00; // 0
	inst_mem_module[64] = 8'h00; // 0
	inst_mem_module[65] = 8'h00; // 0
	inst_mem_module[66] = 8'h00; // 0
	
	inst_mem_module[67] = 8'h00; // halt */
	
	// Load/Use Hazard TEST
	/* inst_mem_module[0] = 8'h10; // nop
	
	inst_mem_module[1] = 8'h30; // irmovq
	inst_mem_module[2] = 8'hF2; // noreg, %rdx
	inst_mem_module[3] = 8'h80; // 128
	inst_mem_module[4] = 8'h00; // 0
	inst_mem_module[5] = 8'h00; // 0
	inst_mem_module[6] = 8'h00; // 0
	inst_mem_module[7] = 8'h00; // 0
	inst_mem_module[8] = 8'h00; // 0
	inst_mem_module[9] = 8'h00; // 0
	inst_mem_module[10] = 8'h00; // 0
	
	inst_mem_module[11] = 8'h30; // irmovq
	inst_mem_module[12] = 8'hF1; // noreg, %rcx
	inst_mem_module[13] = 8'h03; // 3
	inst_mem_module[14] = 8'h00; // 0
	inst_mem_module[15] = 8'h00; // 0
	inst_mem_module[16] = 8'h00; // 0
	inst_mem_module[17] = 8'h00; // 0
	inst_mem_module[18] = 8'h00; // 0
	inst_mem_module[19] = 8'h00; // 0
	inst_mem_module[20] = 8'h00; // 0
	
	inst_mem_module[21] = 8'h40; // rmmovq
	inst_mem_module[22] = 8'h12; // %rcx, %rdx
	inst_mem_module[23] = 8'h00; // 0
	inst_mem_module[24] = 8'h00; // 0
	inst_mem_module[25] = 8'h00; // 0
	inst_mem_module[26] = 8'h00; // 0
	inst_mem_module[27] = 8'h00; // 0
	inst_mem_module[28] = 8'h00; // 0
	inst_mem_module[29] = 8'h00; // 0
	inst_mem_module[30] = 8'h00; // 0
	
	inst_mem_module[31] = 8'h30; // irmovq
	inst_mem_module[32] = 8'hF3; // noreg, %rbx
	inst_mem_module[33] = 8'h0A; // 10
	inst_mem_module[34] = 8'h00; // 0
	inst_mem_module[35] = 8'h00; // 0
	inst_mem_module[36] = 8'h00; // 0
	inst_mem_module[37] = 8'h00; // 0
	inst_mem_module[38] = 8'h00; // 0
	inst_mem_module[39] = 8'h00; // 0
	inst_mem_module[40] = 8'h00; // 0
	
	inst_mem_module[41] = 8'h50; // mrmovq
	inst_mem_module[42] = 8'h02; // %rax, %rdx
	inst_mem_module[43] = 8'h00; // 0
	inst_mem_module[44] = 8'h00; // 0
	inst_mem_module[45] = 8'h00; // 0
	inst_mem_module[46] = 8'h00; // 0
	inst_mem_module[47] = 8'h00; // 0
	inst_mem_module[48] = 8'h00; // 0
	inst_mem_module[49] = 8'h00; // 0
	inst_mem_module[50] = 8'h00; // 0
	
	inst_mem_module[51] = 8'h60; // addq
	inst_mem_module[52] = 8'h30; // %rbx, %rax
	
	inst_mem_module[53] = 8'h00; // halt */
end

input [0:63] PC;

output reg [0:79] inst;
output reg imem_error;

// Checking for error and outputting the required instruction.
always @* begin
	if (PC >= MEM_LEN)
		imem_error = 1;
	else begin
		imem_error = 0;
		
		// Memory is read reversed.
		inst[0:7] = inst_mem_module[PC];
		inst[8:15] = inst_mem_module[PC + 1];
		inst[16:23] = inst_mem_module[PC + 2];
		inst[24:31] = inst_mem_module[PC + 3];
		inst[32:39] = inst_mem_module[PC + 4];
		inst[40:47] = inst_mem_module[PC + 5];
		inst[48:55] = inst_mem_module[PC + 6];
		inst[56:63] = inst_mem_module[PC + 7];
		inst[64:71] = inst_mem_module[PC + 8];
		inst[72:79] = inst_mem_module[PC + 9];
	end
end

endmodule