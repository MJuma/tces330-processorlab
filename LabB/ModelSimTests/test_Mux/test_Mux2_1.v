`timescale 1ns/1ns
module test_Mux2_1;
    reg [15:0] A, B;
    reg SelectLine, clock;
    wire [15:0] Mux_Out;
    
    Mux2_1 #(.N(16)) MUX (A, B, SelectLine, Mux_Out);

    always begin
        clock = 0;
        #10;
       clock = 1;
        #10;
    end
    
    initial begin
        A = 16'h35CF;
        B = 16'h926A;
        SelectLine = 0;
        #40;//output should be A
        SelectLine = 1;
        #40; //output should be B now;
        $stop;
    end 
    
    initial
      $monitor("Time%d
                Input A = %h
                Input B = %h
                Select Line = %d
                Q = %h", $stime, A, B, SelectLine, Mux_Out);

endmodule 