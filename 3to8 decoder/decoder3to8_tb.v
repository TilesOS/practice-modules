`timescale 1ns/1ps

module decoder3to8_tb;
    reg a2, a1, a0;
    wire d7, d6, d5, d4, d3, d2, d1, d0;

    reg [7:0] expected;
    integer i;
    integer errors = 0;

    decoder3to8 uut (
        .a0(a0),
        .a1(a1),
        .a2(a2),
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3),
        .d4(d4),
        .d5(d5),
        .d6(d6),
        .d7(d7)
    );

    initial begin
        for (i = 0; i < 8; i = i + 1) begin
            {a2, a1, a0} = i;
            #10

            case ({a2, a1, a0})
                3'b000: expected = 8'b00000001;
                3'b001: expected = 8'b00000010;
                3'b010: expected = 8'b00000100;
                3'b011: expected = 8'b00001000;
                3'b100: expected = 8'b00010000;
                3'b101: expected = 8'b00100000;
                3'b110: expected = 8'b01000000;
                3'b111: expected = 8'b10000000;
                default: expected = 8'bxxxxxxxx;
            endcase

            if ({d7, d6, d5, d4, d3, d2, d1, d0} !== expected) begin
                errors = errors + 1;
                $display("ERROR: sel=%b out=%b expected=%b",
                {a2, a1, a0}, {d7, d6, d5, d4, d3, d2, d1, d0}, expected);
            end
        end

        if (errors == 0) $display("PASSED: all 8 tests.");
        else $display("FAILED: %0d/8 tests.", errors);
        $finish;
    end

endmodule
