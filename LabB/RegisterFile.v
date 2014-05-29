/*
R. Antonio Orozco
5/26/2014
Homework6-Part5
This module implements a dual output register file.
It contains 16 16-bit registers
*/
module RegisterFile( W_data, W_addr, W_en, Ra_addr, Rb_addr,
 Ra_en, Rb_en, Clk, Rst, Ra_data, Rb_data);
	parameter N = 16;
	input [3:0] Ra_addr, Rb_addr, W_addr; // 4-bit write address for A, B, and Write address
	input [N-1:0] W_data; //N-bits of data to write
	input Ra_en, Rb_en, W_en; // The enable for read address A and B. Enable for for write address
	input Clk, Rst; //Clock and Reset
	output [15:0] Ra_data, Rb_data; //The output from the specified register
	wire [15:0] W_d, Oea, Oeb; //The switch line for the controlled buffer
	// write decoder N determines the bit width of the address going into the decoder
	DecoderN #(.N(4)) WriteDecoder(W_addr, W_en, W_d);
	// read decoder N determines the bit width of the address going into the decoder
	ReadDecoder #(.N(4)) ReadDecoder(Ra_addr, Rb_addr, Ra_en, Rb_en, Oea, Oeb);
  /*
	INPUTS	| DESCRIPTION					DISPLAY					| DESCRIPTION
	-------------------------				-------------------------------------
	SW[5:0]	| INPUT DATA					HEX0,HEX1,HEX2,HEX3	| A-DATA(OUTPUT) 
	-------------------------				-------------------------------------						
	SW[9:6]	| WRITE ADDRESS				HEX4,HEX5,HEX6,HEX7	| B-DATA(OUTPUT) 
	-------------------------				-------------------------------------
	SW[13:10]| A READ ADDRESS
	-------------------------									 -----------------
	SW[17:14]| B READ ADDRESS		INPUT_DATA-----\16--->|						|---\16---->A_DATA
	-------------------------									|						|----\16--->B_DATA
	KEY[0]	| CLOCK					WRITE_ADDRESS--\4--->|						|
	-------------------------									|	REGISTER FILE	|<----\4--A_READ_ADDRESS		
	KEY[1]	| RESET												|						|<----\4--B_READ_ADDRESS
																		|						|																		
											WRITE_ENABLE-------->|						|<-------A_READ_ENABLE
																		|						|<-------B_READ_ENABLE
																		 -^---------------
																		  | ^		
											CLOCK__________________| |
											RESET____________________|
	*/
	// registers with output enable
	// M determines the bit width of data going into registers
	genvar I; //Let's generate some registers
	generate
		for(I = 0; I < 16; I = I + 1) begin: registerGen //Creates 16 16-bit Registers
			RegisterOEN #(.M(N)) R (W_data, W_d[I], Oea[I], Oeb[I], Clk, Rst, Ra_data, Rb_data);
		end
	endgenerate
endmodule
