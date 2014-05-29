/*
TCES 330 Spring 2014
05/27/2014
Brendan Crawford
Mohammad Juma
Antonio Orozco
Lab B
This module is the top level processor module that instantiates the control unit and datapath.
*/
module processor (
    clock, 
    reset, 

    alu_a, 
    alu_b, 
    alu_out, 
    ir_out, 
    mux_out,
    pc_out, 
    rq0,
    state_o
);

    //-----------------------
    // Input Ports
    //-----------------------
    input           clock;      // System Clock
    input           reset;      // System Reset
    
    //-----------------------
    // Output Ports
    //-----------------------
    output  [15:0]  ir_out;     // Instruction Register
    output  [4:0]   pc_out;     // Program Counter
    output  [3:0]   state_o;    // FSM Current State
    output  [15:0]  alu_a;      // ALU A-Side Input
    output  [15:0]  alu_b;      // ALU B-Side Input
    output  [15:0]  alu_out;    // ALU Current Output
    output  [15:0]  rq0;        // RF[0] Contents
    output  [15:0]  mux_out;    // Datapath Mux Output
    
    //-----------------------
    // Wires
    //-----------------------
    wire    [15:0]  ir_inst;    // Address of instruction in memory
    wire    [15:0]  ir_addr;    // Address of next instruction
    wire    [7:0]   d_addr;     // Data Memory address
    wire            d_wr;       // Data Memory write enable
    wire            rf_s;       // Register File select
    wire    [3:0]   rf_w_addr;  // Register File write address
    wire            rf_w_wr;    // Register File write enable
    wire    [3:0]   rf_ra_addr; // Register File channel A address
    wire            rf_ra_rd;   // Register File channel A read enable
    wire    [3:0]   rf_rb_addr; // Register File channel B address      
    wire            rf_rb_rd;   // Register File channel B read enable
    wire    [2:0]   alu_s0;     // ALU select
    
    assign pc_out = ir_inst;

    InstructionMemory inst_mem0 ( 
        .address ( ir_inst ),
        .clock ( clock ), 
        .q ( ir_addr )
    );
    
    control_unit con_unit0 (
        .clear ( reset ),
        .clock ( clock ),
        .ir_inst ( ir_inst ),
        .alu_s0 ( alu_s0 ),
        .d_addr ( d_addr ),
        .d_wr ( d_wr ),
        .ir_addr ( ir_addr ),
        .ir_out ( ir_out ),
        .rf_ra_addr ( rf_ra_addr ),
        .rf_ra_rd ( rf_ra_rd ),
        .rf_rb_addr ( rf_rb_addr ),
        .rf_rb_rd ( rf_rb_rd ),
        .rf_s ( rf_s ),
        .rf_w_addr ( rf_w_addr ),
        .rf_w_wr ( rf_w_wr ),
        .state_o ( state_o )
    );
    
    DataPath dp( clock, reset, d_addr, d_wr, rf_s, rf_w_addr,   rf_w_wr,    rf_ra_addr,
                            rf_ra_rd,   rf_rb_rd,   rf_rb_addr, alu_s0, alu_a, alu_b, alu_out, rq0, mux_out);
endmodule
    