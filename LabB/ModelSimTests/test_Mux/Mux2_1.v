/*
R. Antonio Orozco
5/26/2014
Homework6-Part3
This module implements a 2 to 1 multiplexer
*/
module Mux2_1( X, Y, S, F );
	parameter N = 2;
	input [N-1:0] X, Y; // input lines
	input S; // select line
	output reg [N-1:0] F; // output
	
	always@(X,Y,S) //the statements it contains are evaluated in the order given
	if(S == 0) 
		F = X; // if the select line is 0, then output = X
	else 
		F = Y; // else the output = Y
endmodule 