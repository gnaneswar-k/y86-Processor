module MUX_2_tb;

parameter WIDTH = 64; //-9223372036854775808 to +9223372036854775807

reg [1:0] S;
reg signed [WIDTH - 1:0] A, B, C;
wire signed [WIDTH - 1:0] Y;

MUX_2 #(.WIDTH(WIDTH)) comp(.out(Y),.X1(A),.X2(B),.X3(C),.S(S));

initial begin
	$dumpfile("MUX_2_tb.vcd");
	$dumpvars(0,MUX_2_tb);
	S = 2'd0;
	A = 64'sd0;
	B = 64'sd0;
	C = 64'sd0;
end

initial begin
	$monitor("time =%0t \t S =%b, A =%0d, B =%0d, C =%0d, Y =%0d",$time,S,A,B,C,Y);
	#10;
	A = 64'sd1;//1
	B = -64'sd2;//-2
	C = 64'sd3;//3
	S = 2'd3;//11
	
	#10;
	S = 2'd2;//10
	
	#10;
	S = 2'd1;//01
	
	#10;
	S = 2'd0;//00
	
	#10
	A = 64'sd0;
	B = 64'sd0;
	C = 64'sd0;
end

endmodule