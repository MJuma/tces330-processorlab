module DataPath(Clock, Reset, D_addr, D_wr, RF_s, RF_W_addr, RF_W_wr, RF_Ra_addr, RF_Ra_rd,
 RF_Rb_addr, RF_Rb_rd, Alu_s0, alu_a, alu_b, alu_out, rq0, mux_out);
	input [7:0] D_addr;
	input D_wr, Clock, RF_s, RF_Ra_rd, RF_Rb_rd, RF_W_wr, Reset;
	input [3:0] RF_W_addr, RF_Ra_addr, RF_Rb_addr;
	input [2:0] Alu_s0;
	output	[15:0] alu_a, alu_b, alu_out, rq0, mux_out;
	
	assign alu_a = Ra_data;
	assign alu_b = Rb_data;
	assign alu_out = Alu_s0;
	assign rq0 = R_data;
	assign mux_out = MUX_Out;
	
	wire [15:0] R_data, Ra_data, Rb_data, ALU_Out, MUX_Out;
	
	//Refrence: module DataMemory (address,clock,data,wren,q);
	//module Mux2_1( X, Y, S, F );
	//module RegisterFile( W_data, W_addr, W_en, Ra_addr, Rb_addr, Ra_en, Rb_en, Clk, Rst, Ra_data, Rb_data);
	//module ALU (A, B, S, Q);
	
	DataMemory DATAMEM (D_addr, Clock, Ra_data, D_wr, R_data);
	Mux2_1 MUX (ALU_Out, R_data, RF_s, MUX_Out);
	RegisterFile REGFILE (MUX_Out, RF_W_addr, RF_W_wr, RF_Ra_addr, RF_Rb_addr, RF_Ra_rd, RF_Rb_rd, Clock, Reset, Ra_data, Rb_data);
	ALU OPERATION (Ra_data, Rb_data, Alu_s0, ALU_Out);
endmodule 