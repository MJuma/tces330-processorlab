module program_counter( clock, clear, up, address );
	input							clock;					// System clock
	input							clear;					// System clear
	input							up;						// Increment program counter input
	output	reg	[15:0]	address;					// Next instructions address
	
	always @ ( posedge clock ) begin
		if ( clear ) begin
			address <= 0;
		end
		else if ( up ) begin
			address <= address + 16'd4;
		end
	end
endmodule
