module PENC2(in, out, valid);
    input [7:0]in;
    output reg [2:0]out;
    output reg valid;
    always @ (in) begin
        valid = 1'b1;
        casex (in)
            8'b1xxxxxxx : out = 3'b111;
            8'b01xxxxxx : out = 3'b110;
            8'b001xxxxx : out = 3'b101;
            8'b0001xxxx : out = 3'b100;
            8'b00001xxx : out = 3'b011;
            8'b000001xx : out = 3'b010;
            8'b0000001x : out = 3'b001;
            default : begin
                out = 3'b000;
                valid = 1'b0;
            end
        endcase
    end
endmodule

module PENC2_TB();
    reg [7:0]in;
    wire [2:0]out;
    wire valid;
    PENC2 test_module(.in(in), .out(out), .valid(valid));
<<<<<<< current
	initial
		begin
=======
	initial	begin
>>>>>>> before discard
            $monitor($time, " in=%b, out=%b, valid=%b", in, out, valid);
            $dumpfile("ex4.case.vcd");
            $dumpvars(0, PENC2_TB);
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
