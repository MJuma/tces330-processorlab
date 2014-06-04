/*
TCES 330 Spring 2014
05/27/2014
Brendan Crawford
Mohammad Juma
Antonio Orozco
Lab B
This module is a top level module that instantiates the processor
and assigns input/output switches.
*/
module LabB ( 
    SW,
    LEDR,
    KEY, 
    HEX0, 
    HEX1, 
    HEX2, 
    HEX3, 
    HEX4, 
    HEX5, 
    HEX6, 
    HEX7
);
    //-----------------------
    // Input Ports
    //-----------------------
    input   [17:15] SW;     // Selecte line for the HEX[7:4] (determines what will be displayed)
    output  [17:15] LEDR;   // Red LED's
    input   [1:0]   KEY;    // System clock and reset

    //-----------------------
    // Output Ports
    //-----------------------
    output [6:0]    HEX0,   // HEX0 through HEX3 display
                    HEX1,   // the contents of the IR
                    HEX2, 
                    HEX3, 
                    HEX4,   // Determined by the switches, 
                    HEX5,   // HEX4 through HEX7 display either
                    HEX6,   // the contents of the ALU's, the 
                    HEX7;   // register file or the datapath
    
    //-----------------------
    // Wires
    //-----------------------
    wire            clock;          // The system clock
    wire            reset;          // The synchronous system reset
    wire [2:0]      select;
    wire [15:0]     q;
    wire [15:0]     ir_instruction; // Instruction Register
    wire [4:0]      pc_address;     // Program Counter
    wire [3:0]      state_o;        // FSM Current State
    wire [15:0]     alu_a;          // ALU A-Side Input
    wire [15:0]     alu_b;          // ALU B-Side Input
    wire [15:0]     alu_out;        // ALU Current Output
    wire [15:0]     rq0;            // RF[0] Contents
    wire [15:0]     mux_out;        // Datapath Mux Output
    wire [3:0]      rf_w_addr_out;  // Write address for register file
    wire [3:0]      rf_ra_addr_out; // A address for register file
    wire [3:0]      rf_rb_addr_out; // B address for register file

    assign LEDR = SW;           //assigns the red LED's to the input switches
    assign select = SW[17:15];  //3-bit select line
    assign clock = KEY[0];
    assign reset = ~KEY[1];

    //---------------------------------------------------
    //                  INSTRUCTION:
    //---------------------------------------------------
    //RF[0] = D[A] - D[1A] + D[3] - D[8A];
    //D[BB] = RF[0];
    //HALT
    //---------------------------------------------------
    //LD    A    1        0010 00001010 0001    0x20A1
    //LD   1A    2        0010 00011010 0010    0x21A2
    //LD    3    3        0010 00000011 0011    0x2033
    //LD   8A    4        0010 10001010 0100    0x28A4
    //SUB   1    2   5    0100 0001 0010 0101   0x4125
    //ADD   5    3   6    0011 0101 0011 0110   0x3536
    //SUB   6    4   0    0100 0110 0100 0000   0x4640
    //ST    0   BB        0001 0000 10111011    0x10BB
    //HALT                0101 000000000000     0X5000
    //---------------------------------------------------
    //                  MEMORY DATA:
    //---------------------------------------------------
    //D[3] = 0x10AA
    //D[A] = 0xB0C5
    //D[1A] = 0x00DC
    //D[8A] = 0x00E9
    //EXPECTED RESULT = BFAA, ACTUAL RESULT = BFAA :)
    //---------------------------------------------------

    //The Processor
    processor proc0 (
        .clock ( clock ), 
        .reset ( reset ), 
        .alu_a ( alu_a ), 
        .alu_b ( alu_b ), 
        .alu_out ( alu_out ), 
        .ir_instruction ( ir_instruction ), 
        .mux_out ( mux_out ),
        .pc_address ( pc_address ), 
        .rf_ra_addr_out ( rf_ra_addr_out ), 
        .rf_rb_addr_out ( rf_rb_addr_out ),
        .rf_w_addr_out ( rf_w_addr_out ),
        .rq0 ( rq0 ),
        .state_o ( state_o )
);


    // 8 to 1 Multiplexer
    mux8_1 #(.N(16)) mux0 (
        .input0 ( {7'b0, pc_address, state_o} ),          // S = 0 => HEX7 = 0; HEX6, HEX5 = PC; HEX4 = Current State;
        .input1 ( alu_a ),                          // S = 1 => HEX7, 6, 5, 4 = ALU_A (A-side input to ALU)
        .input2 ( alu_b ),                          // S = 2 => HEX7, 6, 5, 4 = ALU_B (B-side input to ALU)
        .input3 ( alu_out ),                        // S = 3 => HEX7, 6, 5, 4 = ALU_Out (ALU output)
        .input4 ( {4'b0,
                   rf_w_addr_out, 
                   rf_ra_addr_out, 
                   rf_rb_addr_out} ),               // S = 4 => Unused (use this for your own debug information)
        .input5 ( rq0 ),                            // S = 5 => HEX7, 6, 5, 4 = Register File 0 contents
        .input6 ( mux_out ),                        // S = 6 => HEX7, 6, 5, 4 = Datapath Multiplexer output
        .input7 ( 16'b0 ),                           // S = 7 => Unused (use this for your own debug information) 
        .select ( select ),                         // The Select line
        .q ( q )                                    // The output
    );

    //Display current contents of IR(Instruction Register)
    hex7seg h0 (
        .c ( ir_instruction[3:0] ),
        .display ( HEX0 )
    );
    hex7seg h1 (
        .c ( ir_instruction[7:4] ),
        .display ( HEX1 )
    );
    hex7seg h2 (
        .c ( ir_instruction[11:8] ),
        .display ( HEX2 )
    );
    hex7seg h3 (
        .c ( ir_instruction[15:12] ),
        .display ( HEX3 )
    );

    //Display the output to the 7 to 1 multiplexer
    hex7seg h4 (
        .c ( q[3:0] ),
        .display ( HEX4 )
    );
    hex7seg h5 (
        .c ( q[7:4] ),
        .display ( HEX5 )
    );
    hex7seg h6 (
        .c ( q[11:8] ),
        .display ( HEX6 )
    );
    hex7seg h7 (
        .c ( q[15:12] ),
        .display ( HEX7 )
    );
endmodule