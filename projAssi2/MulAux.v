module MulAux # ( parameter BYTE = 8 , parameter DWORD = 32 , parameter LENGTH = 128 )
( input [ BYTE-1 : 0 ] inpt, output [ BYTE-1 : 0 ] oupt ) ;
wire [ BYTE-1 : 0 ] ouptM ;
Mul inst1 ( inpt , ouptM ) ;
assign oupt = ouptM ^ inpt ;
endmodule
