module music (
    input clk,
    output reg buzzer
);

    // Define note frequencies (half-periods for 100MHz clock)
    parameter C5  = 27'd95556;
    parameter D5  = 27'd85127;
    parameter E5  = 27'd75871;
    parameter F5  = 27'd71633;
    parameter F_S5 = 27'd67567; // F#5
    parameter G5  = 27'd63776;
    parameter A5  = 27'd56818;
    parameter B5  = 27'd50619;
    parameter C6  = 27'd47778;
    parameter REST = 27'd0;

    // Note structure
    reg [26:0] half_period = 0;
    reg [26:0] stay_time = 0;
    reg [4:0] state = 0;

    reg [26:0] count1 = 0;
    reg [26:0] count2 = 0;

    always @(posedge clk) begin
        // Melody states
        case (state)
            5'd0:  begin half_period <= E5;   stay_time <= 27'd40000000; end
            5'd1:  begin half_period <= G5;   stay_time <= 27'd40000000; end
            5'd2:  begin half_period <= F_S5; stay_time <= 27'd40000000; end
            5'd3:  begin half_period <= E5;   stay_time <= 27'd40000000; end
            5'd4:  begin half_period <= B5;   stay_time <= 27'd40000000; end
            5'd5:  begin half_period <= A5;   stay_time <= 27'd40000000; end
            5'd6:  begin half_period <= F_S5; stay_time <= 27'd40000000; end
            5'd7:  begin half_period <= G5;   stay_time <= 27'd40000000; end
            5'd8:  begin half_period <= E5;   stay_time <= 27'd60000000; end
            5'd9:  begin half_period <= A5;   stay_time <= 27'd40000000; end
            5'd10: begin half_period <= B5;   stay_time <= 27'd40000000; end
            5'd11: begin half_period <= E5;   stay_time <= 27'd40000000; end
            5'd12: begin half_period <= G5;   stay_time <= 27'd40000000; end
            5'd13: begin half_period <= F_S5; stay_time <= 27'd40000000; end
            5'd14: begin half_period <= E5;   stay_time <= 27'd40000000; end
            5'd15: begin half_period <= D5;   stay_time <= 27'd60000000; end
            default: state <= 0; // loop back
        endcase

        // Tone generation logic
        if (count1 < stay_time) begin
            count1 <= count1 + 1;
            count2 <= count2 + 1;

            if (half_period != 0 && count2 >= half_period) begin
                buzzer <= ~buzzer;
                count2 <= 0;
            end
        end else begin
            count1 <= 0;
            count2 <= 0;
            buzzer <= 0;
            state <= (state == 5'd15) ? 0 : state + 1;
        end
    end
endmodule
