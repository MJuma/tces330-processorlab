/*
R. Antonio Orozco
5/26/2014
Homework6-Part5
This module implements a dual address read decoder for the register file
*/
module read_decoder( Ra_adr, Rb_adr, Ra_ena, Rb_ena, Oea, Oeb );
  parameter N = 2;
  localparam M = 2**N; //N^2
  input [N-1:0] Ra_adr, Rb_adr; //The input address to read from
  input Ra_ena, Rb_ena; //Read addres A or B enable
  output reg [M-1:0] Oea = 0, Oeb = 0; //Determines which swtich to close from the controlled buffer
  
  always @(Ra_adr, Rb_adr, Ra_ena, Rb_ena) begin
		if (Ra_ena) 
			Oea = 1'b1 << Ra_adr; //shift 1-bit into position
		else
			Oea = 0;
			
		if (Rb_ena)
			Oeb = 1'b1 << Rb_adr;
		else 
			//Oea = 0;
			Oeb = 0;
    
  end  // always
endmodule