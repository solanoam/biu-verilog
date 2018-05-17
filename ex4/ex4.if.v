module PENC1(in, out, valid);
    input [7:0]in;
    output reg [2:0]out;
    output reg valid;
    always @ (in) begin
        valid = 1'b1;
        if (in[7] == 1) begin
            out = 3'b111;
        end
        else if (in[6] == 1) begin
           out = 3'b110; 
        end
        else if (in[5] == 1) begin
           out = 3'b101; 
        end
        else if (in[4] == 1) begin
           out = 3'b100; 
        end
        else if (in[3] == 1) begin
           out = 3'b100; 
        end
        else if (in[2] == 1) begin
           out = 3'b011; 
        end
        else if (in[1] == 1) begin
           out = 3'b010; 
        end
        else if (in[0] == 1) begin
           out = 3'b001; 
        end
        else begin
            out = 3'b000;
            valid = 1'b0;
        end
    end
endmodule

module PENC1_TB();
    reg [7:0]in;
    wire [2:0]out; 
    wire valid;
    PENC1 test_module(.in(in), .out(out), .valid(valid));
	initial	 
		begin
            $monitor($time, " in=%b, out=%b, valid=%b", in, out, valid);		
			$dumpfile("test.vcd");
            $dumpvars(0, PENC1_TB);
			#1 in=8'b00000000;
            #1 in=8'b00000001;
            #1 in=8'b00000010;
            #1 in=8'b00000100;
            #1 in=8'b00001000;
            #1 in=8'b00001010;
            #1 in=8'b00010000;
            #1 in=8'b00100000;
            #1 in=8'b01000000;
            #1 in=8'b01001110;
            #1 in=8'b10000000;
            #1 in=8'b11111111;
		end
endmodule