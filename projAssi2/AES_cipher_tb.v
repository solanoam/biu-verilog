`include "AES_cipher.v"
module TB();
	reg[127:0] usrText, Key;
	reg clk, nrst;
	wire[127:0] encUsrText;
	always #2 clk = !clk;
	AES_cipher AES_inst(.clk(clk) , .nrst(nrst) , .usrText(usrText) , .Key(Key) , .encUsrText(encUsrText));
	initial begin
		$monitor($time, "clk=%b, nrst=%b, usrText=%h, Key=%h, encUsrText=%h", clk, nrst, usrText, Key, encUsrText);
		$dumpfile("AES_cipher.vcd");
		$dumpvars(0, TB);
		#1 clk = 0;
		#1 nrst = 1;
		#1 nrst = 0;
		#1 nrst = 1;
		#1 nrst = 0;
		#5 usrText = 128'h3243f6a8885a308d313a98a2e0370734;
		Key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
		#10 usrText = 128'h3243f6a8885a308d313a98a2e0370534;
		Key = 128'h2b7e151628aed2a6abf7158809cf4f1c;
		#10 usrText = 128'h3243f6a8885a308d313a98a2e0370534;
		Key = 128'h2b7e151628aed2a6abf7158809cf4f1a;
		#100 $finish;
	end
endmodule
