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
    input   clock;                  // System clock
    input   clear;                  // System clear
    input   up;                     // Increment program counter input

    //-----------------------
    // Output Ports
    //-----------------------
    output  reg [4:0]  address;    // Next instructions address
    
    always @ ( posedge clock ) 
        begin
            if ( clear ) 
                begin
                    address <= 0;
                end
            else if ( up ) 
                begin
                    address <= address + 1'b1;
                end
            else 
                begin
                    address <= address;
                end
        end
endmodule
