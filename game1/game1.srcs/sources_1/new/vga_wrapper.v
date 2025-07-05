`timescale 1ns / 1ps

module vga_wrapper(
	input clk,
	input rst,
	input pause,
	output hdmi_clk_n,
	output hdmi_clk_p,
	output [2:0] hdmi_tx_n,
	output [2:0] hdmi_tx_p,
	input btn_left,
    input btn_right,
    input btn_jump
);

	wire clk_25MHz, clk_125MHz; 
	wire locked;
	wire hsync, vsync, vde;
	//wire [7:0] red, green, blue;
	wire [9:0] x_pix, y_pix;
	wire [15:0] rgb_out;

	//clock wizard configured with a 1x and 5x clock
	clk_wiz_0 clk_wiz (
		.clk_out1(clk_25MHz),
		.clk_out2(clk_125MHz),
		.reset(rst),
		.locked(locked),
		.clk_in1(clk)
	);
	
	rgb_val rgb1(
	    .clk(clk_25MHz),
	    .sclk(clk),
	    .rst(rst),
	    .pause(pause),
	    .x_pix(x_pix),
	    .y_pix(y_pix),
	    .rgb_out(rgb_out),
	    .btn_left(btn_left),
	    .btn_right(btn_right),
	    .btn_jump(btn_jump)
	    );
	    


	//VGA Sync signal generator
	vga1 vga (
		.pxl_clk(clk_25MHz),
		.rst(rst),
		.hsync(hsync),
		.vsync(vsync),
		.ven(vde),
		.hcnt(x_pix),
		.vcnt(y_pix)
	);


	//Real Digital VGA to HDMI converter
	hdmi_tx_0 vga_to_hdmi (
		//Clocking and Reset
		.pix_clk(clk_25MHz),
		.pix_clkx5(clk_125MHz),
		.pix_clk_locked(locked),
		//Reset is active HIGH
		.rst(rst),

		//Color and Sync Signals
		.red(rgb_out[15:11]),
		.green(rgb_out[10:5]),
		.blue(rgb_out[4:0]),
		.hsync(hsync),
		.vsync(vsync),
		.vde(vde),

		//aux Data (unused)
		.aux0_din(4'b0),
		.aux1_din(4'b0),
		.aux2_din(4'b0),
		.ade(1'b0),

		//Differential outputs
		.TMDS_CLK_P(hdmi_clk_p),          
		.TMDS_CLK_N(hdmi_clk_n),          
		.TMDS_DATA_P(hdmi_tx_p),         
		.TMDS_DATA_N(hdmi_tx_n)          
	);

endmodule