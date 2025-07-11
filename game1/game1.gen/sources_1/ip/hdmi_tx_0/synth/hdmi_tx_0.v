// (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// (c) Copyright 2022-2025 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: realdigital.org:realdigital:hdmi_tx:1.0
// IP Revision: 2

(* X_CORE_INFO = "hdmi_tx_v1_0,Vivado 2024.2" *)
(* CHECK_LICENSE_TYPE = "hdmi_tx_0,hdmi_tx_v1_0,{}" *)
(* IP_DEFINITION_SOURCE = "package_project" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module hdmi_tx_0 (
  pix_clk,
  pix_clkx5,
  pix_clk_locked,
  rst,
  red,
  green,
  blue,
  hsync,
  vsync,
  vde,
  aux0_din,
  aux1_din,
  aux2_din,
  ade,
  TMDS_CLK_P,
  TMDS_CLK_N,
  TMDS_DATA_P,
  TMDS_DATA_N
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 pix_clk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME pix_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
input wire pix_clk;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 pix_clkx5 CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME pix_clkx5, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *)
input wire pix_clkx5;
input wire pix_clk_locked;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
input wire rst;
input wire [4 : 0] red;
input wire [5 : 0] green;
input wire [4 : 0] blue;
input wire hsync;
input wire vsync;
input wire vde;
input wire [3 : 0] aux0_din;
input wire [3 : 0] aux1_din;
input wire [3 : 0] aux2_din;
input wire ade;
(* X_INTERFACE_INFO = "xilinx.com:interface:hdmi:2.0 hdmi_tx TMDS_CLK_P" *)
(* X_INTERFACE_MODE = "master" *)
output wire TMDS_CLK_P;
(* X_INTERFACE_INFO = "xilinx.com:interface:hdmi:2.0 hdmi_tx TMDS_CLK_N" *)
output wire TMDS_CLK_N;
(* X_INTERFACE_INFO = "xilinx.com:interface:hdmi:2.0 hdmi_tx TMDS_DATA_P" *)
output wire [2 : 0] TMDS_DATA_P;
(* X_INTERFACE_INFO = "xilinx.com:interface:hdmi:2.0 hdmi_tx TMDS_DATA_N" *)
output wire [2 : 0] TMDS_DATA_N;

  hdmi_tx_v1_0 #(
    .MODE("HDMI"),
    .C_RED_WIDTH(5),
    .C_GREEN_WIDTH(6),
    .C_BLUE_WIDTH(5)
  ) inst (
    .pix_clk(pix_clk),
    .pix_clkx5(pix_clkx5),
    .pix_clk_locked(pix_clk_locked),
    .rst(rst),
    .red(red),
    .green(green),
    .blue(blue),
    .hsync(hsync),
    .vsync(vsync),
    .vde(vde),
    .aux0_din(aux0_din),
    .aux1_din(aux1_din),
    .aux2_din(aux2_din),
    .ade(ade),
    .TMDS_CLK_P(TMDS_CLK_P),
    .TMDS_CLK_N(TMDS_CLK_N),
    .TMDS_DATA_P(TMDS_DATA_P),
    .TMDS_DATA_N(TMDS_DATA_N)
  );
endmodule
