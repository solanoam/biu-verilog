module FA(a, b, cin, cout, sum);
	input a, b, cin;
	output cout, sum;
	assign sum = a^b^cin;
	assign cout = ((a^b)&cin)|(a&b);
endmodule

module FA_TB();
	reg a, b, cin;
	wire sum, cout;
	FA test_module(.a(a), .b(b), .cin(cin), .cout(cout), .sum(sum));
	initial	 
		begin
			$monitor($time, " a=%b, b=%b, cin=%b, cout=%b, sum=%b", a, b, cin, cout, sum);		
			#1 a=1'b0;b=1'b0;cin=1'b0;
			#2 a=1'b0;b=1'b0;cin=1'b1;
			#3 a=1'b0;b=1'b1;cin=1'b0;
			#4 a=1'b0;b=1'b1;cin=1'b1;
			#5 a=1'b1;b=1'b0;cin=1'b0;
			#6 a=1'b1;b=1'b0;cin=1'b1;
			#7 a=1'b1;b=1'b1;cin=1'b0;
			#8 a=1'b1;b=1'b1;cin=1'b1;
		end	
endmodule


