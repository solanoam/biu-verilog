`include "AES_cipher.v"
module TB();
	reg[127:0] Plain_Text, Key;
	reg clk, nrst;
	wire[127:0] Cipher_Text;
	always #1 clk = !clk;
	AES_cipher TB(clk , nrst , Plain_Text , Key , Cipher_Text) ;
	initial begin
		$monitor($time, "clk=%b, nrst=%b, Plain_Text=%h, Key=%h, Cipher_Text=%h", clk, nrst, Plain_Text, Key, Cipher_Text);
		$dumpfile("AES_cipher.vcd");
		$dumpvars(0, TB);
		clk = 0 ;
		nrst = 1;
		#10 Plain_Text = 128'h3243f6a8885a308d313198a2e0370734;
		Key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
		#50 $finish;
	end
endmodule

//#10 Plain_Text = 128'h00112233445566778899aabbccddeeff;
	//Key=128'h000102030405060708090a0b0c0d0e0f;
