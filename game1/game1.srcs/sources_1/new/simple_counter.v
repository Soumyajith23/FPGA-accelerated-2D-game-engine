`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2025 19:04:22
// Design Name: 
// Module Name: simple_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module simple_counter(
    input clk,
    input rst,
    input pause,
    output reg [15:0] count5
);

reg [27:0] count;


always @(posedge clk or posedge rst) begin
    
    if (rst )begin
        count <= 28'b0;
        count5 <= 16'b0;
        end
    else begin
        if(~pause && ~(count5[3:0]==4'd9 && count5[7:4]==4'd9 && count5[11:8]==4'd9 && count5[15:12]==4'd9 ))begin
        
    if (count < 28'd99999999  )
       count <= count + 1;
    else begin
        if (count5[3:0]<4'd9)
           count5[3:0] <= count5[3:0] + 1;
        else if(count5[7:4]<4'd9)begin
            count5[7:4] <= count5[7:4] + 1;
            count5[3:0] <= 4'd0;
        
        end
        else if(count5[11:8]<4'd9)begin
            count5[11:8] <= count5[11:8] + 1;
            count5[7:4] <= 4'd0;
            count5[3:0] <= 4'd0;
        end

        else if(count5[15:12]<4'd9)begin
            count5[15:12] <= count5[15:12] + 1;
            count5[11:8] <= 4'd0;
            count5[7:4] <= 4'd0;
            count5[3:0] <= 4'd0;
        end

        count <= 28'b0;
        end
    end
    end
end


endmodule
