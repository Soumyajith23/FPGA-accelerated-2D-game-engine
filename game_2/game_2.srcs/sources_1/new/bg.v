`timescale 1ns / 1ps

module bg(
   input clk,
   input rst,
   input wire [9:0] x_pix,
   input wire [9:0] y_pix,
   input wire btn_trigger,
   output wire [15:0] rgb_out
    );
    
    reg[18:0] bias;
    always@(posedge clk)begin
        if(rst) bias <= 18'd0;
        else if(y_pix == 10'd485) bias <= bias + 18'd1;
        else bias <= bias;
    end
    
    wire [15:0] p_cord ;
    wire [3:0] col_cord;
    wire [15:0] rgb_in;
    wire [9:0] x_pix_;
    assign x_pix_ = x_pix + (bias>>10)-1;
    assign p_cord = x_pix_[7] ? {y_pix[8:0],~x_pix_[6:0]} : {y_pix[8:0],x_pix_[6:0]};
    assign rgb_out = rgb_in;
    
    
blk_mem_gen_5 rgb_value (
  .clka(clk),    // input wire clka
  .ena(1),      // input wire ena
  .addra(col_cord),  // input wire [3 : 0] addra
  .douta(rgb_in)  // output wire [15 : 0] douta
);    

blk_mem_gen_6 rgb_cord ( 
  .clka(clk ),    // input wire clka
  .ena(1),      // input wire ena
  .addra(p_cord),  // input wire [15 : 0] addra
  .douta(col_cord)  // output wire [3 : 0] douta
);
    
endmodule