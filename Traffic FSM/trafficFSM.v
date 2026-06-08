`timescale 1ns/1ps

module trafficFSM (
    input clk, reset,
    output reg red, green, yellow
);

    reg [1:0] state;
    parameter RED    = 2'b00,
              GREEN  = 2'b01,
              YELLOW = 2'b10;

    reg [3:0] timer;

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= RED;
            timer <= 0;
    end else begin
        case (state)

            RED: begin
                if (timer == 4'd9) begin
                    state <= GREEN;
                    timer <= 0;
                end else begin
                    timer <= timer + 4'd1;
                end
            end

            GREEN: begin
                if (timer == 4'd9) begin
                    state <= YELLOW;
                    timer <= 0;
                end else begin
                    timer <= timer + 4'd1;
                end
            end

            YELLOW: begin
                if (timer == 4'd1) begin
                    state <= RED;
                    timer <= 0;
                end else begin
                    timer <= timer + 4'd1;
                end
            end

            default: begin
                state <= RED;
                timer <= 0;
            end

        endcase
    end
    end

    always @(*) begin
        red = 0;
        green = 0;
        yellow = 0;

        case (state)
            RED: red = 1;
            GREEN: green = 1;
            YELLOW: yellow = 1;
            default: red = 1;
        endcase
    end

endmodule
