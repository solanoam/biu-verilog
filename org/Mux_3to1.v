module Mux_3to1 # ( parameter BYTE = 8 , parameter WORD = 32, parameter SENTENCE = 128 )
(input [ 3 : 0 ] Round_Number , input [ SENTENCE-1 : 0 ] in , input [ SENTENCE-1 : 0 ] in_shift ,  input [ SENTENCE-1 : 0 ] in_zero , output reg [ SENTENCE-1 : 0 ] out ) ;

// mux 3 to 1 about what input will go to 'add_round_key' module with switch case
always @ ( Round_Number or in_shift or in_zero or in ) begin
	case ( Round_Number )
		4'd 0: out = in_zero ;
		4'd 01: out = in ;
		4'd 02: out = in ;
		4'd 03: out = in ;
		4'd 04: out = in ;
		4'd 05: out = in ;
		4'd 06: out = in ;
		4'd 07: out = in ;
		4'd 08: out = in ;
		4'd 09: out = in ;
		4'd 10: out = in_shift ;
		default : out = 128'b0 ;
	endcase
end
endmodule