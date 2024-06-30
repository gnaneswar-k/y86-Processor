`include "../ADDER/half_adder.v"
module full_adder (S,C,A,B,Cin);

input A,B,Cin;
output S,C;
wire S1,C1,X;

half_adder comp1(.A(A),.B(B),.S(S1),.C(C1));
half_adder comp2(.A(Cin),.B(S1),.S(S),.C(X));
or comp3(C,X,C1);

endmodule