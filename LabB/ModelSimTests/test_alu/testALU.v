/*
R. Antonio Orozco
5/26/2014
Homework6-Part4
This module implements a test bench for the ALU
*/
`timescale 1ns/1ns
module testALU;
	reg [3:0] A, B; //inputs A and B
	reg [2:0] S; //The operation select line
	wire [15:0] Q; //The result
	localparam BIT_WIDTH = 4; //The bit width of A and B
	
	ALU #(.N(BIT_WIDTH)) DUT (A, B, S, Q);

	// This ALU has eight functions:
	// if s == 0 the output is 0
	// if s == 1 the output is A + B
	// if s == 2 the output is A ? B
	// if s == 3 the output is A (pass-through)
	// if s == 4 the output is A ^ B
	// if s == 5 the output is A | B
	// if s == 6 the output is A & B
	// if s == 7 the output is A + 1;
	
	integer I, J;
	initial begin
		A = 0;
		B = 0;
		S = 0; //S = 000, Should always have an output of 0
		
		for (I = 0; I < 8; I = I + 1) begin
			A = 0;
			B = 0;
			S = I;
			#40;
			 //I only went to 13 so that there be no overflow
			for (J = 0; J < 13; J = J + 1) begin
				A = J + 1;//let's make A 1 bigger
				B = J;
				#20;
			end
		end
		$stop;
	end
	
	initial
	   $monitor("Time%d:
                Input A = %d
                Input B = %d
                Select Line = %d
                Q = %d", $stime, A, B, S, Q);
endmodule 