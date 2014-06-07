/*
TCES 330 Spring 2014
05/27/2014
Brendan Crawford
Mohammad Juma
Antonio Orozco
Lab B
This module implements an ALU
   This ALU has eight functions
    if select == 0 the output is 0
    if select == 1 the output is A + B
    if select == 2 the output is A - B
    if select == 3 the output is A (pass-through)
    if select == 4 the output is A ^ B
    if select == 5 the output is A | B
    if select == 6 the output is A & B
    if select == 7 the output is A + 1
   the additional functions are for future expansion
*/
module alu (
    a,
    b,
    select,
    
    q
);
    
    //-----------------------
    // Parameters
    //-----------------------
    parameter IN_BITS = 16;
    parameter OUT_BITS = 16;

    //-----------------------
    // Input Ports
    //-----------------------
    input   [2:0]   select;    // function select
    input   [IN_BITS-1:0]  a;        // first input data
    input   [IN_BITS-1:0]  b;        // second input data
    
    //-----------------------
    // Output Ports
    //-----------------------
    output  reg [OUT_BITS-1:0]  q;    // ALU output (result)
    
    always @ ( a, b, select ) begin
        case ( select )
            3'b000: q = 0;          // q = 0
            3'b001: q = a + b;      // Add
            3'b010: q = a - b;      // Subtract
            3'b011: q = a;          // A
            3'b100: q = a ^ b;      // XOR
            3'b101: q = a | b;      // OR
            3'b110: q = a & b;      // AND
            3'b111: q = a + 1'b1;   // Incr
            default: q = 0;         // default case q = 0
        endcase
    end
endmodule
