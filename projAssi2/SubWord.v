module SubWord #
(
parameter BYTE = 8,
parameter DWORD = 32,
parameter LENGTH = 128
)
(
input [ DWORD-1 : 0 ] inpt,
output [ DWORD-1 : 0 ] oupt
);
	Sbox inst1 ( inpt [ BYTE-1 : 0 ] , oupt [ BYTE-1 : 0 ] ) ;
	Sbox inst2 ( inpt [ 2*BYTE-1 : BYTE ] , oupt [ 2*BYTE-1 : BYTE ] ) ;
	Sbox inst3 ( inpt [ 3*BYTE-1 : 2*BYTE ] , oupt [ 3*BYTE-1 : 2*BYTE ] ) ;
	Sbox inst4 ( inpt [ DWORD-1:3*BYTE ] , oupt [ DWORD-1 : 3*BYTE ] ) ;
endmodule
