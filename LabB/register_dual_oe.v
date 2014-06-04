module register_dual_oe (
    clock,
    ld,
    input_data,
    oea,
    oeb,
    reset,
    
    qa,
    qb
);

    //-----------------------
    // Parameters
    //-----------------------
    parameter N = 16;
    
    //-----------------------
    // Input Ports
    //-----------------------
    input           clock;      // System clock
    input           reset;      // System reset
    input           ld;         // Load signal
    input   [N-1:0] input_data; // Data to load
    input           oea;        // Channel A output enable
    input           oeb;        // Channel B output enable
    
    //-----------------------
    // Output Ports
    //-----------------------
    output  [N-1:0] qa;         // Channel A switched output
    output  [N-1:0] qb;         // Channel B switched output
    
    //-----------------------
    // Registers
    //-----------------------
    reg     [N-1:0] q;          // Standard (unswitched) output
    
    // Register procedure
    always @ ( posedge clock ) begin
        if ( reset ) begin
            q <= 0;
        end
        else if ( ld ) begin
            q <= input_data;
        end
    end
    
    // Output
    assign qa = oea ? q : {N{1'bZ}};
    assign qb = oeb ? q : {N{1'bZ}};
endmodule
