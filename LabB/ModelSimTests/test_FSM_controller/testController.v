`timescale 1ns/1ns
module testConroller;
    reg clock, reset;
    reg [15:0] instruction;
    wire  [7:0]   d_addr;     // Data Memory address
    wire           d_wr;       // Data Memory write enable
    //output to MUX
    wire           rf_s;       // Register File select
    //output to Register File
    wire   [3:0]   rf_w_addr;  // Register File write address
    wire           rf_w_wr;    // Register File write enable
    wire   [3:0]   rf_ra_addr; // Register File channel A address  
    wire           rf_ra_rd;   // Register File channel A read enable
    wire   [3:0]   rf_rb_addr; // Register File channel B address
    wire           rf_rb_rd;   // Register File channel B read enable
    //output to ALU
    wire  [2:0]   alu_s0;     // ALU select
    wire [3:0]    state_o;    // STATE: FSM State
    
    wire pc_up, pc_clr, ld;
    
    
    always begin
        clock = 0;
        #10;
        clock = 1;
        #10;
    end
    
    Controller FSM (clock, reset, instruction,  alu_s0, ld, d_addr, d_wr, pc_clr, pc_up, rf_ra_addr, rf_ra_rd, rf_rb_addr,
    rf_rb_rd, rf_s, rf_w_addr, rf_w_wr, state_o);
    
    
    initial begin
        reset = 0;
        instruction = 16'h20A1;
        #140;
        instruction = 16'h21A2;
        #80;
        instruction = 16'h2033;
        #80;
        instruction = 16'h28A4;
        #80;
        instruction = 16'h4125;
        #60;
        instruction = 16'h3536;
        #60;
        instruction = 16'h4640;
        #60;
        instruction = 16'h10BB;
        #60;
        instruction = 16'h5000;
        #100;
        reset = 1;
        instruction = 16'h0000;
        #80;
	$stop;
    end
    
    
    initial
    $monitor("Time%d
                Instruction = %h
                D_addr = %d
                D_wr = %d
                Rf_s = %d
                Rf_w_addr = %d
                Rf_w_wr = %d
                Rf_ra_addr = %d
                Rf_ra_rd = %d
                Rf_rb_addr = %d
                Rf_rb_rd = %d
                Alu_s0 = %d
                State_o = %d
                Pc_up = %d
                Pc_clr = %d
                Ld = %d", $stime, instruction, d_addr, d_wr, rf_s, rf_w_addr,
                rf_w_wr, rf_ra_addr, rf_ra_rd, rf_rb_addr, rf_rb_rd,
                alu_s0, state_o, pc_up, pc_clr, ld);  
    
 endmodule 