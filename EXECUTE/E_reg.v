module E_reg (clock, E_bubble, d_stat, d_icode, d_ifun, d_valA, d_valB, d_valC, d_srcA, d_srcB, d_dstE, d_dstM, E_stat, E_icode, E_ifun, E_valA, E_valB, E_valC, E_srcA, E_srcB, E_dstE, E_dstM);

input clock, E_bubble;
input [0:3] d_stat, d_icode, d_ifun, d_srcA, d_srcB, d_dstE, d_dstM;
input [0:63] d_valA, d_valB, d_valC;

output reg [0:3] E_stat, E_icode, E_ifun, E_srcA, E_srcB, E_dstE, E_dstM;
output reg [0:63] E_valA, E_valB, E_valC;

// Updating the E registers according to bubble condition.
always @(posedge clock) begin
	if (E_bubble) begin
		E_dstE <= 4'hF;
		E_dstM <= 4'hF;
		E_icode <= 4'h1;
		E_ifun <= 4'h0;
		E_srcA <= 4'hF;
		E_srcB <= 4'hF;
		E_stat <= 4'b1000;
		E_valA <= 64'd0;
		E_valB <= 64'd0;
		E_valC <= 64'd0;
	end
	else begin
		E_dstE <= d_dstE;
		E_dstM <= d_dstM;
		E_icode <= d_icode;
		E_ifun <= d_ifun;
		E_srcA <= d_srcA;
		E_srcB <= d_srcB;
		E_stat <= d_stat;
		E_valA <= d_valA;
		E_valB <= d_valB;
		E_valC <= d_valC;
	end
end

endmodule