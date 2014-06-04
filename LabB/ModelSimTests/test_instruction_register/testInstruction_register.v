`timescale 1ns/1ns
module testInstruction_register;
    reg [15:0] data;
    reg load, clock, reset;
    wire [15:0] instruction;
    
    
    instruction_register IR ( clock, reset, data, load, instruction );

    always begin
        clock = 0;
        #10;
        clock = 1;
        #10;
    end

    initial begin
        reset = 0;
	data = 0;
	load = 0;
        #20;
        data = 16'h208A;
        #20;
        load = 1;
        #20;
        load = 0;
        #60; //it shouldn't load anything at this point
        reset = 1;
        #80;
        $stop;
    end 
    
    initial
    $monitor("Time%d
                Reset = %d
                Data = %h
                Load = %d
                Instruction = %h", $stime, reset, data, load, instruction);

endmodule 