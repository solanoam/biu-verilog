`include "Sbox.v"
module SubBytes # (
parameter BYTE = 8,
parameter DWORD = 32,
parameter LENGTH = 128
)
(
input [ LENGTH-1 : 0 ] in,
output [ LENGTH-1 : 0 ] out
);
	Sbox sbox11 ( in [ 1*BYTE-1 : 0 ] , out [ BYTE-1 : 0 ] ) ;
	Sbox sbox12 ( in [ 2*BYTE-1 : 1*BYTE ] , out [ 2*BYTE-1 : 1*BYTE ] ) ;
	Sbox sbox13 ( in [ 3*BYTE-1 : 2*BYTE ] , out [ 3*BYTE-1 : 2*BYTE ] ) ;
	Sbox sbox14 ( in [ 4*BYTE-1 : 3*BYTE ] , out [ 4*BYTE-1 : 3*BYTE ] ) ;
	Sbox sbox21 ( in [ 5*BYTE-1 : 4*BYTE ] , out [ 5*BYTE-1 : 4*BYTE ] ) ;
	Sbox sbox22 ( in [ 6*BYTE-1 : 5*BYTE ] , out [ 6*BYTE-1 : 5*BYTE ] ) ;
	Sbox sbox23 ( in [ 7*BYTE-1 : 6*BYTE ] , out [ 7*BYTE-1 : 6*BYTE ] ) ;
	Sbox sbox24 ( in [ 8*BYTE-1 : 7*BYTE ] , out [ 8*BYTE-1 : 7*BYTE ] ) ;
	Sbox sbox31 ( in [ 9*BYTE-1 : 8*BYTE ] , out [ 9*BYTE-1 : 8*BYTE ] ) ;
	Sbox sbox32 ( in [ 10*BYTE-1 : 9*BYTE ] , out [ 10*BYTE-1 : 9*BYTE ] ) ;
	Sbox sbox33 ( in [ 11*BYTE-1 : 10*BYTE ] , out [ 11*BYTE-1 : 10*BYTE ] ) ;
	Sbox sbox34 ( in [ 12*BYTE-1 : 11*BYTE ] , out [ 12*BYTE-1 : 11*BYTE ] ) ;
	Sbox sbox41 ( in [ 13*BYTE-1 : 12*BYTE ] , out [ 13*BYTE-1 : 12*BYTE ] ) ;
	Sbox sbox42 ( in [ 14*BYTE-1 : 13*BYTE ] , out [ 14*BYTE-1 : 13*BYTE ] ) ;
	Sbox sbox43 ( in [ 15*BYTE-1 : 14*BYTE ] , out [ 15*BYTE-1 : 14*BYTE ] ) ;
	Sbox sbox44 ( in [ 16*BYTE-1 : 15*BYTE ] , out [ 16*BYTE-1 : 15*BYTE ] ) ;
endmodule
