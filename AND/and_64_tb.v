module and_64_tb;

parameter WIDTH = 64; //-9223372036854775808 to +9223372036854775807

reg signed [WIDTH - 1:0] A, B;
wire signed [WIDTH - 1:0] Y;
wire OF;

and_64 #(.WIDTH(WIDTH)) comp(.Y(Y),.A(A),.B(B),.OF(OF));

initial begin
	$dumpfile("and_64_tb.vcd");
	$dumpvars(0,and_64_tb);
	A = 64'sd0;
	B = 64'sd0;
end

initial begin
	$monitor("time =%0t \t A =%0d, B =%0d, Y =%0d, OF =%b",$time,A,B,Y,OF);
	A = 64'sd0;//0
	B = 64'sd0;//0
	
	#10;
	A = 64'sd1;//1
	B = -64'sd1;//-1
	
	#10;
	A = 64'sd9223372036854775807;//9223372036854775807
	B = 64'sd9223372036854775807;//9223372036854775807
	
	#10;
	A = 64'sd9223372036854775807;//9223372036854775807
	B = -64'sd9223372036854775808;//-9223372036854775808
	
	#10;
	A = 64'sd0;//0;
	B = -64'sd9223372036854775808;//-9223372036854775808
	
	#10;
	A = -64'sd9223372036854775808;//-9223372036854775808
	B = 64'sd0;//0
	
	#10;
	A = -64'sd9223372036854775808;//-9223372036854775808
	B = -64'sd9223372036854775808;//-9223372036854775808
	
	#10;
	A = 64'sd0;//0
	B = 64'sd0;//0
end

endmodule