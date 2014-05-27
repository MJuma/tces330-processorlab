/*
R. Antonio Orozco
5/26/2014
Homework6-Part4
This module implements a 7-segment decoder (0 through 9)
*/
module Hex7seg( C, Display );
  input      [3:0] C;        // Input
  output reg [0:6] Display;  // seven-segment display output
  /*
  *   0
  *  ---
  * |   |
  *5|   |1
  * | 6 |
  *  ---
  * |   |
  *4|   |2
  * |   |
  *  ---
  *   3
  */
  
  // Note: a '0' turns the segment ON
  // Note: Segment 6 is the left most bit, below
  always @ ( C )
    case ( C )		  //6......0 <----
      //0: Display = 7'b100_0000; //0
      1: Display = 7'b111_1001; //1
      2: Display = 7'b010_0100; //2
      3: Display = 7'b011_0000; //3
      4: Display = 7'b001_1001; //4
      5: Display = 7'b001_0010; //5
      6: Display = 7'b000_0010; //6
      7: Display = 7'b111_1000; //7
      8: Display = 7'b000_0000; //8
      9: Display = 7'b001_0000; //9
		10: Display = 7'b000_1000; //A
		11: Display = 7'b000_0011; //b
		12: Display = 7'b100_0110; //C
		13: Display = 7'b010_0001; //d
		14: Display = 7'b000_0110; //E
		15: Display = 7'b000_1110; //F
      default: Display = 7'b100_0000; //0
  endcase

endmodule