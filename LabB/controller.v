/*
TCES 330 Spring 2014
05/27/2014
Brendan Crawford
Mohammad Juma
Antonio Orozco
Lab B
This module is a controller that manager the state machine logic behind 
the processors control unit.
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
    state_o
);

    //-----------------------
    // Input Ports
    //-----------------------
    input           clock;          // System clock
    input           reset;          // System reset
    input   [15:0]  instruction;    // Current instruction

    //-----------------------
    // Output Ports
    //-----------------------
    output reg  [7:0]   d_addr;     // Data Memory address
    output reg          d_wr;       // Data Memory write enable
    output reg          rf_s;       // Register File select
    output reg  [3:0]   rf_w_addr;  // Register File write address
    output reg          rf_w_wr;    // Register File write enable
    output reg  [3:0]   rf_ra_addr; // Register File channel A address  
    output reg          rf_ra_rd;   // Register File channel A read enable
    output reg  [3:0]   rf_rb_addr; // Register File channel B address
    output reg          rf_rb_rd;   // Register File channel B read enable
    output reg  [2:0]   alu_s0;     // ALU select
    output reg          ld;         // Load next instruction from instruction register
    output reg          pc_clr;     // Program Counter Clear
    output reg          pc_up;      // Program Counter Incrememnt
    output              state_o;    // STATE: FSM State

    //-----------------------
    // Registers
    //-----------------------
    reg  [3:0]  current_state = 0;  // State machines current state
    reg  [3:0]  next_state = 0;     // State machines next state
    
    //-----------------------
    // State Machine States
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

    //-----------------------
    // Instruction Set
    //-----------------------
    localparam  [3:0]   NOOP = 4'b0000;             // NOOP Instruction 0000
    localparam  [3:0]   STORE = 4'b0001;            // STORE Instruction 0001
    localparam  [3:0]   LOAD = 4'b0010;             // LOAD Instruction 0010
    localparam  [3:0]   ADD = 4'b0011;              // ADD Instruction 0011
    localparam  [3:0]   SUBTRACT = 4'b0100;         // SUBTRACT Instruction 0100
    localparam  [3:0]   HALT = 4'b0101;             // HALT Instruction 0101

    assign state_o = current_state;
                    
    always @ ( current_state ) 
        begin
            case ( current_state )
                INIT_STATE: 
                    begin
                        pc_up = 0;
                        alu_s0 = 0;
                        ld = 0;
                        pc_clr = 1;
                        next_state = FETCH_STATE;
                    end
                FETCH_STATE: 
                    begin
                        pc_clr = 0;
                        pc_up = 1;
                        ld = 1;
                        next_state = DECODE_STATE;
                    end 
                DECODE_STATE:
                    begin   
                        case ( instruction[15:12] )
                            NOOP: 
                                begin
                                    next_state = NOOP_STATE;
                                end 
                            LOAD: 
                                begin
                                    next_state = LOAD_A_STATE;
                                end
                            STORE: 
                                begin
                                    next_state = STORE_STATE;
                                end
                            ADD: 
                                begin
                                    next_state = ADD_STATE;
                                end
                            SUBTRACT: 
                                begin
                                    next_state = SUBTRACT_STATE;
                                end
                            HALT: 
                                begin
                                    next_state = HALT_STATE;
                                end
                        endcase
                    end
                NOOP_STATE: 
                    begin
                        next_state = FETCH_STATE;
                    end
                LOAD_A_STATE:   
                    begin
                        d_addr = instruction[11:4];
                        rf_s = 1;
                        rf_w_addr = instruction[3:0];
                        next_state = LOAD_B_STATE;
                    end 
                LOAD_B_STATE:   
                    begin
                        d_addr =  instruction[11:4];
                        rf_s = 1;
                        rf_w_addr = instruction[3:0];
                        rf_w_wr = 1;
                        next_state = FETCH_STATE;
                    end
                STORE_STATE:    
                    begin
                        d_addr = instruction[7:0];
                        d_wr = 1;
                        rf_ra_addr = instruction[11:8];
                        rf_ra_rd = 1;
                        next_state = FETCH_STATE;   
                    end
                ADD_STATE:  
                    begin
                        rf_w_addr = instruction[3:0];
                        rf_w_wr = 1;
                        rf_ra_addr = instruction[11:8];
                        rf_ra_rd = 1;
                        rf_rb_addr = instruction[7:4];
                        rf_rb_rd = 1;
                        alu_s0 = 1;
                        next_state = FETCH_STATE;
                    end
                SUBTRACT_STATE: 
                    begin
                        rf_w_addr = instruction[3:0];
                        rf_w_wr = 1;
                        rf_ra_addr = instruction[11:8];
                        rf_ra_rd = 1;
                        rf_rb_addr = instruction[7:4];
                        rf_rb_rd = 1;
                        alu_s0 = 2;
                        next_state = FETCH_STATE;
                    end
                HALT_STATE: 
                    begin 
                        next_state = HALT_STATE;
                    end
                default: 
                    begin
                        next_state = 4'bxxxx;
                    end
            endcase
        end //end always
    
    always @ ( posedge clock ) 
        begin
            if ( reset ) 
                begin
                    current_state <= INIT_STATE;
                end
            else 
                begin
                    current_state <= next_state;
                end
        end
endmodule