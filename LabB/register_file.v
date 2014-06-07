/*
TCES 330 Spring 2014
05/27/2014
Brendan Crawford
Mohammad Juma
Antonio Orozco
Lab B
This module implements a dual output register file.
*/

module register_file (
    clock,
    ra_addr,
    ra_en,
    rb_addr,
    rb_en,
    reset,
    w_addr,
    w_data,
    w_en,
    
    ra_data,
    rb_data
);

    //-----------------------
    // Parameters
    //-----------------------
    parameter N = 16;

    //-----------------------
    // Input Ports
    //-----------------------
    input           clock;      // System clock
    input   [3:0]   ra_addr;    // A side read address
    input           ra_en;      // A side read enable
    input   [3:0]   rb_addr;    // B Side read address
    input           rb_en;      // B side read enable
    input           reset;      // System reset
    input   [3:0]   w_addr;     // Write address
    input   [N-1:0] w_data;     // Data to write
    input           w_en;       // Write enable
    
    //-----------------------
    // Output Ports
    //-----------------------
    output  [15:0]  ra_data;    // A side output (switched)
    output  [15:0]  rb_data;    // B side output (switched)
    
    //-----------------------
    // Wires
    //-----------------------
    wire    [15:0]  ra_d;       // A side read enable (decoder output)
    wire    [15:0]  rb_d;       // B side read enable (decoder output)
    wire    [15:0]  w_d;        // Write enable (decoder output)
    
    genvar I;
    
    write_decoder #(.N(4)) write_dec (w_addr, w_en, w_d);
    
    read_decoder #(.N(4)) read_dec (ra_addr, rb_addr, ra_en, rb_en, ra_d, rb_d);
    
    /*
    // Write decoder
    decoder #(.N(4)) write_decoder (
        .w ( w_addr ),
        .e ( w_en ),
        .y ( w_d )
    );
    
    
    // A side read decoder
    decoder #(.N(4)) read_a_decoder (
        .w ( ra_addr ),
        .e ( ra_en ),
        .y ( ra_d )
    );
    
    // B side read decoder
    decoder #(.N(4)) read_b_decoder (
        .w ( rb_addr ),
        .e ( rb_en ),
        .y ( rb_d )
    );*/
    
    register_dual_oe #(.N(N)) r0 (clock, w_d[0], w_data, 
                                  ra_d[0], rb_d[0], reset, 
                                  ra_data, rb_data);
    register_dual_oe #(.N(N)) r1 (clock, w_d[1], w_data, 
                                  ra_d[1], rb_d[1], reset, 
                                  ra_data, rb_data);
    register_dual_oe #(.N(N)) r2 (clock, w_d[2], w_data, 
                                  ra_d[2], rb_d[2], reset, 
                                  ra_data, rb_data);
    register_dual_oe #(.N(N)) r3 (clock, w_d[3], w_data, 
                                  ra_d[3], rb_d[3], reset, 
                                  ra_data, rb_data);
    register_dual_oe #(.N(N)) r4 (clock, w_d[4], w_data, 
                                  ra_d[4], rb_d[4], reset, 
                                  ra_data, rb_data);
    register_dual_oe #(.N(N)) r5 (clock, w_d[5], w_data, 
                                  ra_d[5], rb_d[5], reset, 
                                  ra_data, rb_data);
    register_dual_oe #(.N(N)) r6 (clock, w_d[6], w_data, 
                                  ra_d[6], rb_d[6], reset, 
                                  ra_data, rb_data);
    register_dual_oe #(.N(N)) r7 (clock, w_d[7], w_data, 
                                  ra_d[7], rb_d[7], reset, 
                                  ra_data, rb_data);
    register_dual_oe #(.N(N)) r8 (clock, w_d[8], w_data, 
                                  ra_d[8], rb_d[8], reset, 
                                  ra_data, rb_data);
    register_dual_oe #(.N(N)) r9 (clock, w_d[9], w_data, 
                                  ra_d[9], rb_d[9], reset, 
                                  ra_data, rb_data);
    register_dual_oe #(.N(N)) r10 (clock, w_d[10], w_data, 
                                  ra_d[10], rb_d[10], reset, 
                                  ra_data, rb_data);
    register_dual_oe #(.N(N)) r11 (clock, w_d[11], w_data, 
                                  ra_d[11], rb_d[11], reset, 
                                  ra_data, rb_data);
    register_dual_oe #(.N(N)) r12 (clock, w_d[12], w_data, 
                                  ra_d[12], rb_d[12], reset, 
                                  ra_data, rb_data);
    register_dual_oe #(.N(N)) r13 (clock, w_d[13], w_data, 
                                  ra_d[13], rb_d[13], reset, 
                                  ra_data, rb_data);
    register_dual_oe #(.N(N)) r14 (clock, w_d[14], w_data, 
                                  ra_d[14], rb_d[14], reset, 
                                  ra_data, rb_data);
    register_dual_oe #(.N(N)) r15 (clock, w_d[15], w_data, 
                                  ra_d[15], rb_d[15], reset, 
                                  ra_data, rb_data);

    /*
    // Instantiate the 16 dual-output registers
    generate
        for ( I=0; I<16; I=I+1 ) begin: rgen
            register_dual_oe #(.N(N)) U (
                    .clock ( clock ),
                    .ld ( w_d[I] ),
                    .input_data ( w_data ),
                    .oea ( ra_d[I] ),
                    .oeb ( rb_d[I] ),
                    .reset ( reset ),
                    .qa ( ra_data ),
                    .qb ( rb_data )
            );
        end
    endgenerate    
    */
endmodule
