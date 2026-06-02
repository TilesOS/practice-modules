`timescale 1ns/1ps

module adder4bit_tb;
    reg [3:0] a, b;
    reg cin;
    wire cout;
    wire [3:0] sum;

    reg [4:0] expected;
    integer i;
    integer errors = 0;

    adder4bit uut (
        .a(a),
        .b(b),
        .cin(cin),
        .cout(cout),
        .sum(sum)
    );

    initial begin
        for (i = 0; i < 512; i = i + 1) begin
            {a, b, cin} = i;
            #10

            expected = a + b + cin;

            if (sum !== expected[3:0] || cout !== expected[4]) begin
                errors = errors + 1;
                $display("ERROR: a=%b b=%b cin=%b | sum=%b expected=%b | cout=%b expected=%b",
                          a, b, cin, sum, expected[3:0], cout, expected[4]);
            end
        end

        if ( errors == 0) $display("PASSED: all 512 tests.");
        else $display("FAILED: %0d/512 tests.", errors);
        $finish;
    end

endmodule
