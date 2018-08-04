module Mul #(parameter BYTE=8, parameter DWORD=32, parameter LENGTH=128) (inpt, oupt);
input [BYTE-1:0] inpt;
output wire [BYTE-1:0] oupt;
  assign oupt = (!inpt[BYTE-1]) ? {inpt[BYTE-2:0],1'b0} : {inpt[BYTE-2:0],1'b0} ^ 8'h1B;
endmodule
