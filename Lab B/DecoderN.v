/*
R. Antonio Orozco
5/26/2014
Homework6-Part5
Refrence: R. Gutmann, TCES 330, Spring 2011
This module implements the write decoder for the register file
*/
module DecoderN( W, E, Y );
  parameter N = 2;
  localparam M = 2**N; //N^2
  input [N-1:0] W;      // the input address to write to
  input E;              // enable writable
  output reg [M-1:0] Y; //	The output register to write to
  
  always @(W, E) begin
    if ( E ) begin
      Y = 1'b1 << W;  // shift a '1' into position
    end
    else begin
      Y = 0;
    end
  end  // always
endmodule
