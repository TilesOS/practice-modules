`timescale 1ns/1ps

module trafficFSM_tb;

    reg clk, reset;
    wire red, green, yellow;

    integer errors;
    integer i;

    trafficFSM uut (
        .clk(clk),
        .reset(reset),
        .red(red),
        .green(green),
        .yellow(yellow)
    );

    // 10 ns clock period
    initial clk = 0;
    always #5 clk = ~clk;

    task check_light;
        input exp_red, exp_green, exp_yellow;
        begin
            #1; // wait a little after clock edge for outputs to settle

            if ({red, green, yellow} !== {exp_red, exp_green, exp_yellow}) begin
                errors = errors + 1;
                $display("ERROR at time %0t: got RGY=%b%b%b expected=%b%b%b",
                         $time, red, green, yellow,
                         exp_red, exp_green, exp_yellow);
            end
        end
    endtask

    initial begin
        errors = 0;
        reset = 1;

        // Hold reset for a couple clock edges
        repeat (2) @(posedge clk);
        #1
        reset = 0;

        // Check initial RED state right after reset is released
        check_light(1, 0, 0);

        // RED should last 10 cycles total.
        // We already checked the first RED cycle above, so check 9 more.
        for (i = 0; i < 9; i = i + 1) begin
            @(posedge clk);
            check_light(1, 0, 0);
        end

        // Next clock should transition to GREEN
        @(posedge clk);
        check_light(0, 1, 0);

        for (i = 0; i < 5; i = i + 1) begin
            @(posedge clk);
            check_light(0, 1, 0);
        end

        reset = 1;
        #1
        check_light(1, 0, 0);

        repeat (2) @(posedge clk);
        #1
        reset = 0;

        // RED should last 10 cycles total.
        // We already checked the first RED cycle above, so check 9 more.
        for (i = 0; i < 9; i = i + 1) begin
            @(posedge clk);
            check_light(1, 0, 0);
        end

        // Next clock should transition to GREEN
        @(posedge clk);
        check_light(0, 1, 0);

        // GREEN should last 10 cycles total.
        // We already checked first GREEN cycle, so check 9 more.
        for (i = 0; i < 9; i = i + 1) begin
            @(posedge clk);
            check_light(0, 1, 0);
        end

        // Next clock should transition to YELLOW
        @(posedge clk);
        check_light(0, 0, 1);

        // YELLOW should last 2 cycles total.
        // We already checked first YELLOW cycle, so check 1 more.
        @(posedge clk);
        check_light(0, 0, 1);

        // Next clock should transition back to RED
        @(posedge clk);
        check_light(1, 0, 0);

        if (errors == 0)
            $display("PASS: trafficFSM test completed with no errors");
        else
            $display("FAIL: trafficFSM test completed with %0d errors", errors);

        $finish;
    end

endmodule
