module DFF (clk,nrst,d,q);
    input clk,nrst,d;
    output reg q;
    always @(posedge clk or negedge nrst)
        if (!nrst)
	       q <= 0;
        else
	       q <= d;
endmodule

module CSTB ();
    reg clk, nrst, d1, d2;
    wire GClkCtrl;
    wire q1,q2;
    wire ClkG;
    wire GClk;
    assign GClk = ClkG & clk;
    assign GClkCtrl = (d1^q1) | (d2^q2);
    DFF DFF1 (.clk(GClk),.nrst(nrst),.d(d1),.q(q1));
    DFF DFF2 (.clk(GClk),.nrst(nrst),.d(d2),.q(q2));
    DFF DFF3 (.clk(~clk),.nrst(nrst),.d(GClkCtrl),.q(ClkG));
    always #1 clk=~clk;
    initial
    begin
        $monitor($time, "clk=%b, nrst=%b, d1=%b, d2=%b, q1=%b, q2 =%b",clk, nrst, d1, d2, q1, q2 );
        $dumpfile("test.vcd");
        $dumpvars(0, CSTB);
        clk = 1'b0;
        nrst = 1'b0;
        #1 nrst = 1'b1; d1 = 1'b1; d2 = 1'b1;
        #2 d1 = 1'b1; d2 = 1'b0; 
        #3 $finish;
        end
endmodule