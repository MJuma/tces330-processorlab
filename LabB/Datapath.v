/*
TCES 330 Spring 2014
05/27/2014
Brendan Crawford
Mohammad Juma
Antonio Orozco
Lab B
This module implements a datapath for the processor 
that handles the ALU and register file.
*/

module datapath (
    clock,
    d_addr,
    d_wr,
    reset,
    rf_ra_addr,
    rf_ra_rd,
    rf_rb_addr,
    rf_rb_rd,
    rf_s,
    rf_w_addr,
    rf_w_wr,
    alu_s0,
    
    alu_a,
    alu_b,
    alu_out,
    mux_out,
    rq0
);

    //-----------------------
    // Input Ports
    //-----------------------
    input           clock;
    input           reset;
    input   [7:0]   d_addr;     // Address going into the Data RAM
    input           d_wr;
    input           rf_s;
    input   [3:0]   rf_ra_addr;
    input           rf_ra_rd;
    input   [3:0]   rf_rb_addr;
    input           rf_rb_rd;
    input   [3:0]   rf_w_addr;
    input           rf_w_wr;
    input   [2:0]   alu_s0;    
    
    
    //-----------------------
    // Output Ports
    //-----------------------
    output  [15:0]  alu_a;
    output  [15:0]  alu_b;
    output  [15:0]  alu_out;
    output  [15:0]  mux_out;
    output  [15:0]  rq0;
    
    //-----------------------
    // Wires
    //-----------------------
    wire    [15:0]  r_data;
    wire    [15:0]  ra_data;
    wire    [15:0]  rb_data;
    //wire    [15:0]  alu_out;
    //wire    [15:0]  mux_out;
    
    //To display in the HEX's displays
	assign alu_a = ra_data; 
	assign alu_b = rb_data;
	//assign alu_out = ALU_Out;
	assign rq0 = r_data;
	//assign mux_out = MUX_Out;
    
    DataMemory d_mem0 (
        .address ( d_addr ),
        .clock ( clock ),
        .data ( ra_data ),
        .wren ( d_wr ),
        .q ( r_data )
    );
    
    mux2_1 #(.N(16)) mux0 (
        .x ( alu_out ),
        .y ( r_data ),
        .s ( rf_s ),
        .f( mux_out )
    ); 
    
    register_file reg_file0 (
        .clock ( clock ),
        .ra_addr ( rf_ra_addr ),
        .ra_en ( rf_ra_rd ),
        .rb_addr ( rf_rb_addr ),
        .rb_en ( rf_rb_rd ),
        .reset ( reset ),
        .w_addr ( rf_w_addr ),
        .w_data ( mux_out ),
        .w_en ( rf_w_wr ),
        .ra_data ( ra_data ),
        .rb_data ( rb_data )
    );

    alu operation0 (
        .a ( ra_data ),
        .b ( rb_data ),
        .select ( alu_s0 ),
        .q ( alu_out )
    );
endmodule

    
    
    
    
    
    
    
    