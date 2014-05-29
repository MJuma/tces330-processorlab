/*
TCES 330 Spring 2014
05/27/2014
Brendan Crawford
Mohammad Juma
Antonio Orozco
Lab B
This module is a top level module that instantiates the processor
and assigns input/output switches.
*/
module LabB ( 
	SW,
	LEDR,
	KEY, 
	HEX0, 
	HEX1, 
	HEX2, 
	HEX3, 
	HEX4, 
	HEX5, 
	HEX6, 
	HEX7
);
	//-----------------------
	// Input Ports
	//-----------------------
	input	[17:15]	SW;	//Selecte line for the HEX[7:4] (determines what will be displayed)
	output [17:15]	LEDR; //red LED's
	assign LEDR = SW; //assigns the red LED's to the input switches
	input	[1:0]	KEY;	// System clock and reset

	//-----------------------
	// Output Ports
	//-----------------------
	output [6:0] 	HEX0, 	// HEX0 through HEX3 display
						HEX1, 	// the contents of the IR
						HEX2, 
						HEX3, 
						HEX4,	// Determined by the switches, 
						HEX5, 	// HEX4 through HEX7 display either
						HEX6, 	// the contetns of the ALU's, the 
						HEX7;	// register file or the datapath
	
	//-----------------------
	// Wires
	//-----------------------
	wire clock;		// The system clock
	wire reset;		// The synchronous system reset
	wire [2:0] S;
	wire [15:0] Q;
	wire [15:0]	ir_out;		// Instruction Register
	wire [4:0] pc_out;		// Program Counter
	wire [3:0] state_o;	// FSM Current State
	wire [15:0] alu_a;		// ALU A-Side Input
	wire [15:0] alu_b;		// ALU B-Side Input
	wire [15:0] alu_out;	// ALU Current Output
	wire [15:0] rq0;		// RF[0] Contents
	wire [15:0] mux_out;	// Datapath Mux Output

	assign S = SW[17:15]; //3-bit select line
	assign clock = KEY[0];
	assign reset = KEY[1];
	
	//The Processor
	processor PROCESSOR (clock, reset, alu_a, alu_b, alu_out, ir_out, mux_out, pc_out, rq0, state_o);
	//7 to 1 Multiplexer
	mux7_1 #(.N(16)) MUX ({7'b0000_000, pc_out, state_o}, // S = 0 => HEX7 = 0; HEX6, HEX5 = PC; HEX4 = Current State;
																  alu_a, // S = 1 => HEX7, 6, 5, 4 = ALU_A (A-side input to ALU)
																  alu_b, // S = 2 => HEX7, 6, 5, 4 = ALU_B (B-side input to ALU)
																alu_out, // S = 3 => HEX7, 6, 5, 4 = ALU_Out (ALU output)
																4'h0000, // S = 4 => Unused (use this for your own debug information)
																	 rq0, // S = 5 => HEX7, 6, 5, 4 = Register File 0 contents
																mux_out, // S = 6 => HEX7, 6, 5, 4 = Datapath Multiplexer output
																4'h0000, // S = 7 => Unused (use this for your own debug information) 
																		S, // The Select line
																		Q) // The output
	//Display the output to the 7 to 1 multiplexer
	Hex7seg H4 (Q[3:0], HEX4);
	Hex7seg H5 (Q[7:4], HEX5);
	Hex7seg H6 (Q[11:8], HEX6);
	Hex7seg H7 (Q[15:12], HEX7);
	
	//Display current contents of IR(Instruction Register)
	Hex7seg H0 (ir_out[3:0], HEX0);
	Hex7seg H1 (ir_out[7:4], HEX1);
	Hex7seg H2 (ir_out[11:8], HEX2);
	Hex7seg H3 (ir_out[15:12], HEX3);

	
endmodule