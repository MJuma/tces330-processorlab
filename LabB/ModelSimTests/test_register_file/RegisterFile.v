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
	WriteDecoder #(.N(4)) Write_Decoder(W_addr, W_en, W_d);
	// read decoder N determines the bit width of the address going into the decoder
	ReadDecoder #(.N(4)) Read_Decoder(Ra_addr, Rb_addr, Ra_en, Rb_en, Oea, Oeb);
  /*
	INPUTS	| DESCRIPTION					DISPLAY					| DESCRIPTION
	-------------------------				-------------------------------------
	SW[5:0]	| INPUT DATA					HEX0,HEX1,HEX2,HEX3	| A-DATA(OUTPUT) 
	-------------------------				-------------------------------------						
	SW[9:6]	| WRITE ADDRESS				HEX4,HEX5,HEX6,HEX7	| B-DATA(OUTPUT) 
	-------------------------				-------------------------------------
	SW[13:10]| A READ ADDRESS
	-------------------------
	SW[17:14]| B READ ADDRESS	
	-------------------------	
	KEY[0]	| CLOCK	
	-------------------------		
	KEY[1]	| RESET								
																																						
	*/
    
    RegisterOEN #(.M(N)) R0 (W_data, W_d[0], Oea[0], Oeb[0], Clk, Rst, Ra_data, Rb_data);
    RegisterOEN #(.M(N)) R1 (W_data, W_d[1], Oea[1], Oeb[1], Clk, Rst, Ra_data, Rb_data);
    RegisterOEN #(.M(N)) R2 (W_data, W_d[2], Oea[2], Oeb[2], Clk, Rst, Ra_data, Rb_data);
    RegisterOEN #(.M(N)) R3 (W_data, W_d[3], Oea[3], Oeb[3], Clk, Rst, Ra_data, Rb_data);
    RegisterOEN #(.M(N)) R4 (W_data, W_d[4], Oea[4], Oeb[4], Clk, Rst, Ra_data, Rb_data);
    RegisterOEN #(.M(N)) R5 (W_data, W_d[5], Oea[5], Oeb[5], Clk, Rst, Ra_data, Rb_data);
    RegisterOEN #(.M(N)) R6 (W_data, W_d[6], Oea[6], Oeb[6], Clk, Rst, Ra_data, Rb_data);
    RegisterOEN #(.M(N)) R7 (W_data, W_d[7], Oea[7], Oeb[7], Clk, Rst, Ra_data, Rb_data);
    RegisterOEN #(.M(N)) R8 (W_data, W_d[8], Oea[8], Oeb[8], Clk, Rst, Ra_data, Rb_data);
    RegisterOEN #(.M(N)) R9 (W_data, W_d[9], Oea[9], Oeb[9], Clk, Rst, Ra_data, Rb_data);
    RegisterOEN #(.M(N)) R10 (W_data, W_d[10], Oea[10], Oeb[10], Clk, Rst, Ra_data, Rb_data);
    RegisterOEN #(.M(N)) R11 (W_data, W_d[11], Oea[11], Oeb[11], Clk, Rst, Ra_data, Rb_data);
    RegisterOEN #(.M(N)) R12 (W_data, W_d[12], Oea[12], Oeb[12], Clk, Rst, Ra_data, Rb_data);
    RegisterOEN #(.M(N)) R13 (W_data, W_d[13], Oea[13], Oeb[13], Clk, Rst, Ra_data, Rb_data);
    RegisterOEN #(.M(N)) R14 (W_data, W_d[14], Oea[14], Oeb[14], Clk, Rst, Ra_data, Rb_data);
    RegisterOEN #(.M(N)) R15 (W_data, W_d[15], Oea[15], Oeb[15], Clk, Rst, Ra_data, Rb_data);
    //------------------------------------------------------------------------------------------
	// registers with output enable
	// M determines the bit width of data going into registers
	//genvar I; //Let's generate some registers
	//generate
	//	for(I = 0; I < 16; I = I + 1) begin: registerGen //Creates 16 16-bit Registers
	//		RegisterOEN #(.M(N)) R (W_data, W_d[I], Oea[I], Oeb[I], Clk, Rst, Ra_data, Rb_data);
	//	end
	//endgenerate
    //------------------------------------------------------------------------------------------    
endmodule
