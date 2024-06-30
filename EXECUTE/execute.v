`include "../ALU/ALU_64_2.v"
module execute (E_bubble, W_stat, m_stat, E_stat, E_icode, E_ifun, E_valA, E_valB, E_valC, E_srcA, E_srcB, E_dstE, E_dstM, e_valE, e_valA, e_stat, e_icode, e_dstE, e_dstM, e_Cnd);

input E_bubble;
input [0:3]  W_stat, m_stat;
input [0:63] E_valA, E_valB, E_valC;
input [0:3] E_stat, E_icode, E_ifun, E_dstE, E_dstM, E_srcA, E_srcB;

reg [0:63] aluA, aluB;
reg [0:2] CC;
reg set_CC;
wire OF_w, SF_w, ZF_w;
wire [0:63] valE_w;

output reg [0:63] e_valE, e_valA;
output reg e_Cnd;
output reg [0:3] e_stat, e_icode, e_dstE, e_dstM;

initial begin
	e_Cnd = 0;
end

// Combinational logic.
always @* begin
	// aluA
	if (E_icode == 4'h2 | E_icode == 4'h6) // cmovxx | opq
		aluA = E_valA;
	else if (E_icode == 4'h3 | E_icode == 4'h4 | E_icode == 4'h5) // irmovq | rmmovq | mrmovq
		aluA = E_valC;
	else if (E_icode == 4'h8 | E_icode == 4'hA) // call | pushq
		aluA = -8;
	else if (E_icode == 4'h9 | E_icode == 4'hB) // ret | popq
		aluA = 8;
	
	// aluB
	if (E_icode == 4'h2 | E_icode == 4'h3) // cmovxx | irmovq
		aluB = 0;
	else if (E_icode == 4'h4 | E_icode == 4'h5 | E_icode == 4'h6 | E_icode == 4'h8 | E_icode == 4'h9 | E_icode == 4'hA | E_icode == 4'hB) // rmmovq | mrmovq | opq | call | ret | pushq | popq
		aluB = E_valB;
	
	// set_CC
	if (E_icode == 4'h6 | E_icode == 4'h0 | m_stat != 4'b1000 | W_stat != 4'b1000) // Condition codes are set only if Arithmetic/Logical operations are performed.
		set_CC = 1;
	else
		set_CC = 0;
	
	// e_Cnd for jxx and cmovxx.
	if (E_icode == 4'h7 | E_icode == 4'h2) begin
		case (E_ifun)
			4'h0 : e_Cnd = 1; // No condition
			4'h1 : begin // le
				if ((CC[1] ^ CC[2]) | CC[0])
					e_Cnd = 1;
				else
					e_Cnd = 0;
			end
			4'h2 : begin // l
				if (CC[1] ^ CC[2])
					e_Cnd = 1;
				else
					e_Cnd = 0;
			end
			4'h3 : begin // e
				if (CC[0])
					e_Cnd = 1;
				else
					e_Cnd = 0;
			end
			4'h4 : begin // ne
				if (~CC[0])
					e_Cnd = 1;
				else
					e_Cnd = 0;
			end
			4'h5 : begin // ge
				if (~(CC[1] ^ CC[2]))
					e_Cnd = 1;
				else
					e_Cnd = 0;
			end
			4'h6 : begin // g
				if (~(CC[1] ^ CC[2]) & ~CC[0])
					e_Cnd = 1;
				else
					e_Cnd = 0;
			end
			default : e_Cnd = 0;
		endcase
	end
end

// ALU for calculations.
ALU_64_2 alu_comp(valE_w,aluA,aluB,E_ifun[2:3],OF_w,ZF_w,SF_w);

// Cobinational logic.
always @* begin
	// Updating Condition Codes based on the instruction and status codes of memory and writeback stages.
	if ((set_CC == 1) & (~(W_stat[1] == 1 | W_stat[2] == 1| W_stat[3] == 1)) & (~(m_stat[1] == 1 | m_stat[2] == 1 | m_stat[3] == 1))) begin
		CC[2] <= OF_w;
		CC[1] <= SF_w;
		CC[0] <= ZF_w;
	end
	
	// Updating the remaining output values.
	e_stat = E_stat;
	e_icode = E_icode;
	e_valA = E_valA;
	e_dstM = E_dstM;
	
	if (E_icode == 4'h2) begin // cmovxx
		if (e_Cnd)
			e_dstE = E_dstE;
		else
			e_dstE = 4'hF;
	end
	else // remaining instructions
		e_dstE = E_dstE;
	
	e_valE = valE_w;
end

endmodule
