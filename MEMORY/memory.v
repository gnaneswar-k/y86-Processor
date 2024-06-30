module memory (clock, M_bubble, M_stat, M_icode, M_valA, M_valE, M_Cnd, M_dstE, M_dstM, m_valE, m_valM, m_stat, m_icode, m_dstE, m_dstM);

input clock, M_bubble;
input [0:63] M_valE, M_valA;
input M_Cnd;
input [0:3] M_stat, M_icode, M_dstE, M_dstM;

output reg [0:63] m_valE, m_valM;
output reg [0:3] m_stat, m_icode, m_dstE, m_dstM;

parameter mem_ind = 64'd2048; // Using memory length as a parameter to adjust easily for testing.
reg dmem_error;
reg [0:63] data_mem[0:mem_ind - 1];

initial begin
	dmem_error = 0;
end

// Writing to memory in the positive edge.
always @(posedge clock) begin
	if (M_icode == 4'h4) begin //rmovq
		if(mem_ind >= M_valE) begin
			dmem_error = 0;
			data_mem[M_valE] <= M_valA;
		end
		else
			dmem_error = 1;
	end
	if (M_icode == 4'hA) begin //pushq
		if(mem_ind >= M_valE) begin
			dmem_error = 0;
			data_mem[M_valE] <= M_valA;
		end
		else
			dmem_error = 1;
	end
	if (M_icode == 4'h8) begin //call
		if(mem_ind >= M_valE) begin
			dmem_error = 0;
			data_mem[M_valE] <= M_valA;
		end
		else
			dmem_error = 1;
	end
	else
		dmem_error = 0;
end

// Reading from memory any time since reading does not alter data.
always @* begin
	if(M_icode == 4'h5) begin //mrmovq
		if(mem_ind >= M_valE) begin
			dmem_error = 0;
			m_valM = data_mem[M_valE];
		end
		else
			dmem_error = 1;
	end
	else if(M_icode == 4'h9) begin //ret
		if(mem_ind >= M_valA) begin
			dmem_error = 0;
			m_valM = data_mem[M_valA];
		end
		else
			dmem_error = 1;
	end
	else if(M_icode == 4'hB) begin //popq
		if(mem_ind >= M_valE) begin
			dmem_error = 0;
			m_valM = data_mem[M_valE];
		end
		else
			dmem_error = 1;
	end
	else
		dmem_error = 0;
	
	// Updating the remaining output values.
	if (dmem_error == 1)
		m_stat = 4'b0010;
	else
		m_stat = M_stat;
	
	m_icode = M_icode;
	m_valE = M_valE;
	m_dstE = M_dstE;
	m_dstM = M_dstM;
end

endmodule