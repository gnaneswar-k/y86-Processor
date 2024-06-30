`include "../ADDER/adder_64.v"
`include "../AND/and_64.v"
`include "../XOR/xor_64.v"
`include "../MUX/MUX_2.v"
module ALU_64_2(Y,A,B,S,OF,ZF,SF);

parameter INPUT_WIDTH = 64;

input [0:1] S;
input [0:INPUT_WIDTH - 1] A, B;
wire [0:INPUT_WIDTH - 1] Y1, Y2, Y3;
wire OF1, OF2, OF3, SF1, SF2, SF3, ZF1, ZF2, ZF3;
output [0:INPUT_WIDTH - 1] Y;
output OF,SF,ZF;

// Calculating 3 modules since in actual hardware all operations are actually carried through along with an AND of the select lines.
// ADD and SUB work by taking Mode input so only one module is required.
adder_64 #(.WIDTH(INPUT_WIDTH)) add_alu(.S(Y1),.A(A),.B(B),.OP(S[1]),.OF(OF1),.SF(SF1),.ZF(ZF1));
and_64 #(.WIDTH(INPUT_WIDTH)) and_alu(.Y(Y2),.A(A),.B(B),.OF(OF2),.SF(SF2),.ZF(ZF2));
xor_64 #(.WIDTH(INPUT_WIDTH)) xor_alu(.Y(Y3),.A(A),.B(B),.OF(OF3),.SF(SF3),.ZF(ZF3));

// MUX selection of output.
MUX_2 #(.WIDTH(INPUT_WIDTH)) mux_Y(.out(Y),.X1(Y1),.X2(Y2),.X3(Y3),.S(S));
// MUX selection of OF.
MUX_2 #(.WIDTH(1)) mux_OF(.out(OF),.X1(OF1),.X2(OF2),.X3(OF3),.S(S));
// MUX selection of ZF.
MUX_2 #(.WIDTH(1)) mux_ZF(.out(ZF),.X1(ZF1),.X2(ZF2),.X3(ZF3),.S(S));
// MUX selection of SF.
MUX_2 #(.WIDTH(1)) mux_SF(.out(SF),.X1(SF1),.X2(SF2),.X3(SF3),.S(S));

endmodule