module mux4to1_tb;
    reg s0, s1;
    reg d0, d1, d2, d3;
    wire out;

    mux4to1 uut (
        .s0(s0),
        .s1(s1),
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3)
    );

    initial begin
        d0 = 0;
        d1 = 1;
        d2 = 0;
        d3 = 1;

        s1 = 0; s0 = 0; #10
        if (out != d0) $display("ERROR: 00 should output d0");
        s1 = 0; s0 = 1; #10
        if (out != d1) $display("ERROR: 01 should output d1");
        s1 = 1; s0 = 0; #10
        if (out != d2) $display("ERROR: 10 should output d2");
        s1 = 1; s0 = 1; #10
        if (out != d3) $display("ERROR: 11 should output d3");

        $display("Test completed.");
        $finish;
    end
endmodule
