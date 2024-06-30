module reg_file (clock, srcA, srcB, valA, valB, dstE, dstM, valE, valM);

reg [0:63]reg_file_module[0:14];

// Setting all register values initially to 0.
initial begin	
	reg_file_module[0] = 64'h00; // %rax
	reg_file_module[1] = 64'h00; // %rcx
	reg_file_module[2] = 64'h00; // %rdx
	reg_file_module[3] = 64'h00; // %rbx
	reg_file_module[4] = 64'h00; // %rsp
	reg_file_module[5] = 64'h00; // %rbp
	reg_file_module[6] = 64'h00; // %rsi
	reg_file_module[7] = 64'h00; // %rdi
	reg_file_module[8] = 64'h00; // %r8
	reg_file_module[9] = 64'h00; // %r9
	reg_file_module[10] = 64'h00; // %r10
	reg_file_module[11] = 64'h00; // %r11
	reg_file_module[12] = 64'h00; // %r12
	reg_file_module[13] = 64'h00; // %r13
	reg_file_module[14] = 64'h00; // %r14
end

input clock;
input [0:3] srcA, srcB, dstE, dstM;
input [0:63] valE, valM;
output reg [0:63] valA, valB;

initial begin
	valA = 0;
	valB = 0;
end

// Display for checking register updates during testing.
always @(posedge clock, negedge clock)
	$display("time = %0t\n[0]=%h [1]=%h [2]=%h [3]=%h [4]=%h\n[5]=%h [6]=%h [7]=%h [8]=%h [9]=%h\n[10]=%h [11]=%h [12]=%h [13]=%h [14]=%h",$time,reg_file_module[0],reg_file_module[1],reg_file_module[2],reg_file_module[3],reg_file_module[4],reg_file_module[5],reg_file_module[6],reg_file_module[7],reg_file_module[8],reg_file_module[9],reg_file_module[10],reg_file_module[11],reg_file_module[12],reg_file_module[13],reg_file_module[14],);

// Reading data in the positive clock edge.
always @(srcA, srcB, posedge clock) begin
	if (srcA != 4'hF)
		valA = reg_file_module[srcA];
	if (srcB != 4'hF)
		valB = reg_file_module[srcB];
end

// Writing data in the negative clock edge.
always @(dstM, dstE, negedge clock)  begin
	if (dstM != 4'hF)
		reg_file_module[dstM] = valM;
	if (dstE != 4'hF)
		reg_file_module[dstE] = valE;
end			

endmodule