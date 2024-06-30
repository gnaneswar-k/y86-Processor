module W_reg (clock, W_stall, m_valE, m_valM, m_stat, m_icode, m_dstE, m_dstM, W_valE, W_valM, W_icode, W_dstE, W_dstM, W_stat);

input clock, W_stall;
input [0:63] m_valE, m_valM;
input [0:3] m_stat, m_icode, m_dstE, m_dstM;

output reg [0:63] W_valE, W_valM;
output reg [0:3] W_stat, W_icode, W_dstE, W_dstM;

// Updating the W registers according to stall condition.
always @(posedge clock) begin
	if(~W_stall) begin
		W_dstE <= m_dstE;
		W_dstM <= m_dstM;
		W_icode <= m_icode;
		W_stat <= m_stat;
		W_valE <= m_valE;
		W_valM <= m_valM;
	end
end	

endmodule
