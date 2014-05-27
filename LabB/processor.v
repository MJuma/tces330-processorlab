/*
TCES 330 Spring 2014
05/27/2014
Mohammad Juma
Antonio Orozco
Brendan Crawford
Lab B
This module ####.
*/
module processor(clock, reset, ir_out, pc_out, state_o, alu_a, alu_b, alu_out, rq0, mux_out);
	input 				clock;		// System Clock
	input 				reset;		// System Reset
	output	[15:0]	ir_out;		// Instruction Register
	output	[4:0] 	pc_out;		// Program Counter
	output	[3:0] 	state_o;		// FSM Current State
	output	[15:0] 	alu_a;		// ALU A-Side Input
	output	[15:0] 	alu_b;		// ALU B-Side Input
	output	[15:0] 	alu_out;		// ALU Current Output
	output	[15:0] 	rq0;			// RF[0] Contents
	output	[15:0] 	mux_out;		// Datapath Mux Output
	
	
endmodule
	