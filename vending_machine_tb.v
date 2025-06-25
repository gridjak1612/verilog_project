`timescale 1ns / 1ps

module vending_machine_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [1:0] in;

    // Outputs
    wire out;
    wire [1:0] change;

    // Instantiate the DUT (Device Under Test)
    vending_machine uut (
        .clk(clk),
        .rst(rst),
        .in(in),
        .out(out),
        .change(change)
    );

    // Clock generation: 10ns period (100 MHz)
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        in = 2'b00;

        // Reset pulse
        #10;
        rst = 0;

        // Test case 1: Insert ₹5
        #10; in = 2'b01; // ₹5
        #10; in = 2'b00; // no input
        #10;

        // Test case 2: Insert ₹10 → Should dispense (₹5+₹10 = ₹15)
        in = 2'b10; // ₹10
        #10; in = 2'b00;
        #10;

        // Test case 3: Insert ₹10
        in = 2'b10;
        #10; in = 2'b00;
        #10;

        // Test case 4: Insert ₹5 → Should dispense
        in = 2'b01;
        #10; in = 2'b00;
        #10;

        // Test case 5: Insert ₹10
        in = 2'b10;
        #10; in = 2'b10; // Insert another ₹10 → Should dispense + return ₹5
        #10; in = 2'b00;
        #10;

        // Test case 6: Insert ₹5, then ₹5 → Should move to ₹10 state
        in = 2'b01;
        #10; in = 2'b01;
        #10; in = 2'b00;
        #10;

        // Test case 7: Timeout or refund → input nothing after ₹10
        in = 2'b00;
        #10;

        // Finish
        $finish;
    end

    // Monitor outputs
    initial begin
        $display("Time\tin\tout\tchange\tstate");
        $monitor("%0dns\t%b\t%b\t%b", $time, in, out, change);
    end

endmodule
