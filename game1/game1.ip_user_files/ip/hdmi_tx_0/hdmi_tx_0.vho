-- (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- (c) Copyright 2022-2025 Advanced Micro Devices, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of AMD and is protected under U.S. and international copyright
-- and other intellectual property laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- AMD, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) AMD shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or AMD had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- AMD products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of AMD products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.
-- IP VLNV: realdigital.org:realdigital:hdmi_tx:1.0
-- IP Revision: 2

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT hdmi_tx_0
  PORT (
    pix_clk : IN STD_LOGIC;
    pix_clkx5 : IN STD_LOGIC;
    pix_clk_locked : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    red : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    green : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    blue : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    hsync : IN STD_LOGIC;
    vsync : IN STD_LOGIC;
    vde : IN STD_LOGIC;
    aux0_din : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    aux1_din : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    aux2_din : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    ade : IN STD_LOGIC;
    TMDS_CLK_P : OUT STD_LOGIC;
    TMDS_CLK_N : OUT STD_LOGIC;
    TMDS_DATA_P : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    TMDS_DATA_N : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) 
  );
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : hdmi_tx_0
  PORT MAP (
    pix_clk => pix_clk,
    pix_clkx5 => pix_clkx5,
    pix_clk_locked => pix_clk_locked,
    rst => rst,
    red => red,
    green => green,
    blue => blue,
    hsync => hsync,
    vsync => vsync,
    vde => vde,
    aux0_din => aux0_din,
    aux1_din => aux1_din,
    aux2_din => aux2_din,
    ade => ade,
    TMDS_CLK_P => TMDS_CLK_P,
    TMDS_CLK_N => TMDS_CLK_N,
    TMDS_DATA_P => TMDS_DATA_P,
    TMDS_DATA_N => TMDS_DATA_N
  );
-- INST_TAG_END ------ End INSTANTIATION Template ---------

-- You must compile the wrapper file hdmi_tx_0.vhd when simulating
-- the core, hdmi_tx_0. When compiling the wrapper file, be sure to
-- reference the VHDL simulation library.



