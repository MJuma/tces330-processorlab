module controller(Clock, reset, Instruction,
	D_addr, D_wr, RF_s, RF_W_addr, RF_W_wr, RF_Ra_addr, RF_Ra_rd, RF_Rb_addr, RF_Rb_rd, Alu_s0, Id, PC_clr, PC_up, state_o);
	input Clock;
	input reset;
	input [15:0] Instruction;
	output reg [7:0] D_addr;
	output reg D_wr, RF_s, RF_Ra_rd, RF_Rb_rd, RF_W_wr, Id, PC_clr, PC_up;
	output reg [3:0] RF_W_addr, RF_Ra_addr, RF_Rb_addr;
	output reg [2:0] Alu_s0;
	output state_o;
	
	assign state_o = Current_State;
	reg [3:0] Current_State = 0, Next_State = 0;
	
	//------------------------------------------------------------------
	// Instruction Set
	//------------------------------------------------------------------
	localparam	[3:0]	noop = 4'b0000;		// NOOP Instruction 0000
	localparam	[3:0]	store = 4'b0001;		// STORE Instruction 0001
	localparam	[3:0]	load = 4'b0010;		// LOAD Instruction 0010
	localparam	[3:0]	add = 4'b0011;			// ADD Instruction 0011
	localparam	[3:0]	subtract = 4'b0100;	// SUBTRACT Instruction 0100
	localparam	[3:0]	halt = 4'b0101;		// HALT Instruction 0101
	
	
	
	//Initialize states
	localparam Init = 4'b0000, Fetch = 4'b0001, Decode = 4'b0010,
					NOOP = 4'b0011, LOAD_A = 4'b0100, LOAD_B = 4'b0101,
					STORE = 4'b0110, ADD = 4'b0111, SUB = 4'b1000, HALT = 4'b1001;
					
	always @ (Current_State) begin
		case (Current_State)
			Init: begin
					PC_clr = 1;
					Next_State = Fetch;
					end
					
			Fetch: begin 
					PC_up = 1;
					Id = 1;
					end 
					
			Decode: 	case (Instruction[15:12])
						noop : Next_State = NOOP;	
						load : Next_State = LOAD_A;
						store : Next_State = STORE;
						add : Next_State = ADD;
						subtract : Next_State = SUB;
						halt : Next_State = HALT;
						endcase
			NOOP: Next_State = Fetch;
			
			LOAD_A: 	begin
						D_addr = Instruction[11:4];
						RF_s = 1;
						RF_W_addr = Instruction[3:0];
						Next_State = LOAD_B;
						end 
						
			LOAD_B: 	begin
						D_addr = D_addr = Instruction[11:4];
						RF_s = 1;
						RF_W_addr = Instruction[3:0];
						RF_W_wr = 1;
						Next_State = Fetch;
						end
						
			STORE: 	begin
						D_addr = Instruction[7:0];
						D_wr = 1;
						RF_Ra_addr = Instruction[11:8];
						RF_Ra_rd = 1;
						Next_State = Fetch;
						end
						
			ADD: 	begin
					RF_W_addr = Instruction[3:0];
					RF_W_wr = 1;
					RF_Ra_addr = Instruction[11:8];
					RF_Ra_rd = 1;
					RF_Rb_addr = Instruction[7:4];
					RF_Rb_rd = 1;
					ALU_s0 = 1;
					Next_State = Fetch;
					end
					
			SUB:	begin
					RF_W_addr = Instruction[3:0];
					RF_W_wr = 1;
					RF_Ra_addr = Instruction[11:8];
					RF_Ra_rd = 1;
					RF_Rb_addr = Instruction[7:4];
					RF_Rb_rd = 1;
					ALU_s0 = 2;
					Next_State = Fetch;
					end
			
			HALT: Next_State = HALT;
		default: Next_State = 4'bxxxx;
		endcase
	end //end always
	
	always @(posedge Clock) begin
		if ( reset ) begin
			Next_State <= Init;
			PC_clr <= 0;
			PC_up <= 0;
			ALU_s0 <= 0;
		end
		else begin
			Current_State <= Next_State;
		end
	end
endmodule