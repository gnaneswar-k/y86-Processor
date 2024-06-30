module and_64 #(parameter WIDTH = 1)(Y,A,B,OF,ZF,SF);

input [0:WIDTH - 1] A, B;
output [0:WIDTH - 1] Y;
wire [0:WIDTH] zf_calc_w;
output OF, ZF, SF;
assign OF = 0;

genvar i;

generate
	for (i = WIDTH - 1; i >= 0; i = i - 1) begin
		and and_i(Y[i],A[i],B[i]);
	end
endgenerate

generate
	for (i = WIDTH - 1; i >= 0; i = i - 1) begin
		or zf_i(zf_calc_w[i],Y[i],zf_calc_w[i + 1]);
	end
endgenerate

not sf_calc(SF,Y[0]); //Sign Flag
not zf_calc(ZF,zf_calc_w[0]); //Zero Flag

endmodule