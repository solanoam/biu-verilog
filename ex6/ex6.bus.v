module MASTER (start, clk, request, grant, write);
    input start;
    input clk;
    input grant;
    parameter WRITE_VALUE = 8'b11111111;
    output reg [7:0]write;
    output request;
    assign request = start;
    always @ (posedge clk) begin
        if (grant) begin
            write = WRITE_VALUE;
        end 
    end
endmodule

module ARBITER(clk, request, grant);
    input [2:0]request;
    input clk;
    output reg [2:0]grant;
    always @ (posedge clk) begin
        if (request[2] == 1) begin
            grant[0] = 0;
            grant[1] = 0;
            grant[2] = 1;
        end
        else if (request[1] == 1) begin
            grant[0] = 0;
            grant[2] = 0;
            grant[1] = 1;
        end
        else if (request[0] == 1) begin
            grant[1] = 0;
            grant[2] = 0;
            grant[0] = 1;
        end
        else begin
            grant[1] = 0;
            grant[2] = 0;
            grant[0] = 0;
        end
    end
endmodule

module BUS(start, clk, nrst, bus_data);
    input [2:0]start;
    input clk;
    input nrst;
    output reg [7:0]bus_data;
    wire [7:0]write0;
    wire [7:0]write1;
    wire [7:0]write2;
    wire [2:0]grant;
    wire [2:0]request;
    MASTER #(8'b10101010) MASTER0 (.start(start[0]), .clk(clk), .request(request[0]), .grant(grant[0]), .write(write0));
    MASTER #(8'b11001100) MASTER1 (.start(start[1]), .clk(clk), .request(request[1]), .grant(grant[1]), .write(write1));
    MASTER #(8'b11110000) MASTER2 (.start(start[2]), .clk(clk), .request(request[2]), .grant(grant[2]), .write(write2));
    ARBITER ARBITER0(.clk(clk), .request(request), .grant(grant));
    always @ (posedge clk) begin
        if (!nrst) begin
            if (grant[2]) begin
                bus_data <= write2;
            end
            else if (grant[1]) begin
                bus_data <= write1;
            end
            else if (grant[0]) begin
                bus_data <= write0;
            end
        end
    end
    always @ (posedge clk) begin
        if (nrst) begin
        bus_data <= 0;
        end
    end
endmodule

module BUS_TB();
    reg clk = 0;
    reg [2:0]start; 
    reg nrst;
    wire [7:0]bus_data;
    always #1 clk = !clk;
    BUS test_module(.clk(clk), .start(start), .nrst(nrst), .bus_data(bus_data));
	initial	 
		begin
            $monitor($time, " clk=%b, start=%b, nrst=%b, bus_data=%b", clk, start, nrst, bus_data);		
            $dumpfile("bus.vcd");
            $dumpvars(0, BUS_TB);
			#4 start=3'b100; nrst=1'b0;
            #4 start=3'b010;
            #4 start=3'b001;
            #4 start=3'b110;
            #4 start=3'b111;
            #4 start=3'b101;
            #4 start=3'b011;
            #4 nrst=1'b1;
            #4 nrst=1'b0;
            #4 start=3'b100;
            $finish;
		end
endmodule