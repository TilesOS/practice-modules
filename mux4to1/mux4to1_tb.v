`timescale 1ns/1ps

module mux4to1_tb;
    reg s0, s1;
    reg d0, d1, d2, d3;
    wire out;

    reg expected;
    integer i;
    integer errors = 0;

    mux4to1 uut (
        .s0(s0),
        .s1(s1),
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3),
        .out(out)
    );

    initial begin
        for (i = 0; i < 64; i = i + 1) begin
            {s1, s0, d3, d2, d1, d0} = i;
            #10;

            case ({s1, s0})
                2'b00: expected = d0;
                2'b01: expected = d1;
                2'b10: expected = d2;
                2'b11: expected = d3;
                default: expected = 1'bx;
            endcase

            if (out != expected) begin
                errors = errors + 1;
                $display("ERROR: s1=%b s0=%b d3=%b d2=%b d1=%b d0=%b out=%b expected=%b",
                         s1, s0, d3, d2, d1, d0, out, expected);
            end
        end

        if (errors == 0) $display("PASSED: all 64 tests.");
        else $display("FAILED: %0d/64 tests.", errors);
        $finish;
    end

endmodule
