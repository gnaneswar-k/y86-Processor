module MUX_2 #(parameter WIDTH = 1)(out,X1,X2,X3,S);

input [0:1] S;
input [0:WIDTH - 1] X1, X2, X3;
wire [0:WIDTH - 1] Y1, Y2, Y3;
wire notS0, notS1;
wire [0:WIDTH - 1] Y;
output [0:WIDTH - 1] out;

not (notS0,S[0]), (notS1,S[1]);

genvar i;

generate
	for (i = WIDTH - 1; i >= 0; i = i - 1) begin
		and and_i0(Y1[i],notS0,X1[i]);
		and and_i2(Y2[i],notS1,S[0],X2[i]);
		and and_i3(Y3[i],S[1],S[0],X3[i]);
		or or_i(Y[i],Y1[i],Y2[i],Y3[i]);
	end
endgenerate

assign out = Y;

endmodule