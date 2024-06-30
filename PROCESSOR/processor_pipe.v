`timescale 1ns/10ps
`include "../FETCH/fetch.v"
`include "../DECODE/D_reg.v"
`include "../DECODE/decode.v"
`include "../EXECUTE/E_reg.v"
`include "../EXECUTE/execute.v"
`include "../MEMORY/M_reg.v"
`include "../MEMORY/memory.v"
`include "../WRITE_BACK/W_reg.v"
`include "../PCL/PCL.v"
module processor_pipe;

reg clock;
reg [0:3] Stat;

reg [0:63] F_predPC;
wire [0:63] f_valC, f_valP, f_predPC;
wire [0:3] f_icode, f_ifun, f_stat, f_rA, f_rB;

wire [0:3] D_icode, D_ifun, D_rA, D_rB, D_stat;
wire [0:63] D_valC, D_valP;
wire [0:3] d_dstE, d_dstM, d_srcA, d_srcB, d_stat, d_icode, d_ifun;
wire [0:63] d_valA, d_valB, d_valC;

wire [0:3] E_stat, E_icode, E_ifun, E_srcA, E_srcB, E_dstE, E_dstM;
wire [0:63] E_valA, E_valB, E_valC;
wire e_Cnd;
wire [0:3] e_stat, e_icode, e_dstE, e_dstM;
wire [0:63] e_valE, e_valA;

wire M_Cnd;
wire [0:3] M_dstE, M_dstM, M_icode, M_stat;
wire [0:63] M_valA, M_valE;
wire [0:3] m_stat, m_icode, m_dstE, m_dstM;
wire [0:63] m_valE, m_valM;

wire [0:3] W_stat, W_icode, W_dstE, W_dstM;
wire [0:63] W_valE, W_valM;

wire F_stall, D_stall, D_bubble, E_bubble, M_bubble, W_stall;

// Setting up clock.
always #5
	clock = ~clock;

// Updating F register according to stall condition.
always @(posedge clock)
	if (~F_stall)
		F_predPC <= f_predPC;

// Updating status code of processor.
always @(W_stat) begin
	Stat = W_stat;
	
	// 1000 -> AOK
	// 0100 -> ADR
	// 0010 -> INS
	// 0001 -> HLT
	if (Stat != 4'b1000)
		$finish;
end

// Modules for all the stages.
fetch f_comb(F_stall, F_predPC, M_icode, M_Cnd, M_valA, W_icode, W_valM, f_stat, f_icode, f_ifun, f_rA, f_rB, f_valC, f_valP, f_predPC);
D_reg D(clock, D_stall, D_bubble, f_stat, f_icode, f_ifun, f_rA, f_rB, f_valC, f_valP, D_stat, D_icode, D_ifun, D_rA, D_rB, D_valC, D_valP);
decode d_comb(clock, D_stat, D_icode, D_ifun, D_rA, D_rB, D_valC, D_valP, e_dstE, M_dstE, m_dstM, W_dstE, W_dstM, e_valE, M_valE, m_valM, W_valE, W_valM, d_stat, d_icode, d_ifun, d_dstE, d_dstM, d_srcA, d_srcB, d_valC, d_valA, d_valB);
E_reg E(clock, E_bubble, d_stat, d_icode, d_ifun, d_valA, d_valB, d_valC, d_srcA, d_srcB, d_dstE, d_dstM, E_stat, E_icode, E_ifun, E_valA, E_valB, E_valC, E_srcA, E_srcB, E_dstE, E_dstM);
execute e_comb(E_bubble, W_stat, m_stat, E_stat, E_icode, E_ifun, E_valA, E_valB, E_valC, E_srcA, E_srcB, E_dstE, E_dstM, e_valE, e_valA, e_stat, e_icode, e_dstE, e_dstM, e_Cnd);
M_reg M(clock, M_bubble, e_stat, e_icode, e_valA, e_valE, e_Cnd, e_dstE, e_dstM, M_stat, M_icode, M_valA, M_valE, M_Cnd, M_dstE, M_dstM);
memory m_comb(clock, M_bubble, M_stat, M_icode, M_valA, M_valE, M_Cnd, M_dstE, M_dstM, m_valE, m_valM, m_stat, m_icode, m_dstE, m_dstM);
W_reg W(clock, W_stall, m_valE, m_valM, m_stat, m_icode, m_dstE, m_dstM, W_valE, W_valM, W_icode, W_dstE, W_dstM, W_stat);
PCL cont_logic(D_icode, d_srcA, d_srcB, E_icode, E_dstM, e_Cnd, M_icode, m_stat, W_stat, F_stall, D_stall, D_bubble, E_bubble, M_bubble, W_stall);

// Setting initial parameters and code for testing.
initial begin
	$monitor("t = %0t -> f_icode = %h, f_ifun = %h, f_rA = %h, f_rB = %h, f_valC = %h, f_valP = %h, f_stat = %h, d_valA= %h, d_valB= %h, d_valC= %h, d_stat = %h, d_icode = %h, d_ifun = %h, d_dstE = %h, d_dstM = %h, d_srcA = %h, d_srcB = %h, Stat = %b\n",$time,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP, f_stat ,d_valA, d_valB, d_valC, d_stat, d_icode, d_ifun, d_dstE, d_dstM, d_srcA, d_srcB,Stat);
	$dumpfile("processor_pipe_tb.vcd");
	$dumpvars(0,processor_pipe);
	clock = 0;
	F_predPC = 0;
end

endmodule