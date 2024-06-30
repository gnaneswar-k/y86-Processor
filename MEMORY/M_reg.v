module M_reg (clock, M_bubble, e_stat, e_icode, e_valA, e_valE, e_Cnd, e_dstE, e_dstM, M_stat, M_icode, M_valA, M_valE, M_Cnd, M_dstE, M_dstM);

input clock, M_bubble, e_Cnd;
input [0:3] e_dstE, e_dstM, e_icode, e_stat;
input [0:63] e_valA, e_valE;

output reg M_Cnd;
output reg [0:3] M_dstE, M_dstM, M_icode, M_stat;
output reg [0:63] M_valA, M_valE;

// Updating the M registers according to bubble condition.
always @(posedge clock) begin
	if (~M_bubble) begin
		M_Cnd <= e_Cnd;
		M_dstE <= e_dstE;
		M_dstM <= e_dstM;
		M_icode <= e_icode;
		M_stat <= e_stat;
		M_valE <= e_valE;
		M_valA <= e_valA;
	end
	else begin
		M_Cnd <= 1;
		M_dstE <= 4'hF;
		M_dstM <= 4'hF;
		M_icode <= 4'h1;
		M_stat <= 4'b1000;
		M_valE <= 64'd0;
		M_valA <= 64'd0;
	end
end

endmodule