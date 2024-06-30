module half_adder(S,C,A,B);

input A,B;
output S,C;

xor comp1(S,A,B);
and comp2(C,A,B);

endmodule