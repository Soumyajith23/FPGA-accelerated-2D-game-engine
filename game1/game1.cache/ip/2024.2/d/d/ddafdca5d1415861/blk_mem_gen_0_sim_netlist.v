// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Tue Jun 24 00:03:10 2025
// Host        : SOUMYAJIT running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s50csga324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_9,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_9,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clka,
    ena,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [3:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [15:0]douta;

  wire [3:0]addra;
  wire clka;
  wire [15:0]douta;
  wire ena;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [15:0]NLW_U0_doutb_UNCONNECTED;
  wire [3:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [15:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "4" *) 
  (* C_ADDRB_WIDTH = "4" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.7096 mW" *) 
  (* C_FAMILY = "spartan7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_0.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "16" *) 
  (* C_READ_DEPTH_B = "16" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "16" *) 
  (* C_READ_WIDTH_B = "16" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "16" *) 
  (* C_WRITE_DEPTH_B = "16" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
  (* C_XDEVICEFAMILY = "spartan7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_9 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[15:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[3:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[3:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[15:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2024.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
FPXllyX2NFs/RMngGqZy2bLYbZr92CdofeZrJOHklWXExpaPgHNYp2Lzm4MnflbnrfSkCmLwwKT5
zfRgEip7FKQ5Zhb73p0MAIADixBZ/ZRt4hQkJL0T9brm0waLHfanjnov2aCX6jN3LbQc3ujmDga6
Dd73k78u4xjRTDv1/P4=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kr7VKKvChFoiyRCReag+OvU3jnmG9pN0cv+BxhNmMKLthg/ksgNZyU3L+fQ7cmIQELtlUjwjkBAP
Jjq5RsCnHbJxj+Ys1GNhriiBsxLqxWCP8onhAVvgZN2xZFOih0UWpqlU8NVP8Eww1ohvkDgxTstC
3kDmYehxIUJjqCC/mgRZmuezqugrFdubYmBoz16tUvD17iA5qqCIMS9xSIXYp2LBNekmWEwrVqzu
R4koEo4UlXl/CEw0XY3QvMoHnlXgu6N/6sc+nxZtKSwjiMVvGnZE9UVvJPAC3Hn3zKFGlK53mmGO
Tj0dWzhwX0ahSYzkyJC/HLdbGZmriL2UNvDyFw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
CaLc9FGt3AdRHfNtGAsGFY/QEvHY1Vv4TvvgCDsdDMqiuDeLizFJDJeskBWjeKDoE2cufK8TxiBq
mySRQNJoeOKnxTiDdf+Rx6m0iR6h/YeswegYwgghpM5KVrl6mSwF3+4yEovPM7a+9ArDQ5vl+WT8
SilNGzyW0KnTwe7+szs=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cEnudSW1X71p0Xuq6jrXOxHnBku87IA0RA3zKqmeZHZM0r+9rEm5MSzX8RecnQ994yiqeyxbIH2l
fGEzUzr0ZzryS3fkf2LnJuB39f2YARW9eVCSiaeWaraZuY1l89T+h3vgdlurS/1LIraYLS1MyOXa
6F1LAcQp3W4OO4ctc3q1FRMZGldRS1biMsKwJ8Lxj8NEOm67UfgFrJNQAxbVXEfbWRWhKtwNxcTB
JbgC8j4EHkIA46mzoHloeBAL6KieplQUBjKXSSTb66rxglbFhWLy+mirROHcocu9J4ZbvTRYZEww
4lso1lqAllVLAoKYqa3WImZuSRoTbGDngBt9Lg==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
rOyI+x4PlmKcVSFoN3oKgSYpVlmYxc194Ej04il/YmBg10xopy4zmtu5sdCP/uGSNYcNGWeAiw01
mNf98KyNgTUFXruHCA38qjhhEIvl4vfWWn3W3mFRxrIuwmnreT6qTvgMaxIkCdVBDP7Iy7O6WmCf
3Va5X5hnCHhtXgX5UYniBHiLjmupv63B8XMAYDH2n6mQ3H0DF7mtb7psBafd0Z6+IWUbmzwMtKrf
ZrRJBGAhNT0i1KrEjEh/rWjN7Z7N32zQ+Pl1kc5gYCQIX5McfdTdqSaRVXZ/HF90ymS7/8d5LDyj
Er+ORdcjnOn6oAyY4PuUUl4OYUHv5k+RglTe5Q==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2023_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bJa7kPSpDipzoJoQu1APEjc8vFLqBfQZK/grZvWijD7/FgMTerFCWLUY6n8DWeGdvjXvTeyrqCHE
2rP/H57wUqPC8tIJlGm6ZYQGjZ3TgYqLrJshDE5zYMTO//q0vuSraWvZP7A7SLuW6y7tFE/nplpx
L8gbYORx6j70okGUwnamCMS9yhFr7Z2QTJne1k4GNFGvy66URk3k5cBPl5j4/1yc4xGV+aWYl6L8
q8RorRU/CltObHKrji/jdiY1WtdGrkpRyCEFc+XNPazL9xSLLu5bz6XlvKwoks+8a5KYT/VFUovM
JbM0bpAXM8Z7rGaPuXjqXtZBg5praTZLu/WNcA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PYKBDinOGc/kIVdFzXrz2wA4/QNFxLDrQfTWfR5TjYE6bm49vrZi0bawcr9HXp4OP1+XxPLB3oCP
oV5e/rYeDln531ebt8yEg27XCoSHEX4FU8oG8aBJ8fqgWayOnAMJt025WodOxuZXbhT1zPo7J3uh
6iO9Mv7RtYE2fZ1W+G8oN//FTOEJYPWlKYnt0cDeZrN3I4rHHptZHuu7l8T+df0PYea3x6U3Mvkl
ojZ+TwQtdu0NuYY5j3QNgx3+W2XYq1M773FAnEz/deW54EjE+jf1jjrBk2pl8SYxeKuutS15oPVF
eHdqXYVcJxoUY5JH8z04lITKEnZ4oq6sYS6dog==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
tl+2vFCWZ583gQGsVC7oopz2NCKBiJ9uOHYBGzJZheOHJMqI/ehNvo25l710eBx00tztXzM30AH6
ZhAJg+kJwE2jO0MV5fmG5dnwXmLqoGEJMBs7xwWxvYK7w/0z9M0AJKD7HnuC+IiLhNU/fIxyuE+I
+vWqp//RcfY0tMMp2I2J1yEW6GUahS1ve/4JchssZ7Xu7VthoSDWXMQWATbvsUsDzeSo2+Ruz8Kq
Dc05HqEU8NgBxDPPEKLCcdKLp4byglwj7iCAtCjsPy8P18qjgb2sycFjNgmaiNMMB51WqeD+hneG
hLOue9bqVdEojkrb3q4WbsGZKz0bAGsryxslOlYHP1b8vey3yI2ixA80wyERe8d3GRIeZiSxGykH
qWxsE6x/iyi8QRb5mXZPMApA+Fln8tYmn7+1rFCm8gF4gJWhr1PsSJqTi658symGrzT0Ghjvf2QL
SvvoaeNdy0pOsWs7jLBFndd4GiFA+9K6Y33sziLToU9EvvFokENIslod

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
oYiCujFRj1F3wKsGZlHR9niEtR9MLXEVAVfy+f/3xrmpW6Ye5a+fBCvm4TH+iRQefGHNdMPnzTNW
K/pEPAS9uMJjOdFiu+APT+LYrSRnEg4W0dX5buSDGM6LBWAuMseoTMjbJJoYDGLRckJgW43E30mX
ej4823nkbfwc+Ecbrup825qLyv8RTQLNHafvJA5lSapdqXwnlOIYRmcHn+sfAh5pGv9kW9aokcdh
ObR2XYxX99rYloyvz3x0pmjxD5ILW4SQMB1IUEuuyqX6eb5IQ+kZ41hjvsHIuQH29vzpCfV9Jqha
WC5yxxK1R+cleZSKD1H1gVzbTei8uFs/91Bgeg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
urNc+S8AFPj+GVFdqJE5V7P8O6QI6MA3nkwYb8NKbYbVufnXKg6voJIRYYeYr7EOa8mrqirozWbY
Lln9SLWnkaAy2LvL/N6WahoQdCt++4RH+xe768XvSrVUFPrIwZRixqMLurc/tPov4i5P/ukZKl18
ZPZvXRzUNlvCZnMPcF+5QCQihqPbjcZ0YyGgWgX/ipTGG3sNqmylGN7qLa4Rgqu/mB5a2xVyu5Wc
911+/X3VVFx697WVaP5V0SbOzYN8R8+8B8kdznwixMA+f4lSbBXyRysVOSzYjo8bKEMqyKMVBQn9
xDmEuV0DvVWXdO7VPvWA1LuJFwS07OxeI2GCcQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QcP7fsLZxaDrG29e9HQeXfu2TsKsdyW7Yc1vWct6lbmDEfXkWMU1fFWSPIjPzRc9UOnfEu0bRn+B
D+8MWokqes3WF7txljBmgUPiNGZ8arUU6ENa/IY/Wv7iaB/ZKM5PtdnFAkjDIrYyKFCTz/U6Yzwi
hBGGarK/wYQOLzeeKRewiPTiNUL7tztWuMZ1t1msxD951EeKrwjrjcXIIuf/TzrOGUOlWgjHlnrl
4Q/lfMAnRLBNTSWG+5wWewCE8jK2X/gJ5AV4p3x1WP3+JglbxpP39l3pzedXqciZPbuz2XlFnRPV
KByaUaAShzJ56p8+0HjWebibqQdieGNPiPWW0Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19616)
`pragma protect data_block
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
nzq8ZFxKIMw=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
