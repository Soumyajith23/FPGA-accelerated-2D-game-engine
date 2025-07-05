`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2025 00:29:19
// Design Name: 
// Module Name: rgb_val
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//
// Dependencies: 
//
// Revision:
// Revision 0.02 - Game Over Display Added
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module rgb_val(
   input clk,
   input sclk,
   input rst,
   input pause,
   input btn_left,
   input btn_right,
   input btn_jump,
   input wire [9:0] x_pix,
   input wire [9:0] y_pix,
   output reg [15:0] rgb_out
);

    reg[18:0] bias;
    wire [15:0] counter_nm;
    wire [31:0] digit1_cor, digit2_cor, digit3_cor, digit4_cor;

    wire [3:0] col_cord2;
    wire [15:0] rgb_tiles;

    simple_counter cn(
        .clk(sclk),
        .rst(rst),
        .pause(pause),
        .count5(counter_nm)
    );

    number_list nl(
        .clk(clk),
        .y_cor(y_pix[4:0]),
        .counter_data(counter_nm),
        .digit1_cor(digit1_cor),
        .digit2_cor(digit2_cor),
        .digit3_cor(digit3_cor),
        .digit4_cor(digit4_cor)
    );

    always @(posedge clk) begin
        if (rst) bias <= 18'd0;
        else if (y_pix == 10'd485) bias <= bias + 18'd1;
    end

    reg [23:0] move_counter;
    reg [9:0] ball_x_offset;
    reg [9:0] ball_y;
    reg jumping;
    reg [9:0] jump_counter;
    reg game_over;

    wire [9:0] ball_x = 64 + ball_x_offset;
    wire [9:0] ball_bottom = ball_y + 32;

    always @(posedge sclk) begin
        if (rst) begin
            ball_x_offset <= 10'd0;
            ball_y <= 10'd268;
            move_counter <= 0;
            jumping <= 0;
            jump_counter <= 0;
            game_over <= 0;
        end else begin
            move_counter <= move_counter + 1;

            if (move_counter == 24'd5_000_000) begin
                move_counter <= 0;

                if (!game_over) begin
                    if (btn_right && ball_x_offset < 10'd544)
                        ball_x_offset <= ball_x_offset + 1;
                    else if (btn_left && ball_x_offset > 0)
                        ball_x_offset <= ball_x_offset - 1;

                    if (btn_jump && !jumping && ball_y == 268) begin
                        jumping <= 1;
                        jump_counter <= 0;
                    end

                    if (jumping) begin
                        if (jump_counter < 100) begin
                            ball_y <= ball_y - 1;
                            jump_counter <= jump_counter + 1;
                        end else begin
                            jumping <= 0;
                        end
                    end else begin
                        if (ball_bottom < 300 ||
                            (ball_x >= 128 && ball_x < 228) || (ball_x >= 350 && ball_x < 450)) begin
                            if (ball_y < 480)
                                ball_y <= ball_y + 1;
                        end
                    end

                    if (ball_bottom >= 480)
                        game_over <= 1;
                end
            end
        end
    end

    wire [127:0] score_ar;
    wire [31:0] ball_ar;
    wire [15:0] p_cord;
    wire [3:0] col_cord;
    wire [15:0] rgb_bg;
    wire [9:0] new_x_pix;

    wire [9:0] tiles_cord;
    wire [4:0] y_tiles_pix = y_pix - 300;
    assign tiles_cord = {x_pix[9:0],y_tiles_pix[4:0]};

    assign new_x_pix = x_pix + (bias>>10)-1;
    assign p_cord = new_x_pix[7] ? {y_pix[8:0], ~new_x_pix[6:0]} : {y_pix[8:0], new_x_pix[6:0]};

    wire show_score = (y_pix >= 32 && y_pix < 64 && x_pix >= 256 && x_pix < 384);
    wire show_ball  = (y_pix >= ball_y && y_pix < ball_y + 32 &&
                       x_pix >= 64 + ball_x_offset &&
                       x_pix < 96 + ball_x_offset);

    wire digit1 = (y_pix >= 32 && y_pix < 64 && x_pix >= 384 && x_pix < 416);
    wire digit2 = (y_pix >= 32 && y_pix < 64 && x_pix >= 416 && x_pix < 448);
    wire digit3 = (y_pix >= 32 && y_pix < 64 && x_pix >= 448 && x_pix < 480);
    wire digit4 = (y_pix >= 32 && y_pix < 64 && x_pix >= 480 && x_pix < 512);

    wire [4:0] ball_index;
    wire [4:0] ball_y_index = (y_pix - ball_y) & 5'h1F;
    assign ball_index = ~(x_pix - (10'd64 + ball_x_offset)) & 5'h1F;

    wire show_tiles = (y_pix >= 300 && y_pix < 332) &&
                      !((x_pix >= 128 && x_pix < 228) || (x_pix >= 350 && x_pix < 450));

    // Game Over Graphics
    wire [255:0] gameover_data;
    wire [7:0] gameover_index = ~(x_pix - 200) & 8'hFF;
    wire show_game_over = game_over && (y_pix >= 128 && y_pix < 160 && x_pix >= 200 && x_pix < 456);

    wire [4:0] digit1_index = ~(x_pix - 10'd384) & 5'h1F;
    wire [4:0] digit2_index = ~(x_pix - 10'd416) & 5'h1F;
    wire [4:0] digit3_index = ~(x_pix - 10'd448) & 5'h1F;
    wire [4:0] digit4_index = ~(x_pix - 10'd480) & 5'h1F;

    always @(posedge clk) begin
        if (show_score) begin
            rgb_out <= score_ar[~x_pix[6:0]] ? 16'h0000 : rgb_bg;
        end else if (show_game_over) begin
            rgb_out <= gameover_data[gameover_index] ? 16'hFFFF : rgb_bg;
        end else if (show_ball) begin
            rgb_out <= ball_ar[ball_index] ? 16'hD025 : rgb_bg;
        end else if (digit1) begin
            rgb_out <= digit1_cor[digit1_index] ? 16'hFFFF : rgb_bg;
        end else if (digit2) begin
            rgb_out <= digit2_cor[digit2_index] ? 16'hFFFF : rgb_bg;
        end else if (digit3) begin
            rgb_out <= digit3_cor[digit3_index] ? 16'hFFFF : rgb_bg;
        end else if (digit4) begin
            rgb_out <= digit4_cor[digit4_index] ? 16'hFFFF : rgb_bg;
        end else if (show_tiles) begin
            rgb_out <= rgb_tiles;
        end else begin
            rgb_out <= rgb_bg;
        end
    end

    blk_mem_gen_0 rgb_value (
        .clka(clk), .ena(1), .addra(col_cord), .douta(rgb_bg)
    );

    blk_mem_gen_1 bg_cord (
        .clka(clk), .ena(1), .addra(p_cord), .douta(col_cord)
    );

    blk_mem_gen_2 score_cord (
        .clka(clk), .ena(1), .addra(y_pix[4:0]), .douta(score_ar)
    );

    blk_mem_gen_3 ball_cord (
        .clka(clk), .ena(1), .addra(ball_y_index), .douta(ball_ar)
    );

    blk_mem_gen_14 tiles (
        .clka(clk), .ena(1), .addra(tiles_cord), .douta(col_cord2)
    );

    blk_mem_gen_0 rgb_value2 (
        .clka(clk), .ena(1), .addra(col_cord2), .douta(rgb_tiles)
    );

    blk_mem_gen_15 gameover_cord (
        .clka(clk), .ena(1), .addra(y_pix[4:0]), .douta(gameover_data)
    );

endmodule
