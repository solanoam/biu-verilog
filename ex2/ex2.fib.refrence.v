module fib(input clock, reset, input [5:0] n, output reg ready, output [31:0] value)

reg [31:0] previous, current;
reg [5:0] counter;

// Reset the circuit
always @(posedge reset)
    begin
        previous <= 32'd0;
        current <= 32'd1;
        counter <= 32'd1;
    end

// Compute next Fibonacci number
always @(posedge clock)
    begin
        // Increment current index
        counter <= counter + 1;

        // Efficient adders are automatically inferred
        current <= current + previous;
        previous <= current;

       if (counter == n)
           ready <= 1;
    end

// Read the value of the nth fibonacci number from the internal register
assign value = current;

endmodule