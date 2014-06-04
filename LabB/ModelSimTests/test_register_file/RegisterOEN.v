/*
R. Antonio Orozco
5/26/2014
Homework6-Part5
This module implements a dual output register with enable
*/
module RegisterOEN( I, Ld, Oea, Oeb, Clk, Rst, Qa, Qb);
	parameter M = 16;
	localparam N = 16;
	input [M-1:0] I; // input data
	input Oea; // channel a output enable
	input Oeb; // channel b output enable
	input Ld; // register load enable
	input Clk; // input clock
	input Rst; // synchronous reset signal
	output [N-1:0]Qa; // channel a output
	output [N-1:0]Qb; // channel b output
  
  reg [N-1:0] Q = 0;   // standard (unswitched) output

  // Register Procedure
  always @(posedge Clk) begin
    if (Rst == 1)
      Q <= 0;
    else if (Ld == 1)
      Q <= I;
  end

  // Output
  assign Qa = Oea ? Q : {N{1'bZ}};
  assign Qb = Oeb ? Q : {N{1'bZ}};
   
endmodule

