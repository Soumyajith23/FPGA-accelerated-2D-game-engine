`timescale 1ns / 1ps

module VGA(
    input pxl_clk,
    input rst,
    output reg[9:0] hcnt,
    output reg[9:0] vcnt,
    output reg ven,
    output reg hsync,
    output reg vsync 
     
    );
    
    always@(posedge pxl_clk) begin
    if(rst) begin
        hcnt <= 10'd0;
        vcnt <= 10'd0;
        ven <= 1'b1;
        hsync <= 1'b1;
        vsync <= 1'b1;
    end
    else begin
        if(hcnt == 10'd0 || hcnt == 10'd800) begin
            ven <= (vcnt<=10'd479) ? 1'b1: 1'b0;
            
        end
        else if(ven && hcnt == 10'd640) ven <= 1'b0;

        if(hcnt == 10'd0 || hcnt == 10'd800)begin
            hcnt <= 10'd1;
            if (vcnt == 10'd525) begin 
                vcnt <= 10'd1;
     
            end
            else vcnt <= vcnt +1'b1;
         end
        else begin 
            hcnt <= hcnt + 1'b1;
            
        end
 
        if(hcnt >= 10'd656 && hcnt <= 10'd752) hsync <= 1'b0;
        else hsync <= 1'b1;
        
        if(vcnt >= 10'd491 && vcnt <= 10'd492) vsync <= 1'b0;
        else vsync <= 1'b1;
        
    end
    end
endmodule
