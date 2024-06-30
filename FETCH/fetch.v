`include "../INST_MEMORY/inst_memory.v"
module fetch (F_stall, F_predPC, M_icode, M_Cnd, M_valA, W_icode, W_valM, f_stat, f_icode, f_ifun, f_rA, f_rB, f_valC, f_valP, f_predPC);

input [0:63] M_valA, W_valM, F_predPC;
input [0:3] M_icode, W_icode;
input F_stall, M_Cnd;

output reg [0:63] f_valC, f_valP, f_predPC;
output reg [0:3] f_icode, f_ifun, f_stat, f_rA, f_rB;

wire [0:79] inst;
wire imem_error;
reg [0:63] valC, valP, f_pc;
reg [0:3] icode;
reg need_regids, need_valC, instr_valid, instr_invalid;

// Setting initial values.
initial begin
	f_pc = F_predPC;
	f_stat = 4'b1000;
	instr_valid = 1;
	need_regids = 0;
	need_valC = 0;
	valC = 0;
	valP = 0;
end

// Selecting the PC from which instruction is to be read.
always @* begin
	if (M_icode == 4'h7 & ~M_Cnd) // Mispredicted Branch
		f_pc = M_valA;
	else if (W_icode == 4'h9) // ret
		f_pc = W_valM;
	else
		f_pc = F_predPC;
end

// Instruction memory module.
inst_memory inst_mem(f_pc,inst,imem_error);

// Combinational logic.
always @* begin
	// Setting icode and f_ifun
	if (imem_error) begin
		icode = 4'h1;
		f_ifun = 4'h0;
	end
	else begin
		icode = inst[0:3];
		f_ifun = inst[4:7];
	end
	
	// Checking if instruction is valid.
	if (icode == 4'h0 | icode == 4'h1 | icode == 4'h2 | icode == 4'h3 | icode == 4'h4 | icode == 4'h5 | icode == 4'h6 | icode == 4'h7 | icode == 4'h8 | icode == 4'h9 | icode == 4'hA | icode == 4'hB)
		instr_valid = 1;
	else
		instr_valid = 0;
	
	instr_invalid = ~instr_valid;
	
	// Checking if registers are needed.
	if (icode == 4'h2 | icode == 4'h3 | icode == 4'h4 | icode == 4'h5 | icode == 4'h6 | icode == 4'hA | icode == 4'hB)
		need_regids = 1;
	else
		need_regids = 0;
	
	//  Checking if valC is needed.
	if (icode == 4'h3 | icode == 4'h4 | icode == 4'h5 | icode == 4'h7 | icode == 4'h8)
		need_valC = 1;
	else
		need_valC = 0;
	
	// Setting the values of f_rA, f_rB and valC.
	if (need_regids == 1) begin
		f_rA = inst[8:11];
		f_rB = inst[12:15];
		valC[0:7] = inst[72:79];
		valC[8:15] = inst[64:71];
		valC[16:23] = inst[56:63];
		valC[24:31] = inst[48:55];
		valC[32:39] = inst[40:47];
		valC[40:47] = inst[32:39];
		valC[48:55] = inst[24:31];
		valC[56:63] = inst[16:23];
	end
	else begin
		f_rA = 4'hF;
		f_rB = 4'hF;
		valC[0:7] = inst[64:71];
		valC[8:15] = inst[56:63];
		valC[16:23] = inst[48:55];
		valC[24:31] = inst[40:47];
		valC[32:39] = inst[32:39];
		valC[40:47] = inst[24:31];
		valC[48:55] = inst[16:23];
		valC[56:63] = inst[8:15];
	end
	
	// PC increment.
	valP = f_pc + 'd1 + need_regids + (need_valC << 3);
	
	// Calculating f_predPC.
	if (icode == 4'h7 | icode == 4'h8)
		f_predPC = valC;
	else
		f_predPC = valP;
	
	// Stat  update.
	if (icode == 4'h0) begin //HLT
		f_stat[0] = 0;
		f_stat[1] = 0;
		f_stat[2] = 0;
		f_stat[3] = 1;
	end
	if (instr_invalid) begin //INS
		f_stat[0] = 0;
		f_stat[1] = 0;
		f_stat[2] = 1;
		f_stat[3] = 0;
	end
	if (imem_error) begin //ADR
		f_stat[0] = 0;
		f_stat[1] = 1;
		f_stat[2] = 0;
		f_stat[3] = 0;
	end
	if ((icode != 4'h0) && instr_valid && ~(imem_error)) begin //AOK
		f_stat[0] = 1;
		f_stat[1] = 0;
		f_stat[2] = 0;
		f_stat[3] = 0;
	end
	
	// Setting remaining output values.
	f_icode = icode;
	f_valC = valC;
	f_valP = valP;
end

endmodule