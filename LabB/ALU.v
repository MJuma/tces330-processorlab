/*
R. Antonio Orozco
5/26/2014
Homework6-Part4
This module implements an ALU
*/
module ALU (A, B, S, Q);
	parameter N = 16;
	input [N-1:0] A, B; //inputs A and B
	input [2:0] S; //Select line
	output reg [15:0] Q = 0; //The result of the selected operation
	/*
	ALU OPERATIONS (S = SELECT LINE):
	S | Q(OUTPUT)  	INPUT 	| DESCRIPTION			DISPLAY 	| DESCRIPTION
	----------- 		-------------------------		----------------------------
	0 | 0					SW[2:0]	| SELECT LINE(S)		HEX[7:4]	| DISPLAY Q(OUTPUT)
	-----------			-------------------------		----------------------------
	1 | A + B			SW[6:3]	| INPUT A				HEX0		| DISPLAY A							
	-----------			-------------------------		----------------------------
	2 | A – B			SW[10:7]	| INPUT B				HEX1		| DISPLAY B
	-----------			
	3 | A					
	-----------								 --------
	4 | A ^ B			INPUT A---\16-->|			|
	-----------								|	ALU	|---\16--->Q(RESULT)
	5 | A | B			INPUT B---\16-->|			|
	-----------								|			|
	6 | A & B								 --------
	-----------									^
	7 | A + 1			OPERATION___\3____|
	*/
	always @ (A, B, S) begin
		case(S)
			3'b001: Q = A + B; //Add
			3'b010: Q = A - B; //Subtract
			3'b011: Q = A;     //output is A
			3'b100: Q = A ^ B; //XOR
			3'b101: Q = A | B; //OR
			3'b110: Q = A & B; //AND
			3'b111: Q = A + 1'b1; //Increment A by 1-bit
			default: Q = 0; //if S = 000, then Q = 0, this is the default case
		endcase
	end
endmodule 