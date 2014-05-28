module InstructionRegister(Clk, MemOut, InstRegOut, Ld, Clear);

	//IR input from memory
	input [15:0] MemOut;	
	
	//Load
	input Ld;
	
	//Clock
	input Clk;
	
	//Clear
	input Clear;
	
	//Instruction Register output
	output [15:0] InstRegOut;
	
	always @ (Clk) begin
		if(Clear == 1)
			InstRegOut <= 0;
		else if(Ld == 1)
			InstRegOut <= MemOut;
	end
	
endmodule