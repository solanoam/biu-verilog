module Rcon #
(
parameter BYTE = 8,
parameter DWORD = 32,
parameter LENGTH = 128
)
(
input [ 3 : 0 ] round,
output [ DWORD-1 : 0 ] out
);
	// computing by the round what is the output of the rcon x^round (x=02h);
	assign out = (round == 4'd0) ? 32'h01_000000 :
		(round == 4'd1) ? 32'h02_000000 :
	  (round == 4'd2) ? 32'h04_000000 :
	  (round == 4'd3) ? 32'h08_000000 :
	  (round == 4'd4) ? 32'h10_000000 :
    (round == 4'd5) ? 32'h20_000000 :
	  (round == 4'd6) ? 32'h40_000000 :
	  (round == 4'd7) ? 32'h80_000000 :
	  (round == 4'd8) ? 32'h1b_000000 :
	  (round == 4'd9) ? 32'h36_000000 : 32'bzz;
endmodule
