`include "AES_cipher.v"
module TB();
	reg[127:0] Plain_Text, Key;
	reg clk, nrst;
	wire[127:0] Cipher_Text;
	always #2 clk = !clk;
	AES_cipher AES_inst(.clk(clk) , .nrst(nrst) , .Plain_Text(Plain_Text) , .Key(Key) , .Cipher_Text(Cipher_Text));
	initial begin
		$monitor($time, "clk=%b, nrst=%b, Plain_Text=%h, Key=%h, Cipher_Text=%h", clk, nrst, Plain_Text, Key, Cipher_Text);
		$dumpfile("AES_cipher.vcd");
		$dumpvars(0, TB);
		#1 clk = 0 ;
		#1 nrst = 0;
		#1 nrst = 1;
		#5 Plain_Text = 128'h3243f6a8885a308d313198a2e0370734;
		Key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
		#1 nrst = 1;
		#3 nrst = 0;
		#1000 $finish;
	end
endmodule

//#10 Plain_Text = 128'h00112233445566778899aabbccddeeff;
	//Key=128'h000102030405060708090a0b0c0d0e0f;
