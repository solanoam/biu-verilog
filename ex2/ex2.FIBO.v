module FIBO(clk, rst, value, count);
    input clk, rst;
    output [31:0] value;
    reg [31:0] previous, current;
    output reg [5:0] count;
    // rst 
    always @ (posedge rst) begin
        previous <= 32'd0;
        current <= 32'd1;
        count <= 5'd1;
    end
    // next number
    always @ (posedge clk) begin
        // current index
        count <= count + 1;
        current <= current + previous;
        previous <= current;
    end
    assign value = current;
endmodule
    
module FIBO_TB();
    reg rst;
    reg clk;
    wire [5:0] count;
    wire ready;
    wire [31:0] value;
    always #1 clk = !clk;
    FIBO FIBO_TEST (.clk(clk), .rst(rst), .value(value), .count(count));
    initial begin
        $monitor($time,"clk=%b, rst=%b, value=%h, count=%d", clk, rst, value, count);
        $dumpfile("test_fibo.vcd");
        $dumpvars(0, FIBO_TB);
        #1 clk = 1'b0; rst = 1'b1;
        #2 rst = 1'b0;
    end 
endmodule