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
	output reg [15:0] InstRegOut;
	
	always @ (posedge Clk) begin
		if (Clear)
			InstRegOut <= 0; //Clear instruction in register
		else if (Ld)
			InstRegOut <= MemOut;
		else
			InstRegOut <= InstRegOut;
	end
	
endmodule