/*
TCES 330 Spring 2014
05/27/2014
Brendan Crawford
Mohammad Juma
Antonio Orozco
Lab B
This module a controller for the processor that contains the 
state machine of the processor.
*/

module controller (
    clock, 
    reset, 
    instruction,  

    alu_s0, 
    ld, 
    d_addr, 
    d_wr, 
    pc_clr, 
    pc_up, 
    rf_ra_addr, 
    rf_ra_rd, 
    rf_rb_addr,
    rf_rb_rd, 
    rf_s, 
    rf_w_addr, 
    rf_w_wr, 
    state_o);

    //-----------------------
    // Input Ports
    //-----------------------
    input clock;
    input reset;
    input [15:0] instruction;

    //-----------------------
    // Output Ports
    //-----------------------
    /* Instruction Register & Program Counter outputs */
    output reg          ld;         // Load next instruction from instruction register
    output reg          pc_clr;     // Program Counter Clear
    output reg          pc_up;      // Program Counter Incrememnt
    //--------------------------------
    //outputs going into the Datapath
    //--------------------------------
    /* Data RAM outputs */
    output reg  [7:0]   d_addr;     // Data Memory address
    output reg          d_wr;       // Data Memory write enable
    /* MUX output */
    output reg          rf_s;       // Register File select
    /* Register File outputs */
    output reg  [3:0]   rf_w_addr;  // Register File write address
    output reg          rf_w_wr;    // Register File write enable
    output reg  [3:0]   rf_ra_addr; // Register File channel A address  
    output reg          rf_ra_rd;   // Register File channel A read enable
    output reg  [3:0]   rf_rb_addr; // Register File channel B address
    output reg          rf_rb_rd;   // Register File channel B read enable
    /* ALU output */
    output reg  [2:0]   alu_s0;     // ALU select
    /* State output */
    output [3:0] state_o;           // STATE: FSM state

    //-----------------------
    // Registers
    //-----------------------
    reg [3:0] state;
    reg [1:0] count = 0;    
    
    //-----------------------
    // state Machine States
    //-----------------------
    localparam  [3:0]   INIT_STATE = 4'b0000;       // Initialization state
    localparam  [3:0]   FETCH_STATE = 4'b0001;      // Fetch next instruction state
    localparam  [3:0]   DECODE_STATE = 4'b0010;     // Decode instruction state
    localparam  [3:0]   NOOP_STATE = 4'b0011;       // NoOp state
    localparam  [3:0]   LOAD_A_STATE = 4'b0100;     // Load A state
    localparam  [3:0]   LOAD_B_STATE = 4'b0101;     // Load B state
    localparam  [3:0]   STORE_STATE = 4'b0110;      // Store instruction state
    localparam  [3:0]   ADD_STATE = 4'b0111;        // Add instruction state
    localparam  [3:0]   SUBTRACT_STATE = 4'b1000;   // Subtract instruction state
    localparam  [3:0]   HALT_STATE = 4'b1001;       // Halt instruction state
    localparam  [3:0]   JUMP_STATE = 4'b1010;
    localparam  [3:0]   COPY_STATE = 4'b1011;
    localparam  [3:0]   JNZ_A_STATE = 4'b1100;
    localparam  [3:0]   JNZ_B_STATE = 4'b1101;
    //localparam  [3:0]   JLT_A_STATE = ;
    //localparam  [3:0]   JLT_B_STATE = ;

    //-----------------------
    // Instruction Set
    //-----------------------
    localparam  [3:0]   NOOP = 4'b0000;             // NOOP Instruction 0000
    localparam  [3:0]   STORE = 4'b0001;            // STORE Instruction 0001
    localparam  [3:0]   LOAD = 4'b0010;             // LOAD Instruction 0010
    localparam  [3:0]   ADD = 4'b0011;              // ADD Instruction 0011
    localparam  [3:0]   SUBTRACT = 4'b0100;         // SUBTRACT Instruction 0100
    localparam  [3:0]   HALT = 4'b0101;             // HALT Instruction 0101
    localparam  [3:0]   JUMP = 4'b0110;             // JUMP Instruction 0110
    localparam  [3:0]   COPY = 4'b0111;             // Copy Instruction 0111
    localparam  [3:0]   JNZ = 4'b1000;              // Jump if True (Jump Not Zero) Instruction 1000
    //localparam  [3:0]   

    assign state_o = state;
    
    always @ ( posedge clock ) begin
        if ( reset ) begin
                state <= INIT_STATE;
        end 
        else begin
            case( state ) 
                INIT_STATE: begin
                    if (count == 2'b10) begin //It wasn't clearing the PC, on the first clock cycle, so it clears it
                                              // at the preceding clock cycle
                        count <= 1'b0;
                        ld <= 1'b1;
                        state <= FETCH_STATE;
                    end 
                    else begin
                        pc_up <= 1'b0;
                        ld <= 1'b0;
                        pc_clr <= 1'b1;
                        rf_s <= 1'b0;
                        rf_w_wr <= 1'b0;
                        d_wr <= 1'b0;
                        rf_ra_rd <= 1'b0;
                        rf_rb_rd <= 1'b0;
                        alu_s0 <= 1'b0;
                        count <= count + 1'b1;
                    end
                end
                FETCH_STATE: begin
                    pc_up <= 1'b1;
                    ld <= 1'b1;
                    pc_clr <= 1'b0;
                    state <= DECODE_STATE;
                end 
                DECODE_STATE: begin   
                    case ( instruction[15:12] )
                        NOOP: begin
                            pc_up <= 1'b0;
                            ld <= 1'b0;
                           // pc_clr <= 1'b0;
                            state <= NOOP_STATE;
                        end 
                        LOAD: begin
                            pc_up <= 1'b0;
                            ld <= 1'b0;
                            //pc_clr <= 1'b0;
                            state <= LOAD_A_STATE;
                        end
                        STORE: begin
                            pc_up <= 1'b0;
                            ld <= 1'b0;
                            //pc_clr <= 1'b0;
                            state <= STORE_STATE;
                        end
                        ADD: begin
                            pc_up <= 1'b0;
                            ld <= 1'b0;
                            //pc_clr <= 1'b0;
                            state <= ADD_STATE;
                        end
                        SUBTRACT: begin
                            pc_up <= 1'b0;
                            ld <= 1'b0;
                           // pc_clr <= 1'b0;
                            state <= SUBTRACT_STATE;
                        end
                        JUMP: begin
                            
                        end
                        COPY: begin
                            pc_up <= 1'b0;
                            ld <= 1'b0;
                            //pc_clr <= 1'b0;
                            state <= COPY_STATE;
                        end
                        HALT: begin
                            pc_up <= 1'b0;
                            ld <= 1'b0;
                            //pc_clr <= 1'b0;
                            rf_s <= 1'b0;
                            rf_w_wr <= 1'b0;
                            d_wr <= 1'b0;
                            rf_ra_rd <= 1'b0;
                            rf_rb_rd <= 1'b0;
                            alu_s0 <= 1'b0;
                            state <= HALT_STATE;
                        end
                        default: begin
                            state <= 4'bxxxx;
                        end
                    endcase
                end
                NOOP_STATE: begin
                    state <= FETCH_STATE;
                end
                LOAD_A_STATE: begin
                    d_addr <= instruction[11:4];
                    rf_w_addr <= instruction[3:0];
                    pc_up <= 0;
                    ld <= 0;
                    //pc_clr <= 0;
					rf_s <= 1'b1;
					rf_w_wr <= 0;
					d_wr <= 0;
					rf_ra_rd <= 0;
					rf_rb_rd <= 0;
                    alu_s0 <= 0;                    
                    state <= LOAD_B_STATE;
                end 
                LOAD_B_STATE: begin
                    d_addr <=  instruction[11:4];
                    rf_w_addr <= instruction[3:0];
                    pc_up <= 0;
                    ld <= 1;
                    //pc_clr <= 0;
					rf_s <= 1'b1;
					rf_w_wr <= 1'b1;
					d_wr <= 0;
					rf_ra_rd <= 0;
					rf_rb_rd <= 0;
                    alu_s0 <= 0; 
                    state <= FETCH_STATE;
                end
                STORE_STATE: begin
                    d_addr <= instruction[7:0];
                    rf_ra_addr <= instruction[11:8];
                    pc_up <= 0;
                    ld <= 1;
                    //pc_clr <= 0;
					rf_s <= 0;
					rf_w_wr <= 0;
					d_wr <= 1'b1;
					rf_ra_rd <= 1'b1;
					rf_rb_rd <= 0;
                    alu_s0 <= 0; 
                    state <= FETCH_STATE;   
                end
                ADD_STATE: begin
                    rf_w_addr <= instruction[3:0];
                    rf_ra_addr <= instruction[11:8];
                    rf_rb_addr <= instruction[7:4];                        
                    pc_up <= 0;
                    ld <= 1;
                    //pc_clr <= 0;
					rf_s <= 0;
					rf_w_wr <= 1'b1;
					d_wr <= 0;
					rf_ra_rd <= 1'b1;
					rf_rb_rd <= 1'b1;
                    alu_s0 <= 2'b01; 
                    state <= FETCH_STATE;
                end
                SUBTRACT_STATE: begin
                    rf_w_addr <= instruction[3:0];
                    rf_ra_addr <= instruction[11:8];
                    rf_rb_addr <= instruction[7:4];
                    pc_up <= 0;
                    ld <= 1;
                    //pc_clr <= 0;
					rf_s <= 0;
					rf_w_wr <= 1'b1;
					d_wr <= 0;
					rf_ra_rd <= 1'b1;
					rf_rb_rd <= 1'b1;
                    alu_s0 <= 2'b10; 
                    state <= FETCH_STATE;
                end
                HALT_STATE: begin 
                    state <= state;
                end
                JUMP_STATE: begin
                
                end
                COPY_STATE: begin
                    rf_w_addr <= instruction[3:0];
                    rf_ra_addr <= instruction[11:8];
                    pc_up <= 0;
                    ld <= 1;
                    //pc_clr <= 0;
					rf_s <= 0;
					rf_w_wr <= 1'b1;
					d_wr <= 0;
					rf_ra_rd <= 1'b1;
					rf_rb_rd <= 0;
                    alu_s0 <= 3; 
                    state <= FETCH_STATE;
                end
                default: begin
                    state <= 4'bxxxx;
                end
            endcase
        end //end else
    end //end always
endmodule