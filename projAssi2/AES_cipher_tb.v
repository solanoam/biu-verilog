`include "AES_cipher.v"

module AES_cipher_tb() ;

reg[127:0] Plain_Text, Key ;
reg clk, nrst ;
wire[127:0] Cipher_Text;
always #1 clk = !clk;
AES_cipher AES_cipher_tb(clk , nrst , Plain_Text , Key , Cipher_Text) ;
initial begin
	$monitor($time, "out_lights=%b, clk=%b, opcode=%b, nrst=%b", out_lights, clk, opcode, nrst);
	$dumpfile("controller.vcd");
	$dumpvars(0, CONTROLLER_TB);
	clk = 0 ;
	nrst = 1;
	#10 Plain_Text = 128'h3243f6a8885a308d313198a2e0370734;
	Key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
	#50 $finish;
end

endmodule

//#10 Plain_Text = 128'h00112233445566778899aabbccddeeff;
	//Key=128'h000102030405060708090a0b0c0d0e0f;
