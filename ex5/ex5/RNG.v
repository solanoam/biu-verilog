module RNGTB ();
reg clk,nrst;
reg d1,d2,d3,d4,q4;
wire [3:0] out;
always @(posedge clk or negedge nrst)
begin
    if (!nrst)
	begin
		d1 <= 1'b0;
		d2 <= 1'b1;
		d3 <= 1'b0;
		d4 <= 1'b0;
		q4 <= 1'b0;
	end
	else
	begin
		d1 <= d4^q4;	
		d2 <= d1;
		d3 <= d2;
		d4 <= d3;
		q4 <= d4;
	end		
end
assign	out[3] = d2;
assign	out[2] = d3;
assign	out[1] = d4;
assign	out[0] = q4;
always #1 clk=~clk;
initial
begin
    $monitor($time, "clk=%b, nrst=%b, out=%b",clk, nrst, out);
    $dumpfile("test.vcd");
    $dumpvars(0, RNGTB);
    clk = 1'b0;
    nrst = 1'b0;
    #1 nrst = 1'b1;
    #30 $finish;
end
endmodule