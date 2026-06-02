module adder4bit (
    input [3:0] a, b,
    input cin,
    output cout,
    output [3:0] sum
);

    wire c0, c1, c2;

    add fa0 (
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .sum(sum[0]),
        .cout(c0)
    );

    add fa1 (
        .a(a[1]),
        .b(b[1]),
        .cin(c0),
        .sum(sum[1]),
        .cout(c1)
    );

    add fa2 (
        .a(a[2]),
        .b(b[2]),
        .cin(c1),
        .sum(sum[2]),
        .cout(c2)
    );

    add fa3 (
        .a(a[3]),
        .b(b[3]),
        .cin(c2),
        .sum(sum[3]),
        .cout(cout)
    );

endmodule

module add (
    input a, b, cin,
    output cout, sum
);

    assign cout = (a & b) | (a & cin) | (b & cin);
    assign sum = (a ^ b ^ cin);

endmodule
