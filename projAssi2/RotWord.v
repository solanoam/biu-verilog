module RotWord #
(
parameter BYTE = 8,
parameter DWORD = 32,
parameter LEGNTH = 128
)
(
input [ DWORD-1:0 ] in,
output [ DWORD-1 : 0 ] out
);
	//shift left cyclic byte of the input
	assign out = { in [ 23 : 16 ] , in [ 15 : 8 ] , in [ 7 : 0 ] , in [ 31 : 24 ] } ;
endmodule
