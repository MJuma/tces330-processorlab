module instruction_register( clock, data, ld, clear, instruction );
	input 						clock;					// Clock
	input 			[15:0] 	data;						// Data from the ROM
	input 					 	ld;						// Load next instruction
	input							clear;					// Clear input of the register
	output	reg	[15:0]	instruction;			// Current instruction
	
	always @ ( posedge clock ) begin
		if ( clear ) begin
			instruction <= 0;
		end
		else if ( ld ) begin
			instruction <= data;
		end
	end
endmodule