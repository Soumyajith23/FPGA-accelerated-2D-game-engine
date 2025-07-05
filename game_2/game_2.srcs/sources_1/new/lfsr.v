`timescale 1ns / 1ps


module lfsr(
    input clk,
    input rst,
    input [15:0] seed,
    output res
        );
        
    reg [15:0] main;
    assign res = (((main[15] ^ main[14])^ main[12])^ main[3]); 
    always@(posedge clk) begin
        if(rst || main == 16'd0) main <= seed;
        else main <= {res, main[15:1]};
    end
    
endmodule
