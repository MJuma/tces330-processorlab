/*
TCES 330 Spring 2014
05/27/2014
Brendan Crawford
Mohammad Juma
Antonio Orozco
Lab B
This module implements a 7-segment decoder (0 through 9)
*/

module hex7seg( 
    c, 
    
    display
);

    //-----------------------
    // Input Ports
    //-----------------------
    input      [3:0] c;        // Input
    
    //-----------------------
    // Output Ports
    //-----------------------
    output reg [0:6] display;  // Seven-segment display output
    
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
  // Note: Segment 6 is the left most bit
    always @ ( c )
        begin
            case ( c )		                    
                0: display = 7'b100_0000;       // 0
                1: display = 7'b111_1001;       // 1
                2: display = 7'b010_0100;       // 2
                3: display = 7'b011_0000;       // 3
                4: display = 7'b001_1001;       // 4
                5: display = 7'b001_0010;       // 5
                6: display = 7'b000_0010;       // 6
                7: display = 7'b111_1000;       // 7
                8: display = 7'b000_0000;       // 8
                9: display = 7'b001_0000;       // 9
                10: display = 7'b000_1000;      // A
                11: display = 7'b000_0011;      // b
                12: display = 7'b100_0110;      // C
                13: display = 7'b010_0001;      // d
                14: display = 7'b000_0110;      // E
                15: display = 7'b000_1110;      // F
                default: display = 7'b100_0000; // 0
            endcase
        end
endmodule