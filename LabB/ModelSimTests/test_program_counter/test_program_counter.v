`timescale 1ns/1ns
module test_program_counter;
    reg pc_up, clock, pc_clr;
    wire [4:0] address;
    
    
    program_counter PC ( clock, pc_clr, pc_up, address );

    always begin
        clock = 0;
        #10;
        clock = 1;
        #10;
    end
    
    integer I;
    initial begin
        pc_clr = 0;
        pc_up = 0;
        #10;
	//test that it counts up 
        pc_up = 1;
        #700;
	//Test to see that it only increments when pc_up = 1;
	for(I = 0; I < 5; I = I + 1) begin
	pc_up = 1;
	#20;
	pc_up = 0;
	#40;
	end
	//test clear
        pc_clr = 1;
        #60;
        $stop;
    end 
    
    
    initial
      $monitor("Time%d
                PC Clear = %d
                PC Up = %d
                Adress = %h", $stime, pc_clr, pc_up, address);

endmodule 