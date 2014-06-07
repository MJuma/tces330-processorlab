/*
TCES 330 Spring 2014
05/27/2014
Brendan Crawford
Mohammad Juma
Antonio Orozco
Lab B
This module is the control unity of the processor 
that handles the controllerand the instruction register
in conjunctions with the program counter.
*/

module control_unit (
    clock,
    reset,

    alu_s0,
    d_addr,
    d_wr,
    ir_instruction,
    pc_address,
    rf_ra_addr,
    rf_ra_rd,
    rf_rb_addr,
    rf_rb_rd,
    rf_s,
    rf_w_addr,
    rf_w_wr,
    state_o
);

    //-----------------------
    // Input Ports
    //-----------------------
    input           clock;          // System clock
    input           reset;          // System reset
    
    //-----------------------
    // Output Ports
    //-----------------------
    /* Outputs to Data RAM */
    output  [7:0]   d_addr;         // Data Memory address
    output          d_wr;           // Data Memory write enable
    /* Output to MUX */
    output          rf_s;           // Register File select
    /* Outputs to register file */
    output  [3:0]   rf_w_addr;      // Register File write address
    output          rf_w_wr;        // Register File write enable
    output  [3:0]   rf_ra_addr;     // Register File channel A address
    output          rf_ra_rd;       // Register File channel A read enable
    output  [3:0]   rf_rb_addr;     // Register File channel B address      
    output          rf_rb_rd;       // Register File channel B read enable
    /* Output to ALU */
    output  [2:0]   alu_s0;         // ALU select
    output  [4:0]   pc_address;     // Address of next instuction
    output  [15:0]  ir_instruction;    // STATE: instruction register
    output  [3:0]   state_o;        // STATE: FSM State
    
    //-----------------------
    // Wires
    //-----------------------
    wire    [15:0]  instruction;    // The current instruction from the instruction register
    wire    [15:0]  data;           //
    wire    [4:0]   address;
    wire            ld;             // Load instruction from register enable bit
    wire            pc_clear;       // Clear the program counter
    wire            pc_up;          // Increment the program counter

    assign pc_address = address;
    assign ir_instruction = instruction;
    
    InstructionMemory i_mem0 (
        .address ( address ),
        .clock ( clock ),
        .q ( data )
    );
    
    program_counter prog_count0 (
        .clear ( pc_clear ), 
        .clock ( clock ), 
        .up ( pc_up ), 
        .address ( address ) 
    );
    
    instruction_register inst_reg0 (
        .clear ( reset ),
        .clock ( clock ), 
        .data ( data ), 
        .ld ( ld ),  
        .instruction ( instruction )
    );
    
    controller control0 (
        .clock ( clock ), 
        .reset ( reset ), 
        .instruction ( instruction ), 
        .alu_s0 ( alu_s0 ), 
        .ld ( ld ), 
        .d_addr ( d_addr ), 
        .d_wr ( d_wr ),
        .pc_clr ( pc_clear ),
        .pc_up ( pc_up ), 
        .rf_ra_addr ( rf_ra_addr ),
        .rf_ra_rd ( rf_ra_rd ),
        .rf_rb_addr ( rf_rb_addr ),
        .rf_rb_rd ( rf_rb_rd ),
        .rf_s ( rf_s ),
        .rf_w_addr ( rf_w_addr ),
        .rf_w_wr ( rf_w_wr ),
        .state_o ( state_o )
    );
endmodule
