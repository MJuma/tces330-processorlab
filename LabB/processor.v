module processor (
    clock, 
    reset, 

    alu_a, 
    alu_b, 
    alu_out, 
    ir_instruction, 
    mux_out,
    pc_address, 
    rf_ra_addr_out, 
    rf_rb_addr_out,
    rf_w_addr_out,
    rq0,
    state_o
);

    //-----------------------
    // Input Ports
    //-----------------------
    input           clock;      // System Clock
    input           reset;      // System Reset
    
    //-----------------------
    // Output Ports
    //-----------------------
    output  [15:0]  ir_instruction; // Instruction Register
    output  [4:0]   pc_address;     // Program Counter
    output  [3:0]   state_o;        // FSM Current State
    output  [15:0]  alu_a;          // ALU A-Side Input
    output  [15:0]  alu_b;          // ALU B-Side Input
    output  [15:0]  alu_out;        // ALU Current Output
    output  [3:0]   rf_w_addr_out;  // 
    output  [3:0]   rf_ra_addr_out; // 
    output  [3:0]   rf_rb_addr_out; // 
    output  [15:0]  rq0;            // RF[0] Contents
    output  [15:0]  mux_out;        // Datapath Mux Output
    
    //-----------------------
    // Wires
    //-----------------------
    wire    [7:0]   d_addr;
    wire            d_wr;
    wire            rf_s;
    wire            rf_w_wr;
    wire            rf_ra_rd;
    wire            rf_rb_rd;
    wire    [3:0]   rf_w_addr;
    wire    [3:0]   rf_ra_addr;
    wire    [3:0]   rf_rb_addr;
    wire    [2:0]   alu_s0;
    
    assign rf_w_addr_out = rf_w_addr;
    assign rf_ra_addr_out = rf_ra_addr;
    assign rf_rb_addr_out = rf_rb_addr;
    
    control_unit cu0 (
        .clock ( clock ),
        .reset ( reset ),
        .alu_s0 ( alu_s0 ),
        .d_addr ( d_addr ),
        .d_wr ( d_wr ),
        .ir_instruction ( ir_instruction ),
        .pc_address ( pc_address ),
        .rf_ra_addr ( rf_ra_addr ),
        .rf_ra_rd ( rf_ra_rd ),
        .rf_rb_addr ( rf_rb_addr ),
        .rf_rb_rd ( rf_rb_rd ),
        .rf_s ( rf_s ),
        .rf_w_addr ( rf_w_addr ),
        .rf_w_wr ( rf_w_wr ),
        .state_o ( state_o )
    );
    
    datapath dp0 (
        .clock ( clock ),
        .d_addr ( d_addr ),
        .d_wr ( d_wr ),
        .reset ( reset ),
        .rf_ra_addr ( rf_ra_addr ),
        .rf_ra_rd ( rf_ra_rd ),
        .rf_rb_addr ( rf_rb_addr ),
        .rf_rb_rd ( rf_rb_rd ),
        .rf_s ( rf_s ),
        .rf_w_addr ( rf_w_addr ),
        .rf_w_wr ( rf_w_wr ),
        .alu_s0 ( alu_s0 ),
        .alu_a ( alu_a ),
        .alu_b ( alu_b ),
        .alu_out ( alu_out ),
        .mux_out ( mux_out ),
        .rq0 ( rq0 )
    );
endmodule
