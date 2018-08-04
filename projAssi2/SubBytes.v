`include "Sbox.v"
module SubBytes # (
parameter BYTE = 8,
parameter DWORD = 32,
parameter LENGTH = 128
)
(
input [ LENGTH-1 : 0 ] inpt,
output [ LENGTH-1 : 0 ] oupt
);
	Sbox inst11 ( inpt [ 1*BYTE-1 : 0 ] , oupt [ BYTE-1 : 0 ] ) ;
	Sbox inst12 ( inpt [ 2*BYTE-1 : 1*BYTE ] , oupt [ 2*BYTE-1 : 1*BYTE ] ) ;
	Sbox inst13 ( inpt [ 3*BYTE-1 : 2*BYTE ] , oupt [ 3*BYTE-1 : 2*BYTE ] ) ;
	Sbox inst14 ( inpt [ 4*BYTE-1 : 3*BYTE ] , oupt [ 4*BYTE-1 : 3*BYTE ] ) ;
	Sbox inst21 ( inpt [ 5*BYTE-1 : 4*BYTE ] , oupt [ 5*BYTE-1 : 4*BYTE ] ) ;
	Sbox inst22 ( inpt [ 6*BYTE-1 : 5*BYTE ] , oupt [ 6*BYTE-1 : 5*BYTE ] ) ;
	Sbox inst23 ( inpt [ 7*BYTE-1 : 6*BYTE ] , oupt [ 7*BYTE-1 : 6*BYTE ] ) ;
	Sbox inst24 ( inpt [ 8*BYTE-1 : 7*BYTE ] , oupt [ 8*BYTE-1 : 7*BYTE ] ) ;
	Sbox inst31 ( inpt [ 9*BYTE-1 : 8*BYTE ] , oupt [ 9*BYTE-1 : 8*BYTE ] ) ;
	Sbox inst32 ( inpt [ 10*BYTE-1 : 9*BYTE ] , oupt [ 10*BYTE-1 : 9*BYTE ] ) ;
	Sbox inst33 ( inpt [ 11*BYTE-1 : 10*BYTE ] , oupt [ 11*BYTE-1 : 10*BYTE ] ) ;
	Sbox inst34 ( inpt [ 12*BYTE-1 : 11*BYTE ] , oupt [ 12*BYTE-1 : 11*BYTE ] ) ;
	Sbox inst41 ( inpt [ 13*BYTE-1 : 12*BYTE ] , oupt [ 13*BYTE-1 : 12*BYTE ] ) ;
	Sbox inst42 ( inpt [ 14*BYTE-1 : 13*BYTE ] , oupt [ 14*BYTE-1 : 13*BYTE ] ) ;
	Sbox inst43 ( inpt [ 15*BYTE-1 : 14*BYTE ] , oupt [ 15*BYTE-1 : 14*BYTE ] ) ;
	Sbox inst44 ( inpt [ 16*BYTE-1 : 15*BYTE ] , oupt [ 16*BYTE-1 : 15*BYTE ] ) ;
endmodule
