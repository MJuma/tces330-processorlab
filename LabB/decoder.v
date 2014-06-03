module decoder (
    w,
    e,
    
    y
);

    //-----------------------
    // Parameters
    //-----------------------
    parameter   N = 2;
    localparam  M = 2**N;
    
    //-----------------------
    // Input Ports
    //-----------------------
    input   [N-1:0] w;  // The inputs
    input           e;  // Enable
    
    //-----------------------
    // Output Ports
    //-----------------------
    output  reg [M-1:0] y;  // The outputs
    
    always @ ( w, e ) begin
        if ( e ) begin
            y = 1'b1 << w; // Shift a '1' into position
        end
        else begin
            y = 0;
        end
    end
endmodule
