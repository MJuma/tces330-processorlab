/*
TCES 330 Spring 2014
05/27/2014
Brendan Crawford
Mohammad Juma
Antonio Orozco
Lab B
This module is a program counter for the processor.
*/
module program_counter ( clock, clear, up, address );

    //-----------------------
    // Input Ports
    //-----------------------
    input   clock;                  // System clock
    input   clear;                  // System clear
    input   up;                     // Increment program counter input

    //-----------------------
    // Output Ports
    //-----------------------
    output [4:0]  address;    // Next instructions address
    reg [4:0] Q = 0;
    
    always @ ( posedge clock ) 
        begin
            if ( clear == 1 ) 
                begin
                    Q <= 0;
                end
            else if ( up == 1 ) 
                begin
                    Q <= Q + 1'b1;
                end
        end
        
    assign address = Q;
    
endmodule
