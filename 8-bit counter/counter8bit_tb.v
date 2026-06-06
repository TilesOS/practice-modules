`timescale 1ns/1ps

module counter8bit_tb;
    reg clk, reset;
    wire [7:0] out;

    reg [7:0] expected;
    integer errors;
    integer cycle;

    counter8bit uut (
        .clk(clk),
        .reset(reset),
        .out(out)
    );

    // 20 ns clock period
    always #10 clk = ~clk;

    // Update expected value on clock edge
    always @ (posedge clk) begin
        if (reset)
            expected <= 8'd0;
        else
            expected <= expected + 8'd1;
    end

    always @ (posedge clk) begin
        #1;
        cycle = cycle + 1;

        if (out !== expected) begin
            errors = errors + 1;
            $display("ERROR cycle %0d: reset=%b out=%d expected=%d",
                     cycle, reset, out, expected);
        end
    end

    initial begin
        clk = 0;
        reset = 1;
        expected = 0;
        errors = 0;
        cycle = 0;

        $display("Starting counter8bit testbench...");

        repeat (3) @ (posedge clk);

        @ (negedge clk);
        reset = 0;
        repeat (10) @ (posedge clk);

        @ (negedge clk);
        reset = 1;
        repeat (2) @ (posedge clk);

        @ (negedge clk);
        reset = 0;
        repeat (20) @ (posedge clk);

        // Count long enough to test wraparound
        repeat (260) @(posedge clk);

        if (errors == 0)
            $display("TEST PASSED");
        else
            $display("TEST FAILED: %0d errors found.", errors);

        $finish;
    end

endmodule
