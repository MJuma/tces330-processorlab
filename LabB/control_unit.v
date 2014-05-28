module control_unit( 
	clock,
	clear,
	ir_addr,
	ir_inst,
	d_addr,
	d_wr,
	rf_s,
	rf_w_addr,
	rf_w_wr,
	rf_ra_addr,
	rf_ra_rd,
	rf_rb_rd,
	rf_rb_addr,
	alu_s0,
	ir_out,
	state_o
);

	//-----------------------
	// Input Ports
	//-----------------------
	input 				clock;			// System clock
	input					clear;			// System clear
	input 	[15:0]	ir_inst;			// Instruction from Instruction Memory

	//-----------------------
	// Output Ports
	//-----------------------
	output	[15:0]	ir_addr;			// Address of next instuction
	output	[7:0]		d_addr;			// Data Memory address
	output				d_wr;				// Data Memory write enable
	output				rf_s;				// Register File select
	output	[3:0]		rf_w_addr;		// Register File write address
	output				rf_w_wr;			// Register File write enable
	output	[3:0]		rf_ra_addr;		// Register File channel A address
	output				rf_ra_rd;		// Register File channel A read enable
	output	[3:0]		rf_rb_addr;		// Register File channel B address		
	output				rf_rb_rd;		// Register File channel B read enable
	output	[2:0]		alu_s0;			// ALU select
	output	[15:0]	ir_out;			// STATE: instruction register
	output	[3:0]		state_o;			// STATE: FSM State

	//-----------------------
	// wire
	//-----------------------
	wire [15:0] instruction;
	wire ld;
	wire pc_clear;
	wire pc_up;
	
	assign ir_out = instruction;
	
	controller control( clock, clear, instruction, d_addr, d_wr, rf_s, rf_w_addr, rf_w_wr, rf_ra_addr, rf_ra_rd, rf_rb_addr
	, rf_rb_rd, alu_s0, ld, pc_clear);
	program_counter pc( clock, pc_clear, pc_up, ir_addr );
	instruction_register ir( clock, ir_inst, ld, clear, instruction );

endmodule
