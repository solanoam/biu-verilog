module Xmult #(parameter BYTE=8, parameter WORD=32, parameter SENTENCE=128) (Input_Byte, Output_Byte); 
input [BYTE-1:0] Input_Byte;
output wire [BYTE-1:0] Output_Byte;
// checks the MSB of the Input_Byte: if it is 0  shift left
 // if it is a 1  shift to the left and XOR with {1B}.
assign Output_Byte = (!Input_Byte[BYTE-1]) ? {Input_Byte[BYTE-2:0],1'b0} : {Input_Byte[BYTE-2:0],1'b0} ^ 8'h1B;
endmodule
