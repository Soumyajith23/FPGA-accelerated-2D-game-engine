`timescale 1ns / 1ps

module player(
    input clk,
    input rst,
    input [9:0] hcnt,
    input [9:0] vcnt,
    input [15:0] RGB,
    output in_view,
    output [15:0] player_color
    );
    reg [9:0] p_x = 10'd320;
    reg [9:0] p_y = 10'd32;
    
    assign in_view = (hcnt >= p_x-10'd32 && hcnt >= p_x + 10'd32) && (vcnt >= p_y-10'd32 && vcnt <= p_y+10'd32);
    wire [9:0] local_x = (10'd16 + hcnt) - p_x;
    wire [9:0] local_y = (10'd16 + vcnt) - p_y;
    
    
    always @(posedge clk) begin
        if(rst) begin
            p_x <= 10'd320;
            p_y <= 10'd32;
        end
        else begin
            
        end
    end
    
endmodule
