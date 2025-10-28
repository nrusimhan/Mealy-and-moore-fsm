`timescale 1ns / 1ps
// tb_moore_seq101.v
`timescale 1ns/1ps

module tb_moore_seq101;

    reg clk, rst_n, in;
    wire y;

    // Instantiate the DUT
    moore_seq101 dut (
        .clk(clk),
        .rst_n(rst_n),
        .in(in),
        .y(y)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test stimulus
    initial begin
        rst_n = 0; in = 0;
        #12 rst_n = 1;

        // Input sequence: 1 0 1 0 1 1 0 1
        #10 in = 1;
        #10 in = 0;
        #10 in = 1; // "101" detected here
        #10 in = 0;
        #10 in = 1; // overlap "101"
        #10 in = 1;
        #10 in = 0;
        #10 in = 1;
        #20 $finish;
    end

    // Display output
    initial begin
        $monitor("T=%0t | in=%b | y=%b | state=%b",
                 $time, in, y, dut.state);
    end

endmodule

