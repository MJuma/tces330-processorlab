/*
TCES 330 Spring 2014
05/27/2014
Brendan Crawford
Mohammad Juma
Antonio Orozco
Lab B
This module is the instruction register that hold the next instruction of
the processor.
*/

module instruction_register ( 
    clear,
    clock, 
    data, 
    ld,  

    instruction 
);

    //-----------------------
    // Input Ports
    //-----------------------
    input           clock;          // Clock
    input   [15:0]  data;           // Data from the ROM
    input           ld;             // Load next instruction
    input           clear;          // Clear input of the register
    
    //-----------------------
    // Output Ports
    //-----------------------
    output  [15:0]  instruction;    // Current instruction
    
    //-----------------------
    // Registers
    //-----------------------
    reg     [15:0]  q;
   
    always @ ( posedge clock ) begin
        if ( clear ) begin
            q <= 0;
        end
        else if ( ld ) begin
            q <= data;
        end
    end
        
    assign instruction = q;
endmodule