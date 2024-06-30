module PCL (D_icode, d_srcA, d_srcB, E_icode, E_dstM, e_Cnd, M_icode, m_stat, W_stat, F_stall, D_stall, D_bubble, E_bubble, M_bubble, W_stall);

input [0:3] D_icode, d_srcA, d_srcB, E_icode, E_dstM, M_icode, m_stat, W_stat;
input e_Cnd;

reg LU_H, M_B, R, M_E, W_E;

output reg F_stall, D_stall, D_bubble, E_bubble, M_bubble, W_stall;

// Combinational logic.
always @* begin
	// F_stall = 0;
	// D_stall = 0;
	// D_bubble = 0;
	// E_bubble = 0;
	// M_bubble = 0;
	// W_stall = 0;
	
	// Load/Use Hazard
	if ((E_icode == 4'h5 | E_icode == 4'hB) & (E_dstM == d_srcA | E_dstM == d_srcB))
		LU_H = 1;
	else
		LU_H = 0;
	
	// ret
	if (D_icode == 4'h9 | E_icode == 4'h9 | M_icode == 4'h9)
		R = 1;
	else
		R = 0;
	
	// Mispredicted Branch
	if ((E_icode == 4'h7) & ~e_Cnd)
		M_B = 1;
	else
		M_B = 0;
	
	// Error in memory stage
	if (m_stat[1] == 1 | m_stat[2] == 1 | m_stat[3] == 1)
		M_E = 1;
	else
		M_E = 0;
	
	// Error in write_back stage
	if (W_stat[1] == 1 | W_stat[2] == 1 | W_stat[3] == 1)
		W_E = 1;
	else
		W_E = 0;
	
	F_stall = (LU_H | R); // Load/Use Hazard | ret
	
	D_stall = (LU_H); // Load/Use Hazard
	
	D_bubble = (M_B | (~(LU_H) & R)); // Mispredicted Branch | ret without Load/Use Hazard
	
	E_bubble = (LU_H | M_B); // Load/Use Hazard | Mispredicted Branch
	
	M_bubble = (M_E | W_E); // If exception passes through memory stage
	
	W_stall = (W_E); // If exception in current stage
end

endmodule