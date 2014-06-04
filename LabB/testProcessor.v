// TCES 330, Spring 2014
// Testbench  for the programmable processor
// Robert Gutmann

//`timescale 1ns/1ns
module testProcessor;
 
  reg  Clk;    // system clock
  reg  Reset;  // system reset
  wire [15:0] ir_instruction;   // instruction register
  wire [4:0] pc_address;    // program counter
  wire [3:0] state_o;    // state machine state
  wire [15:0] alu_a, alu_b, alu_out;  // ALU output 
  wire [15:0] mux_out;
  wire [15:0] rq0;      // register 0 value (you might want to change this)
  wire [3:0] rf_w_addr_out, rf_ra_addr_out, rf_rb_addr_out; //address going into register file
 


  processor P2014 (
    Clk,
    Reset, 
    alu_a, 
    alu_b, 
    alu_out, 
    ir_instruction, 
    mux_out,
    pc_address, 
    rf_ra_addr_out, 
    rf_rb_addr_out,
    rf_w_addr_out,
    rq0,
    state_o);

initial // Clock generator
  begin
    Clk = 0;
    forever #10 Clk = !Clk;
  end
  
initial	// Test stimulus
  begin
    Reset = 1;        // reset for one clock
    @ ( posedge Clk ) 
    Reset = 0;
    #1000 $stop;      // then run for a while
  end
  
initial 
      $monitor("Time%d: Reset = %d State = %d Reg0 = %h MuxOut = %h IR Instruction = %h PC = %d Alu_A = %h Alu_B = %h Alu_Out = %h RF_W_Addr = %d RF_Ra_Addr = %d RF_Rb_Addr = %d", $stime, Reset, state_o, rq0, mux_out, ir_instruction, pc_address, alu_a, alu_b, alu_out, rf_w_addr_out, rf_ra_addr_out, rf_rb_addr_out);
        
endmodule                