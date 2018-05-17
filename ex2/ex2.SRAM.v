`timescale 1ns / 1ps
module SRAM(din, addr, wr, en, clk, dout);
    input [31:0]din;
    input [4:0]addr;
    input wr, en, clk;
	output [31:0]dout;
    reg [31:0] mem [0:31];
    parameter blank = 32'b0;
    integer i;
    initial begin
        for (i = 0; i < 32; i=i+1) begin
            mem[i] = 0;
        end
    end
    assign dout = en ? mem[addr]:blank;
    always @ (posedge clk) begin
        if (wr) begin
            mem[addr] = din;
        end
    end
endmodule  

module SRAM_TB ();
  
    wire [31:0]dout;
    reg [31:0]din;
    reg [4:0]addr;
    reg clk;
    reg wr, en;
    always #1 clk = !clk;
    SRAM SRAM_TEST (.din(din), .addr(addr), .wr(wr), .en(en), .clk(clk), .dout(dout));
    initial begin 
        $monitor($time,"clk=%b, din=%b, addr=%b, wr=%b, en=%b, dout=%b", clk, din, addr, wr, en, dout);
        $dumpfile("test.vcd");
        $dumpvars(0, SRAM_TB);
        #2 din = 32'd100; addr = 5'b1; wr = 1'b1; en = 1'b0; clk = 1'b0;
        #3 din = 32'd0; addr = 5'b1; wr = 1'b0; en = 1'b1; clk = 1'b0;
    end 
endmodule