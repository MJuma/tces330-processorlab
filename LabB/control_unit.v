/*
TCES 330 Spring 2014
05/27/2014
Brendan Crawford
Mohammad Juma
Antonio Orozco
Lab B
This module is the control unit of the processor that handles the controller 
and the instruction register in conjunction with the program counter.
*/
module control_unit (
	clear, 
	clock,
	ir_inst,

	alu_s0,
	d_addr,
	d_wr,
	ir_addr,
	ir_out,
	rf_ra_addr,
	rf_ra_rd,
	rf_rb_addr,
	rf_rb_rd,
	rf_s,
	rf_w_addr,
	rf_w_wr,
	state_o
);

	//-----------------------
	// Input Ports
	//-----------------------
	input 			clock;			// System clock
	input			clear;			// System clear
	input 	[15:0]	ir_inst;		// Instruction from Instruction Memory

	//-----------------------
	// Output Ports
	//-----------------------
	output	[15:0]	ir_addr;		// Address of next instuction
	output	[7:0]	d_addr;			// Data Memory address
	output			d_wr;			// Data Memory write enable
	output			rf_s;			// Register File select
	output	[3:0]	rf_w_addr;		// Register File write address
	output			rf_w_wr;		// Register File write enable
	output	[3:0]	rf_ra_addr;		// Register File channel A address
	output			rf_ra_rd;		// Register File channel A read enable
	output	[3:0]	rf_rb_addr;		// Register File channel B address		
	output			rf_rb_rd;		// Register File channel B read enable
	output	[2:0]	alu_s0;			// ALU select
	output	[15:0]	ir_out;			// STATE: instruction register
	output	[3:0]	state_o;		// STATE: FSM State

	//-----------------------
	// Wires
	//-----------------------
	wire	[15:0] instruction;		// The current instruction from the instruction register
	wire 			ld;				// Load instruction from register enable bit
	wire 			pc_clear;		// Clear the program counter
	wire 			pc_up;			// Increment the program counter
	
	assign ir_out = instruction;

	controller control0 (
		.clock ( clock ), 
		.reset ( clear ), 
		.instruction ( instruction ), 
		.alu_s0 ( alu_s0 ), 
		.ld ( ld ), 
		.d_addr ( d_addr ), 
		.d_wr ( d_wr ),
		.pc_clear ( pc_clear ),
		.pc_up ( pc_up ), 
		.rf_ra_addr ( rf_ra_addr ),
		.rf_ra_rd ( rf_ra_rd ),
		.rf_rb_addr ( rf_rb_addr ),
		.rf_rb_rd ( rf_rb_rd ),
		.rf_s ( rf_s ),
		.rf_w_addr ( rf_w_addr ),
		.rf_w_wr ( rf_w_wr ),
		.state_o ( state_o )
	);

	program_counter prog_count0 (
		.clear ( pc_clear ), 
		.clock ( clock ), 
		.up ( pc_up ), 
		.address ( ir_addr ) 
	);

	instruction_register inst_reg0 (
		.clear ( clear ),
		.clock ( clock ), 
		.data ( ir_inst ), 
		.ld ( ld ),  
		.instruction ( instruction )
	);
endmodule
