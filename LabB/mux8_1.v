/*
TCES 330 Spring 2014
05/27/2014
Brendan Crawford
Mohammad Juma
Antonio Orozco
Lab B
This module is an 8 to 1 mux.
*/
module mux8_1 (
    input0, 
    input1,
    input2,
    input3,
    input4,
    input5,
    input6,
    input7,
    select,
    
    q
);

    //-----------------------
    // Parameters
    //-----------------------
    parameter N = 4;
   
    //-----------------------
    // Input Ports
    //-----------------------
    input [N-1:0]   input0;    // Input 0 
    input [N-1:0]   input1;    // Input 1
    input [N-1:0]   input2;    // Input 2
    input [N-1:0]   input3;    // Input 3
    input [N-1:0]   input4;    // Input 4
    input [N-1:0]   input5;    // Input 5
    input [N-1:0]   input6;    // Input 6
    input [N-1:0]   input7;    // Input 7
    input [2:0]     select;    // Select line
    
    //-----------------------
    // Output Ports
    //-----------------------
    output reg [N-1:0] q;   // Mux output
 
    always @ ( input0, input1, input2, input3,
               input4, input5, input6, input7, select ) 
        begin
            case ( select )
                3'b001: q = input1;
                3'b010: q = input2;
                3'b011: q = input3;
                3'b100: q = input4;
                3'b101: q = input5;
                3'b110: q = input6;
                3'b111: q = input7;
                default: q = input0;
            endcase
        end
endmodule 