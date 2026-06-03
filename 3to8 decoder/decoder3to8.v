module decoder3to8 (
    input a2, a1, a0,
    output d7, d6, d5, d4, d3, d2, d1, d0
);

    assign d7 = a2 & a1 & a0;
    assign d6 = a2 & a1 & ~a0;
    assign d5 = a2 & ~a1 & a0;
    assign d4 = a2 & ~a1 & ~a0;
    assign d3 = ~a2 & a1 & a0;
    assign d2 = ~a2 & a1 & ~a0;
    assign d1 = ~a2 & ~a1 & a0;
    assign d0 = ~a2 & ~a1 & ~a0;

endmodule
