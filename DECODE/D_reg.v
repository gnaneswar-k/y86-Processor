module D_reg (clock, D_stall, D_bubble, f_stat, f_icode, f_ifun, f_rA, f_rB, f_valC, f_valP, D_stat, D_icode, D_ifun, D_rA, D_rB, D_valC, D_valP);

input clock, D_bubble, D_stall;
input [0:3] f_icode, f_ifun, f_rA, f_rB, f_stat;
input [0:63] f_valC, f_valP;

output reg [0:3] D_icode, D_ifun, D_rA, D_rB, D_stat;
output reg [0:63] D_valC, D_valP;

// Updating the D registers according to stall and bubble conditions.
always @(posedge clock) begin
	if (D_bubble) begin
		D_icode <= 4'h1;
		D_ifun <= 4'h0;
		D_rA <= 4'hF;
		D_rB <= 4'hF;
		D_stat <= 4'b1000;
		D_valC <= 64'h0;
		D_valP <= 64'h0;
	end
	else if (~D_stall) begin
		D_icode <= f_icode;
		D_ifun <= f_ifun;
		D_rA <= f_rA;
		D_rB <= f_rB;
		D_stat <= f_stat;
		D_valC <= f_valC;
		D_valP <= f_valP;
	end
end

endmodule