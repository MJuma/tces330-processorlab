/*
TCES 330 Spring 2014
05/27/2014
Brendan Crawford
Mohammad Juma
Antonio Orozco
Lab B
This module is a top level module that instantiates the processor.
*/
module LabB ( 
	SW, 
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
	input	[17:0]		SW;		// 
	input	[1:0]		KEY;	// System clock and reset

	//-----------------------
	// Output Ports
	//-----------------------
	output 	[0:6] 		HEX0, 	// HEX0 through HEX3 display
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

	assign clock = KEY[0:0];
	assign reset = KEY[1:1];
	
	
	
endmodule