module AddRoundKey #
(
parameter BYTE = 8,
parameter DWORD = 32,
parameter LENGTH = 128
)
(
input [ LENGTH-1 : 0 ] in,
input [ LENGTH-1 : 0 ] state,
output [ LENGTH-1 : 0 ] out
);

	assign out = in ^ state;
endmodule
