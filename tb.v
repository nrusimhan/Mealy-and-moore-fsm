`timescale 1ns / 1ps
// tb_mealy_seq110.v
`timescale 1ns/1ps

module tb_mealy_seq110;

    reg clk, rst_n, in;
    wire y;

    // Instantiate the DUT
    mealy_seq110 dut (
        .clk(clk),
        .rst_n(rst_n),
        .in(in),
        .y(y)
    );

    // Clock generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        rst_n = 0; in = 0;
        #12 rst_n = 1;

        // Input bit stream: 1 1 0 1 1 0 1 0
        #10 in = 1;
        #10 in = 1;
        #10 in = 0; // "110" detected here (y = 1)
        #10 in = 1;
        #10 in = 1;
        #10 in = 0; // second "110" detected
        #10 in = 1;
        #10 in = 0;
        #20 $finish;
    end

    // Display signals
    initial begin
        $monitor("T=%0t | in=%b | y=%b | state=%b",
                 $time, in, y, dut.state);
    end

endmodule

