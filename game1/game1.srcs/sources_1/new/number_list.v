`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2025 19:07:23
// Design Name: 
// Module Name: number_list
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

module number_list(
    input wire clk,
    input wire [4:0] y_cor,
    input wire [15:0] counter_data,
    output reg [31:0] digit1_cor,
    output reg [31:0] digit2_cor,
    output reg [31:0] digit3_cor,
    output reg [31:0] digit4_cor
    );

// Separate wires for each digit BRAM output
wire [31:0] dout0, dout1, dout2, dout3, dout4;
wire [31:0] dout5, dout6, dout7, dout8, dout9;

// BRAM instances for digits 0-9
blk_mem_gen_4 cord_0 (.clka(clk), .ena(1'b1), .addra(y_cor), .douta(dout0));
blk_mem_gen_5 cord_1 (.clka(clk), .ena(1'b1), .addra(y_cor), .douta(dout1));
blk_mem_gen_6 cord_2 (.clka(clk), .ena(1'b1), .addra(y_cor), .douta(dout2));
blk_mem_gen_7 cord_3 (.clka(clk), .ena(1'b1), .addra(y_cor), .douta(dout3));
blk_mem_gen_8 cord_4 (.clka(clk), .ena(1'b1), .addra(y_cor), .douta(dout4));
blk_mem_gen_9 cord_5 (.clka(clk), .ena(1'b1), .addra(y_cor), .douta(dout5));
blk_mem_gen_10 cord_6 (.clka(clk), .ena(1'b1), .addra(y_cor), .douta(dout6));
blk_mem_gen_11 cord_7 (.clka(clk), .ena(1'b1), .addra(y_cor), .douta(dout7));
blk_mem_gen_12 cord_8 (.clka(clk), .ena(1'b1), .addra(y_cor), .douta(dout8));
blk_mem_gen_13 cord_9 (.clka(clk), .ena(1'b1), .addra(y_cor), .douta(dout9));

// Mux logic using always block (can also be done with functions)
always @(*) begin
    case (counter_data[15:12])
        4'd0: digit1_cor = dout0;
        4'd1: digit1_cor = dout1;
        4'd2: digit1_cor = dout2;
        4'd3: digit1_cor = dout3;
        4'd4: digit1_cor = dout4;
        4'd5: digit1_cor = dout5;
        4'd6: digit1_cor = dout6;
        4'd7: digit1_cor = dout7;
        4'd8: digit1_cor = dout8;
        4'd9: digit1_cor = dout9;
        default: digit1_cor = 32'h00000000;
    endcase

    case (counter_data[11:8])
        4'd0: digit2_cor = dout0;
        4'd1: digit2_cor = dout1;
        4'd2: digit2_cor = dout2;
        4'd3: digit2_cor = dout3;
        4'd4: digit2_cor = dout4;
        4'd5: digit2_cor = dout5;
        4'd6: digit2_cor = dout6;
        4'd7: digit2_cor = dout7;
        4'd8: digit2_cor = dout8;
        4'd9: digit2_cor = dout9;
        default: digit2_cor = 32'h00000000;
    endcase

    case (counter_data[7:4])
        4'd0: digit3_cor = dout0;
        4'd1: digit3_cor = dout1;
        4'd2: digit3_cor = dout2;
        4'd3: digit3_cor = dout3;
        4'd4: digit3_cor = dout4;
        4'd5: digit3_cor = dout5;
        4'd6: digit3_cor = dout6;
        4'd7: digit3_cor = dout7;
        4'd8: digit3_cor = dout8;
        4'd9: digit3_cor = dout9;
        default: digit3_cor = 32'h00000000;
    endcase

    case (counter_data[3:0])
        4'd0: digit4_cor = dout0;
        4'd1: digit4_cor = dout1;
        4'd2: digit4_cor = dout2;
        4'd3: digit4_cor = dout3;
        4'd4: digit4_cor = dout4;
        4'd5: digit4_cor = dout5;
        4'd6: digit4_cor = dout6;
        4'd7: digit4_cor = dout7;
        4'd8: digit4_cor = dout8;
        4'd9: digit4_cor = dout9;
        default: digit4_cor = 32'h00000000;
    endcase
end

endmodule

