module mux4to1 (
    input s0,
    input s1,
    input d0,
    input d1,
    input d2,
    input d3,
    output out
);

    wire w1;
    wire w2;
    wire w3;
    wire w4;

    assign w1 = (~s1 & ~s0 & d0);
    assign w2 = (~s1 & s0 & d1);
    assign w3 = (s1 & ~s0 & d2);
    assign w4 = (s1 & s0 & d3);

    assign out = (w1 | w2 | w3 | w4);

endmodule
