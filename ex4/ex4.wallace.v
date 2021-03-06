module FA(a, b, cin, cout, sum);
	input a, b, cin;
	output cout, sum;
	assign sum = a^b^cin;
	assign cout = ((a^b)&cin)|(a&b);
endmodule

module PENCW(in, out);
    input [14:0]in;
    output [3:0]out;
    wire [10:0]a;
    wire [10:0]b;
    wire [10:0]cin;
    wire [10:0]cout;
    wire [10:0]sum;
    FA FA0(.a(a[0]), .b(b[0]), .cin(cin[0]), .cout(cout[0]), .sum(sum[0]));
    FA FA1(.a(a[1]), .b(b[1]), .cin(cin[1]), .cout(cout[1]), .sum(sum[1]));
    FA FA2(.a(a[2]), .b(b[2]), .cin(cin[2]), .cout(cout[2]), .sum(sum[2]));
    FA FA3(.a(a[3]), .b(b[3]), .cin(cin[3]), .cout(cout[3]), .sum(sum[3]));
    FA FA4(.a(a[4]), .b(b[4]), .cin(cin[4]), .cout(cout[4]), .sum(sum[4]));
    FA FA5(.a(a[5]), .b(b[5]), .cin(cin[5]), .cout(cout[5]), .sum(sum[5]));
    FA FA6(.a(a[6]), .b(b[6]), .cin(cin[6]), .cout(cout[6]), .sum(sum[6]));
    FA FA7(.a(a[7]), .b(b[7]), .cin(cin[7]), .cout(cout[7]), .sum(sum[7]));
    FA FA8(.a(a[8]), .b(b[8]), .cin(cin[8]), .cout(cout[8]), .sum(sum[8]));
    FA FA9(.a(a[9]), .b(b[9]), .cin(cin[9]), .cout(cout[9]), .sum(sum[9]));
    FA FA10(.a(a[10]), .b(b[10]), .cin(cin[10]), .cout(cout[10]), .sum(sum[10]));
    assign b[0] = in[0];
    assign a[0] = in[1];
    assign cin[0] = in[2];
    assign b[1] = in[3];
    assign a[1] = in[4];
    assign cin[1] = in[5];
    assign cin[6] = in[6];
    assign b[2] = in[7];
    assign a[2] = in[8];
    assign cin[2] = in[9];
    assign b[3] = in[10];
    assign a[3] = in[11];
    assign cin[3] = in[12];
    assign cin[4] = in[13];
    assign cin[10] = in[14];
    assign a[4] = sum[3];
    assign a[5] = cout[3];
    assign b[4] = sum[2];
    assign b[5] = cout[2];
    assign a[6] = sum[1];
    assign a[7] = cout[1];
    assign b[6] = sum[0];
    assign b[7] = cout[0];
    assign a[10] = sum[4];
    assign cin[5] = cout[4];
    assign a[9] = sum[5];
    assign a[8] = cout[5];
    assign b[10] = sum[6];
    assign cin[7] = cout[6];
    assign b[9] = sum[7];
    assign b[8] = cout[7];
    assign out[0] = sum[10];
    assign cin[9] = cout[10];
    assign out[1] = sum[9];
    assign cin[8] = cout[9];
    assign out[2] = sum[8];
    assign out[3] = cout[8];
endmodule

module PENCW_TB();
    reg [14:0]in;
    wire [3:0]out; 
    PENCW test_module(.in(in), .out(out));
	initial	begin
        $monitor($time, "in=%b, out=%b", in, out);		
        $dumpfile("test.vcd");
        $dumpvars(0, PENCW_TB);
        #1 in=15'b000000000000000;
        #1 in=15'b000000000001000;
        #1 in=15'b000000100001010;
        #1 in=15'b000001000000000;
        #1 in=15'b000010000001101;
        #1 in=15'b000010100000000;
        #1 in=15'b000100000011111;
        #1 in=15'b001000000000000;
        #1 in=15'b010000000000011;
        #1 in=15'b010011100000000;
        #1 in=15'b100000000000000;
        #1 in=15'b111111110000000;
    end
endmodule