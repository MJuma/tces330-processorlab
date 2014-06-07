/*
TCES 330 Spring 2014
05/27/2014
Brendan Crawford
Mohammad Juma
Antonio Orozco
Lab B
This module is a program counter for the processor.
*/

module program_counter ( 
    clear, 
    clock, 
    up, 

    address 
);

    //-----------------------
    // Input Ports
    //-----------------------
    input   clock;              // System clock
    input   clear;              // System clear
    input   up;                 // Increment program counter input

    //-----------------------
    // Output Ports
    //-----------------------
    output  [4:0]  address;    // Next instructions address
    
    //-----------------------
    // Registers
    //-----------------------
    reg     [4:0]   q;
    
    always @ ( posedge clock ) begin
        if ( clear ) begin
            q <= 0;
        end
        else if ( up ) begin
            q <= q + 1'b1;
        end
    end
        
    assign address = q;
endmodule
