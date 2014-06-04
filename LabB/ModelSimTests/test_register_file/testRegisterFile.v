/*
R. Antonio Orozco
5/26/2014
Homework6-Part5
Refrence: R. Gutmann, TCES 330, Spring 2011
This module is the testbench for RegisterFile
Used in our processor, tested with ModelSim
*/
`timescale 1 ns/1 ns
module testRegisterFile(); 

  // DUT inputs:
  reg Clk;   // system clock;
  reg Rst = 0;   // register file reset (everything to zero)
  reg Wen = 0;   // write enable (enables write side decoder)
  reg [3:0] WAddr = 0;   // write address (which register to write to)
  reg [15:0] WData = 0;  // data to write to a register
  reg [3:0] RAAddr = 0, RBAddr = 0; // which registers to read from
  reg RAen = 0, RBen = 0;           // A and B-side read enables
  
  // DUT outputs
  wire [15:0] RAData, RBData;  // A- and B-side read data
  localparam M = 16;
  	//module RegisterFile( W_data, W_addr, W_en, Ra_addr, Rb_addr, Ra_en, Rb_en, Clk, Rst, Ra_data, Rb_data);
	//N determines the bith width of the data going into the Register File (16 bit output though)
	RegisterFile #(.N(M)) REG (WData, WAddr, Wen, RAAddr, RBAddr, RAen, RBen, Clk, Rst, RAData, RBData);
  // generate clock
  always begin
    Clk = 0;
    #10;
    Clk = 1'b1;
    #10;
  end
  
  integer I;

  initial begin
    // load up the registers  	
  	Rst = 1;
  	#20 Rst = 0;
  	#20 for ( I=0; I<16; I=I+1 ) begin
  		#20 WData = I + 16'h10;
  		WAddr = I;
  		Wen = 1;
  		#20 Wen = 0;
  	end
  	
  	// read the registers
  	#20 for ( I=0; I<16; I=I+1 ) begin
  		#20 RAAddr = I;
  		    RBAddr = (I + 4'h8) % 16;
  		    RAen = 1;
  		    RBen = 1;
  	  #20 RAen = 0;
  	      RBen = 0;	    
  	end
  	#20 $stop;
  end
  
  
  initial
      $monitor("Time%d
                Reset = %d
                Write Enable = %d
                Write Address = %d
                Write Data = %h
                RA_Address = %d
                RB_Address = %d
                Ra_En = %d
                Rb_En = %d
                RA_Data = %h
                RB_Data = %h", $stime,
                Rst,
                Wen,
                WAddr,
                WData,
                RAAddr, RBAddr,
                RAen, RBen, RAData, RBData);
  
endmodule