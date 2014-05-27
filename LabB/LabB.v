/*
This is just a test

*/
module LabB(SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
	input[17:0] SW;
	input[1:0] KEY;
	output[0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	
	// The system clock.
	wire clock;
	assign clock = KEY[0:0];
	// The synchronous system reset.
	wire reset;
	assign reset = KEY[1:1];
	
	
	
endmodule