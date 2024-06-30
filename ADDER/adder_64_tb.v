module adder_64_tb;

parameter WIDTH = 64; //-9223372036854775808 to +9223372036854775807

reg M;
reg signed [WIDTH - 1:0] A, B;
wire signed [WIDTH - 1:0] Y;
wire OF;

adder_64 #(.WIDTH(WIDTH)) comp(.S(Y),.A(A),.B(B),.OP(M),.OF(OF));

initial begin
	$dumpfile("adder_64_tb.vcd");
	$dumpvars(0,adder_64_tb);
	$display("M = 0 --> ADD\nM = 1 --> SUB");
	M = 0;
	A = 64'sd0;
	B = 64'sd0;
end

initial begin
	$monitor("time =%0t \t M =%b, A =%0d, B =%0d, Y =%0d, OF =%b",$time,M,A,B,Y,OF);
	M = 0;
	A = 64'sd0;//0
	B = 64'sd0;//0
	
	#10;
	M = 1;
	
	#10;
	M = 0;
	A = 64'sd1;//1
	B = -64'sd1;//-1
	
	#10;
	M = 1;
	
	#10;
	M = 0;
	A = 64'sd9223372036854775807;//9223372036854775807
	B = 64'sd9223372036854775807;//9223372036854775807
	
	#10;
	M = 1;
	
	#10;
	M = 0;
	A = 64'sd9223372036854775807;//9223372036854775807
	B = -64'sd9223372036854775808;//-9223372036854775808
	
	#10;
	M = 1;
	
	#10;
	M = 0;
	A = 64'sd0;//0;
	B = -64'sd9223372036854775808;//-9223372036854775808
	
	#10;
	M = 1;
	
	#10;
	M = 0;
	A = -64'sd9223372036854775808;//-9223372036854775808
	B = 64'sd0;//0
	
	#10;
	M = 1;
	
	#10;
	M = 0;
	A = -64'sd9223372036854775808;//-9223372036854775808
	B = -64'sd9223372036854775808;//-9223372036854775808
	
	#10;
	M = 1;
	
	#10;
	M = 0;
	A = 64'sd0;//0
	B = 64'sd0;//0
end

//always @(Y)
//	$display("time =%0t \t S =%b, A =%0d, B =%0d, Y =%0d, OF =%b",$time,S,$signed(A),$signed(B),$signed(Y),OF);

endmodule