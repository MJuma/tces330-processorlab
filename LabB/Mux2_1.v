module mux2_1 (
    x, 
    y, 
    s, 
    f 
);

    //-----------------------
    // Parameters
    //-----------------------
    parameter N = 2;
    
    //-----------------------
    // Input Ports
    //-----------------------
    input   [N-1:0] x;      // first input
    input   [N-1:0] y;      // second input
    input           s;      // selec line
    
    //-----------------------
    // Output Ports
    //-----------------------
    output  reg [N-1:0] f;  // output

	always @ ( x, y, s ) begin
        if ( s == 0 ) begin
            f = x; // if the select line is 1, then output = x
        end    
        else begin
            f = y; // else the output = y
        end
    end
endmodule 