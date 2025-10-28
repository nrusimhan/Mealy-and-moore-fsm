// moore_seq101.v
// Moore FSM for detecting the bit sequence "101" (overlapping allowed)

module moore_seq101 (
    input clk,
    input rst_n,   // active-low reset
    input in,      // serial input bit
    output reg y   // output = 1 when sequence "101" is detected
);

    // State encoding
    parameter S0 = 2'b00;  // No bits matched
    parameter S1 = 2'b01;  // Saw '1'
    parameter S2 = 2'b10;  // Saw "10"
    parameter S3 = 2'b11;  // Saw "101"

    reg [1:0] state, next_state;

    // State register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end

    // Next-state logic
    always @(*) begin
        case (state)
            S0: begin
                if (in)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (in)
                    next_state = S1;  // still '1'
                else
                    next_state = S2;  // got "10"
            end

            S2: begin
                if (in)
                    next_state = S3;  // got "101"
                else
                    next_state = S0;
            end

            S3: begin
                if (in)
                    next_state = S1;  // overlap: last bit '1'
                else
                    next_state = S2;  // could start new sequence
            end

            default: next_state = S0;
        endcase
    end

    // Output logic (depends only on current state)
    always @(*) begin
        case (state)
            S3: y = 1'b1;
            default: y = 1'b0;
        endcase
    end

endmodule
