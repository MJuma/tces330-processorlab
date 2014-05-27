module controller();
	
	//------------------------------------------------------------------
	// Instruction Set
	//------------------------------------------------------------------
	localparam	[3:0]	NOOP = 4'b0000;		// NOOP Instruction 0000
	localparam	[3:0]	STORE = 4'b0001;		// STORE Instruction 0001
	localparam	[3:0]	LOAD = 4'b0010;		// LOAD Instruction 0010
	localparam	[3:0]	ADD = 4'b0011;			// ADD Instruction 0011
	localparam	[3:0]	SUBTRACT = 4'b0100;	// SUBTRACT Instruction 0100
	localparam	[3:0]	HALT = 4'b0101;		// HALT Instruction 0101
	
	
	always @( current ) begin: state_table
		case( current )
			Init: begin
						program_counter = 0;
					end
			Fetch: begin
						instruction_register = instruction;
						program_counter = program_counter + 1;
					end
			Decode: begin
						case ( instruction )
							NOOP: begin
								operation = NOOP;
							end
							STORE: begin
							
							end
							LOAD: begin
							
							end
							ADD: begin
							
							end
							SUBTRACT: begin
							
							end
							HALT: begin
							
							end
						endcase
					end
			Execute: begin
			
					end
		endcase

endmodule
