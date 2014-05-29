module mux7_1 (A, B, C, D, E, F, G, H, S, Q);
	parameter N = 4; 
	input [N-1:0] A, B, C, D, E, F, G, H;
	input [2:0] S;
	output reg [N-1:0] Q;
	
	always @ (A, B, C, D, E, F, G, H, S) begin
			case (S)
				3'b001: Q = B;
				3'b010: Q = C;
				3'b011: Q = D;
				3'b100: Q = E;
				3'b101: Q = F;
				3'b110: Q = G;
				3'b111: Q = H;
				default: Q = A;
			endcase
	end
endmodule 