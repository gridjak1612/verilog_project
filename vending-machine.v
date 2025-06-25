module vending_machine (
    input clk,
    input rst,
    input [1:0] in,     // 01 = ₹5, 10 = ₹10
    output reg out,     // 1 = dispense item
    output reg [1:0] change // 01 = ₹5 change, 10 = ₹10 change
);

    // State encoding
    parameter s0 = 2'b00; // ₹0
    parameter s1 = 2'b01; // ₹5
    parameter s2 = 2'b10; // ₹10

    reg [1:0] c_state, n_state;

    // Sequential block for state transition
    always @(posedge clk or posedge rst) begin
        if (rst)
            c_state <= s0;
        else
            c_state <= n_state;
    end

    // Combinational block for next state and output logic
    always @(*) begin
        // Default values
        n_state = c_state;
        out = 0;
        change = 2'b00;

        case (c_state)
            s0: begin
                case (in)
                    2'b00: n_state = s0;
                    2'b01: n_state = s1; // ₹5 received
                    2'b10: n_state = s2; // ₹10 received
                    default: n_state = s0;
                endcase
            end

            s1: begin
                case (in)
                    2'b00: begin
                        n_state = s0;
                        change = 2'b01; // return ₹5
                    end
                    2'b01: n_state = s2; // ₹5 + ₹5
                    2'b10: begin
                        n_state = s0;
                        out = 1;         // ₹5 + ₹10 = ₹15 -> dispense
                    end
                    default: n_state = s1;
                endcase
            end

            s2: begin
                case (in)
                    2'b00: begin
                        n_state = s0;
                        change = 2'b10; // return ₹10
                    end
                    2'b01: begin
                        n_state = s0;
                        out = 1;        // ₹10 + ₹5 = ₹15
                    end
                    2'b10: begin
                        n_state = s0;
                        out = 1;        // ₹10 + ₹10 = ₹20
                        change = 2'b01; // return ₹5
                    end
                    default: n_state = s2;
                endcase
            end

            default: begin
                n_state = s0;
                out = 0;
                change = 2'b00;
            end
        endcase
    end

endmodule
