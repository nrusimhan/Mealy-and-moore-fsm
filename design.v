`timescale 1ns / 1ps
// mealy_seq110.v
// Mealy FSM to detect sequence "110" (overlapping allowed)

module mealy_seq110 (
    input clk,
    input rst_n,   // active-low reset
    input in,      // serial bit input
    output reg y   // output goes high immediately when "110" detected
);

    // State encoding
    parameter S0 = 2'b00;  // No bits matched
    parameter S1 = 2'b01;  // Saw '1'
    parameter S2 = 2'b10;  // Saw "11"

    reg [1:0] state, next_state;

    // State register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end

    // Next-state and output logic (Mealy)
    always @(*) begin
        next_state = state;
        y = 1'b0;  // default

        case (state)
            S0: begin
                if (in)
                    next_state = S1;  // got first '1'
                else
                    next_state = S0;
            end

            S1: begin
                if (in)
                    next_state = S2;  // got "11"
                else
                    next_state = S0;  // got '10' not matching
            end

            S2: begin
                if (in)
                    next_state = S2;  // still "11..." keep last 2 bits
                else begin
                    y = 1'b1;         // got "110" - sequence detected
                    next_state = S0;  // after detecting, reset to start
                end
            end

            default: next_state = S0;
        endcase
    end

endmodule

