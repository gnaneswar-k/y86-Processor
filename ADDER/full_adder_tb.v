module full_adder_tb;

reg A,B,Cin;
wire Sum,Carry;
integer i,k;

full_adder full_add(.A(A),.B(B),.Cin(Cin),.S(Sum),.C(Carry));

initial
	begin
		$monitor("time =%0t \t A =%b, B =%b, Cin =%b and Sum =%b, Carry =%b",$time,A,B,Cin,Sum,Carry);
        $dumpfile("full_adder_tb.vcd");
        $dumpvars(0,full_adder_tb);
		
		A = 0;
		B = 0;
		Cin = 0;
	end

initial begin
	for (i = 1; i <= 8; i = i + 1)
		begin
			#10
			k = i;
			
			A = k % 2;
			k = k / 2;
			
			B = k % 2;
			k = k / 2;
			
			Cin = k % 2;
		end
end
//always @(Sum,Carry)
//	$display("time =%0t \t A =%b, B =%b, Cin =%b and Sum =%b, Carry =%b",$time,A,B,Cin,Sum,Carry);

endmodule