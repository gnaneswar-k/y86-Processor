`include "../ADDER/full_adder.v"
module adder_64 #(parameter WIDTH = 1)(S,A,B,OP,OF,ZF,SF);

input [0:WIDTH - 1] A;
input [0:WIDTH - 1] B;
output [0:WIDTH - 1] S; //Output Sum.
wire [0:WIDTH] C, zf_calc_w; //Carry and ZF for calculation.
input OP; //OP is 1 for subtraction, 0 for addition.
wire [0:WIDTH - 1] oper; // Output for determining operation.
output OF, ZF, SF; //Flags

assign C[WIDTH] = OP;
// In addition no complement is taken, so initial input carry is 0.
// In subtraction 2s complement is taken, so initial input carry is 1.

assign zf_calc_w[WIDTH] = 0;

genvar i;

generate
	for (i = WIDTH - 1; i >= 0; i = i - 1) begin
		xor det_i(oper[i],B[i],OP);
		full_adder fa_i(.S(S[i]),.C(C[i]),.A(A[i]),.B(oper[i]),.Cin(C[i + 1]));
	end
endgenerate

generate
	for (i = WIDTH - 1; i >= 0; i = i - 1) begin
		or zf_i(zf_calc_w[i],S[i],zf_calc_w[i + 1]);
	end
endgenerate

xor of_calc(OF,C[1],C[0]); //Overflow Flag.
not sf_calc(SF,S[0]); //Sign Flag
not zf_calc(ZF,zf_calc_w[0]); //Zero Flag

endmodule