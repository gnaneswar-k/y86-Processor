`include "../DECODE/reg_file.v"
module decode (clock, D_stat, D_icode, D_ifun, D_rA, D_rB, D_valC, D_valP, e_dstE, M_dstE, m_dstM, W_dstE, W_dstM, e_valE, M_valE, m_valM, W_valE, W_valM, d_stat, d_icode, d_ifun, d_dstE, d_dstM, d_srcA, d_srcB, d_valC, d_valA, d_valB);

input clock;
input [0:3] e_dstE, M_dstE, m_dstM, W_dstE, W_dstM;
input [0:63] e_valE, M_valE, m_valM, W_valE, W_valM;
input [0:3] D_stat, D_icode, D_ifun, D_rA, D_rB;
input [0:63] D_valC, D_valP;

wire [0:63] d_rvalA, d_rvalB;

output reg [0:3] d_dstE, d_dstM, d_srcA, d_srcB, d_stat, d_icode, d_ifun;
output reg [0:63] d_valA, d_valB, d_valC;

// Register file containing the registers from which data is read from and written to.
reg_file registers(clock, d_srcA, d_srcB, d_rvalA, d_rvalB, W_dstE, W_dstM, W_valE, W_valM);

// Combinational logic.
always @(*) begin
	// d_dstE, d_dstM
	if (D_icode == 4'h2 | D_icode == 4'h3 | D_icode == 4'h6) begin //cmovxx | irmovq | opq
		d_dstE = D_rB;
		d_dstM = 4'hF;
	end
	else if (D_icode == 4'h5) begin //mrmovq
		d_dstM = D_rA;
		d_dstE = 4'hF;
	end
	else if (D_icode == 4'h8 | D_icode == 4'h9 | D_icode == 4'hA) begin //call | ret | pushq
		d_dstE = 4'h4;
		d_dstM = 4'hF;
	end
	else if (D_icode == 4'hB) begin //popq
		d_dstE = 4'h4;
		d_dstM = D_rA;
	end
	else begin
		d_dstE = 4'hF;
		d_dstM = 4'hF;
	end

	// d_srcA, d_srcB
	if (D_icode == 4'h2) begin //cmovxx
		d_srcA = D_rA;
		d_srcB = 4'hF;
	end
	else if (D_icode == 4'h4 | D_icode == 4'h5 | D_icode == 4'h6) begin //rmmovq | mrmovq | opq
		d_srcA = D_rA;
		d_srcB = D_rB;
	end
	else if (D_icode == 4'h8) begin //call
		d_srcB = 4'h4;
	end
	else if (D_icode == 4'h9 | D_icode == 4'hB) begin //return | popq
		d_srcA = 4'h4;
		d_srcB = 4'h4;
	end
	else if (D_icode == 4'hA) begin //pushq
		d_srcA = D_rA;
		d_srcB = 4'h4;
	end
	else begin
		d_srcA = 4'hF;
		d_srcB = 4'hF;
	end
	
	// Updating remaining output values.
	d_stat = D_stat;
	d_icode = D_icode;
	d_ifun = D_ifun;
	d_valC = D_valC;
	
	// d_valA
	if (D_icode == 4'h8 | D_icode == 4'h7) //call | jxx
		d_valA = D_valP;
	else if (d_srcA == e_dstE)
		d_valA = e_valE;
	else if (d_srcA == m_dstM)
		d_valA = m_valM;
	else if (d_srcA == M_dstE)
		d_valA = M_valE;
	else if (d_srcA == W_dstM)
		d_valA = W_valM;
	else if (d_srcA == W_dstE)
		d_valA = W_valE;
	else
		d_valA = d_rvalA;
	
	// d_valB
	if (d_srcB == e_dstE)
		d_valB = e_valE;
	else if (d_srcB == m_dstM)
		d_valB = m_valM;
	else if (d_srcB == M_dstE)
		d_valB = M_valE;
	else if (d_srcB == W_dstM)
		d_valB = W_valM;
	else if (d_srcB == W_dstE)
		d_valB = W_valE;
	else
		d_valB = d_rvalB;
end

endmodule