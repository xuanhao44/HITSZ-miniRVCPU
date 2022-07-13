// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sat Jul  9 17:33:17 2022
// Host        : LG running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               F:/OneDrive/Codefield/fgpa/onBoard2/onBoard2.srcs/sources_1/ip/prgrom/prgrom_sim_netlist.v
// Design      : prgrom
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tfgg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "prgrom,dist_mem_gen_v8_0_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_12,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module prgrom
   (a,
    spo);
  input [13:0]a;
  output [31:0]spo;

  wire [13:0]a;
  wire [31:0]spo;
  wire [31:0]NLW_U0_dpo_UNCONNECTED;
  wire [31:0]NLW_U0_qdpo_UNCONNECTED;
  wire [31:0]NLW_U0_qspo_UNCONNECTED;

  (* C_FAMILY = "artix7" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_DPO = "0" *) 
  (* C_HAS_DPRA = "0" *) 
  (* C_HAS_I_CE = "0" *) 
  (* C_HAS_QDPO = "0" *) 
  (* C_HAS_QDPO_CE = "0" *) 
  (* C_HAS_QDPO_CLK = "0" *) 
  (* C_HAS_QDPO_RST = "0" *) 
  (* C_HAS_QDPO_SRST = "0" *) 
  (* C_HAS_WE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_PIPELINE_STAGES = "0" *) 
  (* C_QCE_JOINED = "0" *) 
  (* C_QUALIFY_WE = "0" *) 
  (* C_REG_DPRA_INPUT = "0" *) 
  (* c_addr_width = "14" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "16384" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_clk = "0" *) 
  (* c_has_qspo = "0" *) 
  (* c_has_qspo_ce = "0" *) 
  (* c_has_qspo_rst = "0" *) 
  (* c_has_qspo_srst = "0" *) 
  (* c_has_spo = "1" *) 
  (* c_mem_init_file = "prgrom.mif" *) 
  (* c_parser_type = "1" *) 
  (* c_read_mif = "1" *) 
  (* c_reg_a_d_inputs = "0" *) 
  (* c_sync_enable = "1" *) 
  (* c_width = "32" *) 
  prgrom_dist_mem_gen_v8_0_12 U0
       (.a(a),
        .clk(1'b0),
        .d({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dpo(NLW_U0_dpo_UNCONNECTED[31:0]),
        .dpra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .i_ce(1'b1),
        .qdpo(NLW_U0_qdpo_UNCONNECTED[31:0]),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(NLW_U0_qspo_UNCONNECTED[31:0]),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo(spo),
        .we(1'b0));
endmodule

(* C_ADDR_WIDTH = "14" *) (* C_DEFAULT_DATA = "0" *) (* C_DEPTH = "16384" *) 
(* C_ELABORATION_DIR = "./" *) (* C_FAMILY = "artix7" *) (* C_HAS_CLK = "0" *) 
(* C_HAS_D = "0" *) (* C_HAS_DPO = "0" *) (* C_HAS_DPRA = "0" *) 
(* C_HAS_I_CE = "0" *) (* C_HAS_QDPO = "0" *) (* C_HAS_QDPO_CE = "0" *) 
(* C_HAS_QDPO_CLK = "0" *) (* C_HAS_QDPO_RST = "0" *) (* C_HAS_QDPO_SRST = "0" *) 
(* C_HAS_QSPO = "0" *) (* C_HAS_QSPO_CE = "0" *) (* C_HAS_QSPO_RST = "0" *) 
(* C_HAS_QSPO_SRST = "0" *) (* C_HAS_SPO = "1" *) (* C_HAS_WE = "0" *) 
(* C_MEM_INIT_FILE = "prgrom.mif" *) (* C_MEM_TYPE = "0" *) (* C_PARSER_TYPE = "1" *) 
(* C_PIPELINE_STAGES = "0" *) (* C_QCE_JOINED = "0" *) (* C_QUALIFY_WE = "0" *) 
(* C_READ_MIF = "1" *) (* C_REG_A_D_INPUTS = "0" *) (* C_REG_DPRA_INPUT = "0" *) 
(* C_SYNC_ENABLE = "1" *) (* C_WIDTH = "32" *) (* ORIG_REF_NAME = "dist_mem_gen_v8_0_12" *) 
module prgrom_dist_mem_gen_v8_0_12
   (a,
    d,
    dpra,
    clk,
    we,
    i_ce,
    qspo_ce,
    qdpo_ce,
    qdpo_clk,
    qspo_rst,
    qdpo_rst,
    qspo_srst,
    qdpo_srst,
    spo,
    dpo,
    qspo,
    qdpo);
  input [13:0]a;
  input [31:0]d;
  input [13:0]dpra;
  input clk;
  input we;
  input i_ce;
  input qspo_ce;
  input qdpo_ce;
  input qdpo_clk;
  input qspo_rst;
  input qdpo_rst;
  input qspo_srst;
  input qdpo_srst;
  output [31:0]spo;
  output [31:0]dpo;
  output [31:0]qspo;
  output [31:0]qdpo;

  wire \<const0> ;
  wire [13:0]a;
  wire [31:1]\^spo ;

  assign dpo[31] = \<const0> ;
  assign dpo[30] = \<const0> ;
  assign dpo[29] = \<const0> ;
  assign dpo[28] = \<const0> ;
  assign dpo[27] = \<const0> ;
  assign dpo[26] = \<const0> ;
  assign dpo[25] = \<const0> ;
  assign dpo[24] = \<const0> ;
  assign dpo[23] = \<const0> ;
  assign dpo[22] = \<const0> ;
  assign dpo[21] = \<const0> ;
  assign dpo[20] = \<const0> ;
  assign dpo[19] = \<const0> ;
  assign dpo[18] = \<const0> ;
  assign dpo[17] = \<const0> ;
  assign dpo[16] = \<const0> ;
  assign dpo[15] = \<const0> ;
  assign dpo[14] = \<const0> ;
  assign dpo[13] = \<const0> ;
  assign dpo[12] = \<const0> ;
  assign dpo[11] = \<const0> ;
  assign dpo[10] = \<const0> ;
  assign dpo[9] = \<const0> ;
  assign dpo[8] = \<const0> ;
  assign dpo[7] = \<const0> ;
  assign dpo[6] = \<const0> ;
  assign dpo[5] = \<const0> ;
  assign dpo[4] = \<const0> ;
  assign dpo[3] = \<const0> ;
  assign dpo[2] = \<const0> ;
  assign dpo[1] = \<const0> ;
  assign dpo[0] = \<const0> ;
  assign qdpo[31] = \<const0> ;
  assign qdpo[30] = \<const0> ;
  assign qdpo[29] = \<const0> ;
  assign qdpo[28] = \<const0> ;
  assign qdpo[27] = \<const0> ;
  assign qdpo[26] = \<const0> ;
  assign qdpo[25] = \<const0> ;
  assign qdpo[24] = \<const0> ;
  assign qdpo[23] = \<const0> ;
  assign qdpo[22] = \<const0> ;
  assign qdpo[21] = \<const0> ;
  assign qdpo[20] = \<const0> ;
  assign qdpo[19] = \<const0> ;
  assign qdpo[18] = \<const0> ;
  assign qdpo[17] = \<const0> ;
  assign qdpo[16] = \<const0> ;
  assign qdpo[15] = \<const0> ;
  assign qdpo[14] = \<const0> ;
  assign qdpo[13] = \<const0> ;
  assign qdpo[12] = \<const0> ;
  assign qdpo[11] = \<const0> ;
  assign qdpo[10] = \<const0> ;
  assign qdpo[9] = \<const0> ;
  assign qdpo[8] = \<const0> ;
  assign qdpo[7] = \<const0> ;
  assign qdpo[6] = \<const0> ;
  assign qdpo[5] = \<const0> ;
  assign qdpo[4] = \<const0> ;
  assign qdpo[3] = \<const0> ;
  assign qdpo[2] = \<const0> ;
  assign qdpo[1] = \<const0> ;
  assign qdpo[0] = \<const0> ;
  assign qspo[31] = \<const0> ;
  assign qspo[30] = \<const0> ;
  assign qspo[29] = \<const0> ;
  assign qspo[28] = \<const0> ;
  assign qspo[27] = \<const0> ;
  assign qspo[26] = \<const0> ;
  assign qspo[25] = \<const0> ;
  assign qspo[24] = \<const0> ;
  assign qspo[23] = \<const0> ;
  assign qspo[22] = \<const0> ;
  assign qspo[21] = \<const0> ;
  assign qspo[20] = \<const0> ;
  assign qspo[19] = \<const0> ;
  assign qspo[18] = \<const0> ;
  assign qspo[17] = \<const0> ;
  assign qspo[16] = \<const0> ;
  assign qspo[15] = \<const0> ;
  assign qspo[14] = \<const0> ;
  assign qspo[13] = \<const0> ;
  assign qspo[12] = \<const0> ;
  assign qspo[11] = \<const0> ;
  assign qspo[10] = \<const0> ;
  assign qspo[9] = \<const0> ;
  assign qspo[8] = \<const0> ;
  assign qspo[7] = \<const0> ;
  assign qspo[6] = \<const0> ;
  assign qspo[5] = \<const0> ;
  assign qspo[4] = \<const0> ;
  assign qspo[3] = \<const0> ;
  assign qspo[2] = \<const0> ;
  assign qspo[1] = \<const0> ;
  assign qspo[0] = \<const0> ;
  assign spo[31:30] = \^spo [31:30];
  assign spo[29] = \^spo [31];
  assign spo[28] = \^spo [31];
  assign spo[27:1] = \^spo [27:1];
  assign spo[0] = \^spo [1];
  GND GND
       (.G(\<const0> ));
  prgrom_dist_mem_gen_v8_0_12_synth \synth_options.dist_mem_inst 
       (.a(a),
        .spo({\^spo [31:30],\^spo [27:1]}));
endmodule

(* ORIG_REF_NAME = "dist_mem_gen_v8_0_12_synth" *) 
module prgrom_dist_mem_gen_v8_0_12_synth
   (spo,
    a);
  output [28:0]spo;
  input [13:0]a;

  wire [13:0]a;
  wire [28:0]spo;

  prgrom_rom \gen_rom.rom_inst 
       (.a(a),
        .spo(spo));
endmodule

(* ORIG_REF_NAME = "rom" *) 
module prgrom_rom
   (spo,
    a);
  output [28:0]spo;
  input [13:0]a;

  wire [13:0]a;
  wire [28:0]spo;
  wire \spo[0]_INST_0_i_1_n_0 ;
  wire \spo[10]_INST_0_i_1_n_0 ;
  wire \spo[10]_INST_0_i_2_n_0 ;
  wire \spo[11]_INST_0_i_1_n_0 ;
  wire \spo[11]_INST_0_i_2_n_0 ;
  wire \spo[12]_INST_0_i_1_n_0 ;
  wire \spo[12]_INST_0_i_2_n_0 ;
  wire \spo[13]_INST_0_i_1_n_0 ;
  wire \spo[13]_INST_0_i_2_n_0 ;
  wire \spo[13]_INST_0_i_3_n_0 ;
  wire \spo[14]_INST_0_i_1_n_0 ;
  wire \spo[14]_INST_0_i_2_n_0 ;
  wire \spo[15]_INST_0_i_1_n_0 ;
  wire \spo[15]_INST_0_i_2_n_0 ;
  wire \spo[16]_INST_0_i_1_n_0 ;
  wire \spo[16]_INST_0_i_2_n_0 ;
  wire \spo[17]_INST_0_i_1_n_0 ;
  wire \spo[17]_INST_0_i_2_n_0 ;
  wire \spo[18]_INST_0_i_1_n_0 ;
  wire \spo[18]_INST_0_i_2_n_0 ;
  wire \spo[19]_INST_0_i_1_n_0 ;
  wire \spo[19]_INST_0_i_2_n_0 ;
  wire \spo[20]_INST_0_i_1_n_0 ;
  wire \spo[20]_INST_0_i_2_n_0 ;
  wire \spo[21]_INST_0_i_1_n_0 ;
  wire \spo[21]_INST_0_i_2_n_0 ;
  wire \spo[22]_INST_0_i_1_n_0 ;
  wire \spo[22]_INST_0_i_2_n_0 ;
  wire \spo[22]_INST_0_i_3_n_0 ;
  wire \spo[22]_INST_0_i_4_n_0 ;
  wire \spo[22]_INST_0_i_5_n_0 ;
  wire \spo[23]_INST_0_i_1_n_0 ;
  wire \spo[23]_INST_0_i_2_n_0 ;
  wire \spo[24]_INST_0_i_1_n_0 ;
  wire \spo[24]_INST_0_i_2_n_0 ;
  wire \spo[24]_INST_0_i_3_n_0 ;
  wire \spo[25]_INST_0_i_1_n_0 ;
  wire \spo[25]_INST_0_i_2_n_0 ;
  wire \spo[26]_INST_0_i_1_n_0 ;
  wire \spo[26]_INST_0_i_2_n_0 ;
  wire \spo[27]_INST_0_i_1_n_0 ;
  wire \spo[27]_INST_0_i_2_n_0 ;
  wire \spo[28]_INST_0_i_1_n_0 ;
  wire \spo[28]_INST_0_i_2_n_0 ;
  wire \spo[28]_INST_0_i_3_n_0 ;
  wire \spo[2]_INST_0_i_1_n_0 ;
  wire \spo[30]_INST_0_i_1_n_0 ;
  wire \spo[30]_INST_0_i_2_n_0 ;
  wire \spo[30]_INST_0_i_3_n_0 ;
  wire \spo[30]_INST_0_i_4_n_0 ;
  wire \spo[3]_INST_0_i_1_n_0 ;
  wire \spo[3]_INST_0_i_2_n_0 ;
  wire \spo[3]_INST_0_i_3_n_0 ;
  wire \spo[3]_INST_0_i_4_n_0 ;
  wire \spo[3]_INST_0_i_5_n_0 ;
  wire \spo[4]_INST_0_i_1_n_0 ;
  wire \spo[4]_INST_0_i_2_n_0 ;
  wire \spo[4]_INST_0_i_3_n_0 ;
  wire \spo[4]_INST_0_i_4_n_0 ;
  wire \spo[4]_INST_0_i_5_n_0 ;
  wire \spo[4]_INST_0_i_6_n_0 ;
  wire \spo[5]_INST_0_i_1_n_0 ;
  wire \spo[5]_INST_0_i_2_n_0 ;
  wire \spo[6]_INST_0_i_1_n_0 ;
  wire \spo[6]_INST_0_i_2_n_0 ;
  wire \spo[7]_INST_0_i_1_n_0 ;
  wire \spo[8]_INST_0_i_1_n_0 ;
  wire \spo[9]_INST_0_i_1_n_0 ;
  wire \spo[9]_INST_0_i_2_n_0 ;

  LUT6 #(
    .INIT(64'h0008008800080008)) 
    \spo[0]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[28]_INST_0_i_3_n_0 ),
        .I2(a[6]),
        .I3(a[9]),
        .I4(a[5]),
        .I5(\spo[0]_INST_0_i_1_n_0 ),
        .O(spo[0]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h0507050F)) 
    \spo[0]_INST_0_i_1 
       (.I0(a[3]),
        .I1(a[1]),
        .I2(a[4]),
        .I3(a[2]),
        .I4(a[0]),
        .O(\spo[0]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0088008000080000)) 
    \spo[10]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[30]_INST_0_i_2_n_0 ),
        .I2(a[6]),
        .I3(a[7]),
        .I4(\spo[10]_INST_0_i_1_n_0 ),
        .I5(\spo[10]_INST_0_i_2_n_0 ),
        .O(spo[9]));
  LUT6 #(
    .INIT(64'h2DDF851B874A410F)) 
    \spo[10]_INST_0_i_1 
       (.I0(a[5]),
        .I1(a[0]),
        .I2(a[1]),
        .I3(a[4]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[10]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000000000000505D)) 
    \spo[10]_INST_0_i_2 
       (.I0(a[3]),
        .I1(a[0]),
        .I2(a[2]),
        .I3(a[1]),
        .I4(a[5]),
        .I5(a[4]),
        .O(\spo[10]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAAA200020002000)) 
    \spo[11]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(a[7]),
        .I2(\spo[30]_INST_0_i_2_n_0 ),
        .I3(\spo[11]_INST_0_i_1_n_0 ),
        .I4(\spo[24]_INST_0_i_2_n_0 ),
        .I5(\spo[11]_INST_0_i_2_n_0 ),
        .O(spo[10]));
  LUT6 #(
    .INIT(64'h0000000000002000)) 
    \spo[11]_INST_0_i_1 
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[5]),
        .I5(a[4]),
        .O(\spo[11]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0004A0B220A0226C)) 
    \spo[11]_INST_0_i_2 
       (.I0(a[0]),
        .I1(a[3]),
        .I2(a[1]),
        .I3(a[2]),
        .I4(a[5]),
        .I5(a[4]),
        .O(\spo[11]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAAA200020002000)) 
    \spo[12]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(a[7]),
        .I2(\spo[30]_INST_0_i_2_n_0 ),
        .I3(\spo[12]_INST_0_i_1_n_0 ),
        .I4(\spo[24]_INST_0_i_2_n_0 ),
        .I5(\spo[12]_INST_0_i_2_n_0 ),
        .O(spo[11]));
  LUT6 #(
    .INIT(64'h0001010201010203)) 
    \spo[12]_INST_0_i_1 
       (.I0(a[3]),
        .I1(a[4]),
        .I2(a[5]),
        .I3(a[1]),
        .I4(a[2]),
        .I5(a[0]),
        .O(\spo[12]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h74BAF08273F10082)) 
    \spo[12]_INST_0_i_2 
       (.I0(a[2]),
        .I1(a[1]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[5]),
        .I5(a[4]),
        .O(\spo[12]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00010000)) 
    \spo[13]_INST_0 
       (.I0(a[12]),
        .I1(a[13]),
        .I2(a[10]),
        .I3(a[11]),
        .I4(\spo[13]_INST_0_i_1_n_0 ),
        .O(spo[12]));
  LUT6 #(
    .INIT(64'h00000000000000F2)) 
    \spo[13]_INST_0_i_1 
       (.I0(\spo[13]_INST_0_i_2_n_0 ),
        .I1(a[2]),
        .I2(\spo[13]_INST_0_i_3_n_0 ),
        .I3(a[9]),
        .I4(a[8]),
        .I5(a[7]),
        .O(\spo[13]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0006080401072325)) 
    \spo[13]_INST_0_i_2 
       (.I0(a[3]),
        .I1(a[5]),
        .I2(a[6]),
        .I3(a[1]),
        .I4(a[0]),
        .I5(a[4]),
        .O(\spo[13]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h000000020208040E)) 
    \spo[13]_INST_0_i_3 
       (.I0(a[0]),
        .I1(a[5]),
        .I2(a[6]),
        .I3(a[4]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[13]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAA200020002000)) 
    \spo[14]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(a[7]),
        .I2(\spo[30]_INST_0_i_2_n_0 ),
        .I3(\spo[14]_INST_0_i_1_n_0 ),
        .I4(\spo[24]_INST_0_i_2_n_0 ),
        .I5(\spo[14]_INST_0_i_2_n_0 ),
        .O(spo[13]));
  LUT6 #(
    .INIT(64'h0000011001100100)) 
    \spo[14]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[1]),
        .I5(a[0]),
        .O(\spo[14]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00037C4C4040088F)) 
    \spo[14]_INST_0_i_2 
       (.I0(a[2]),
        .I1(a[5]),
        .I2(a[4]),
        .I3(a[3]),
        .I4(a[1]),
        .I5(a[0]),
        .O(\spo[14]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0088008000080000)) 
    \spo[15]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[30]_INST_0_i_2_n_0 ),
        .I2(a[6]),
        .I3(a[7]),
        .I4(\spo[15]_INST_0_i_1_n_0 ),
        .I5(\spo[15]_INST_0_i_2_n_0 ),
        .O(spo[14]));
  LUT6 #(
    .INIT(64'h0880800900100019)) 
    \spo[15]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[1]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[0]),
        .O(\spo[15]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000000000000020D)) 
    \spo[15]_INST_0_i_2 
       (.I0(a[1]),
        .I1(a[3]),
        .I2(a[2]),
        .I3(a[0]),
        .I4(a[5]),
        .I5(a[4]),
        .O(\spo[15]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0088008000080000)) 
    \spo[16]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[30]_INST_0_i_2_n_0 ),
        .I2(a[4]),
        .I3(a[7]),
        .I4(\spo[16]_INST_0_i_1_n_0 ),
        .I5(\spo[16]_INST_0_i_2_n_0 ),
        .O(spo[15]));
  LUT6 #(
    .INIT(64'h01011001011C000D)) 
    \spo[16]_INST_0_i_1 
       (.I0(a[2]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[6]),
        .O(\spo[16]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h004400C400C60042)) 
    \spo[16]_INST_0_i_2 
       (.I0(a[3]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[6]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[16]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0088008000080000)) 
    \spo[17]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[30]_INST_0_i_2_n_0 ),
        .I2(a[4]),
        .I3(a[7]),
        .I4(\spo[17]_INST_0_i_1_n_0 ),
        .I5(\spo[17]_INST_0_i_2_n_0 ),
        .O(spo[16]));
  LUT6 #(
    .INIT(64'h10120003C0C00003)) 
    \spo[17]_INST_0_i_1 
       (.I0(a[3]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[6]),
        .O(\spo[17]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0444440014401410)) 
    \spo[17]_INST_0_i_2 
       (.I0(a[6]),
        .I1(a[0]),
        .I2(a[2]),
        .I3(a[5]),
        .I4(a[1]),
        .I5(a[3]),
        .O(\spo[17]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0088008000080000)) 
    \spo[18]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[30]_INST_0_i_2_n_0 ),
        .I2(a[5]),
        .I3(a[7]),
        .I4(\spo[18]_INST_0_i_1_n_0 ),
        .I5(\spo[18]_INST_0_i_2_n_0 ),
        .O(spo[17]));
  LUT6 #(
    .INIT(64'h0501252D05090509)) 
    \spo[18]_INST_0_i_1 
       (.I0(a[3]),
        .I1(a[6]),
        .I2(a[4]),
        .I3(a[2]),
        .I4(a[1]),
        .I5(a[0]),
        .O(\spo[18]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0003200003032100)) 
    \spo[18]_INST_0_i_2 
       (.I0(a[3]),
        .I1(a[6]),
        .I2(a[1]),
        .I3(a[4]),
        .I4(a[0]),
        .I5(a[2]),
        .O(\spo[18]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0088008000080000)) 
    \spo[19]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[30]_INST_0_i_2_n_0 ),
        .I2(a[4]),
        .I3(a[7]),
        .I4(\spo[19]_INST_0_i_1_n_0 ),
        .I5(\spo[19]_INST_0_i_2_n_0 ),
        .O(spo[18]));
  LUT6 #(
    .INIT(64'h0809280804370405)) 
    \spo[19]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[5]),
        .I2(a[6]),
        .I3(a[2]),
        .I4(a[3]),
        .I5(a[0]),
        .O(\spo[19]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h020A020401090908)) 
    \spo[19]_INST_0_i_2 
       (.I0(a[0]),
        .I1(a[5]),
        .I2(a[6]),
        .I3(a[3]),
        .I4(a[2]),
        .I5(a[1]),
        .O(\spo[19]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0088008000080000)) 
    \spo[20]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[30]_INST_0_i_2_n_0 ),
        .I2(a[5]),
        .I3(a[7]),
        .I4(\spo[20]_INST_0_i_1_n_0 ),
        .I5(\spo[20]_INST_0_i_2_n_0 ),
        .O(spo[19]));
  LUT6 #(
    .INIT(64'h0D05113F0803EEC1)) 
    \spo[20]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[2]),
        .I2(a[6]),
        .I3(a[0]),
        .I4(a[4]),
        .I5(a[3]),
        .O(\spo[20]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0232303033330323)) 
    \spo[20]_INST_0_i_2 
       (.I0(a[2]),
        .I1(a[6]),
        .I2(a[4]),
        .I3(a[3]),
        .I4(a[0]),
        .I5(a[1]),
        .O(\spo[20]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0088008000080000)) 
    \spo[21]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[30]_INST_0_i_2_n_0 ),
        .I2(a[6]),
        .I3(a[7]),
        .I4(\spo[21]_INST_0_i_1_n_0 ),
        .I5(\spo[21]_INST_0_i_2_n_0 ),
        .O(spo[20]));
  LUT6 #(
    .INIT(64'h180B3344CD74FEAB)) 
    \spo[21]_INST_0_i_1 
       (.I0(a[5]),
        .I1(a[3]),
        .I2(a[2]),
        .I3(a[0]),
        .I4(a[4]),
        .I5(a[1]),
        .O(\spo[21]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000150)) 
    \spo[21]_INST_0_i_2 
       (.I0(a[5]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[0]),
        .I4(a[4]),
        .I5(a[3]),
        .O(\spo[21]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA00200000)) 
    \spo[22]_INST_0 
       (.I0(\spo[22]_INST_0_i_1_n_0 ),
        .I1(a[7]),
        .I2(a[6]),
        .I3(a[8]),
        .I4(\spo[22]_INST_0_i_2_n_0 ),
        .I5(\spo[22]_INST_0_i_3_n_0 ),
        .O(spo[21]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    \spo[22]_INST_0_i_1 
       (.I0(a[9]),
        .I1(a[10]),
        .I2(a[11]),
        .I3(a[13]),
        .I4(a[12]),
        .O(\spo[22]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00010100)) 
    \spo[22]_INST_0_i_2 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[3]),
        .I3(a[2]),
        .I4(a[0]),
        .O(\spo[22]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00000000000088F8)) 
    \spo[22]_INST_0_i_3 
       (.I0(\spo[22]_INST_0_i_4_n_0 ),
        .I1(\spo[4]_INST_0_i_2_n_0 ),
        .I2(\spo[22]_INST_0_i_5_n_0 ),
        .I3(a[6]),
        .I4(a[8]),
        .I5(a[7]),
        .O(\spo[22]_INST_0_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \spo[22]_INST_0_i_4 
       (.I0(a[2]),
        .I1(a[1]),
        .I2(a[0]),
        .O(\spo[22]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h8A2B91415DF60202)) 
    \spo[22]_INST_0_i_5 
       (.I0(a[3]),
        .I1(a[2]),
        .I2(a[5]),
        .I3(a[1]),
        .I4(a[0]),
        .I5(a[4]),
        .O(\spo[22]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAAAA200020002000)) 
    \spo[23]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(a[7]),
        .I2(\spo[30]_INST_0_i_2_n_0 ),
        .I3(\spo[23]_INST_0_i_1_n_0 ),
        .I4(\spo[24]_INST_0_i_2_n_0 ),
        .I5(\spo[23]_INST_0_i_2_n_0 ),
        .O(spo[22]));
  LUT6 #(
    .INIT(64'h000000000000045D)) 
    \spo[23]_INST_0_i_1 
       (.I0(a[3]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[0]),
        .I4(a[5]),
        .I5(a[4]),
        .O(\spo[23]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h3BAA76D4448AEEA8)) 
    \spo[23]_INST_0_i_2 
       (.I0(a[0]),
        .I1(a[5]),
        .I2(a[2]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[4]),
        .O(\spo[23]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAAA200020002000)) 
    \spo[24]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(a[7]),
        .I2(\spo[30]_INST_0_i_2_n_0 ),
        .I3(\spo[24]_INST_0_i_1_n_0 ),
        .I4(\spo[24]_INST_0_i_2_n_0 ),
        .I5(\spo[24]_INST_0_i_3_n_0 ),
        .O(spo[23]));
  LUT6 #(
    .INIT(64'h0000000000000020)) 
    \spo[24]_INST_0_i_1 
       (.I0(a[3]),
        .I1(a[2]),
        .I2(a[1]),
        .I3(a[0]),
        .I4(a[5]),
        .I5(a[4]),
        .O(\spo[24]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \spo[24]_INST_0_i_2 
       (.I0(a[8]),
        .I1(a[7]),
        .I2(a[6]),
        .I3(a[9]),
        .O(\spo[24]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h841F1200DF141FCD)) 
    \spo[24]_INST_0_i_3 
       (.I0(a[2]),
        .I1(a[0]),
        .I2(a[1]),
        .I3(a[5]),
        .I4(a[3]),
        .I5(a[4]),
        .O(\spo[24]_INST_0_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h01000000)) 
    \spo[25]_INST_0 
       (.I0(a[11]),
        .I1(a[12]),
        .I2(a[13]),
        .I3(\spo[25]_INST_0_i_1_n_0 ),
        .I4(\spo[25]_INST_0_i_2_n_0 ),
        .O(spo[24]));
  LUT6 #(
    .INIT(64'h010302350AF0C071)) 
    \spo[25]_INST_0_i_1 
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[0]),
        .I3(a[4]),
        .I4(a[5]),
        .I5(a[1]),
        .O(\spo[25]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    \spo[25]_INST_0_i_2 
       (.I0(a[6]),
        .I1(a[7]),
        .I2(a[8]),
        .I3(a[10]),
        .I4(a[9]),
        .O(\spo[25]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0088008000080000)) 
    \spo[26]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[30]_INST_0_i_2_n_0 ),
        .I2(a[6]),
        .I3(a[7]),
        .I4(\spo[26]_INST_0_i_1_n_0 ),
        .I5(\spo[26]_INST_0_i_2_n_0 ),
        .O(spo[25]));
  LUT6 #(
    .INIT(64'h02351C003237480D)) 
    \spo[26]_INST_0_i_1 
       (.I0(a[3]),
        .I1(a[1]),
        .I2(a[5]),
        .I3(a[4]),
        .I4(a[0]),
        .I5(a[2]),
        .O(\spo[26]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000002)) 
    \spo[26]_INST_0_i_2 
       (.I0(a[3]),
        .I1(a[2]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[5]),
        .I5(a[4]),
        .O(\spo[26]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0088008000080000)) 
    \spo[27]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[30]_INST_0_i_2_n_0 ),
        .I2(a[0]),
        .I3(a[7]),
        .I4(\spo[27]_INST_0_i_1_n_0 ),
        .I5(\spo[27]_INST_0_i_2_n_0 ),
        .O(spo[26]));
  LUT6 #(
    .INIT(64'h0004000410042001)) 
    \spo[27]_INST_0_i_1 
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[4]),
        .I3(a[5]),
        .I4(a[1]),
        .I5(a[6]),
        .O(\spo[27]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000040405050306)) 
    \spo[27]_INST_0_i_2 
       (.I0(a[1]),
        .I1(a[3]),
        .I2(a[6]),
        .I3(a[2]),
        .I4(a[5]),
        .I5(a[4]),
        .O(\spo[27]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000800)) 
    \spo[28]_INST_0 
       (.I0(\spo[28]_INST_0_i_1_n_0 ),
        .I1(\spo[28]_INST_0_i_2_n_0 ),
        .I2(a[2]),
        .I3(\spo[28]_INST_0_i_3_n_0 ),
        .I4(a[10]),
        .I5(a[9]),
        .O(spo[28]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \spo[28]_INST_0_i_1 
       (.I0(a[13]),
        .I1(a[12]),
        .I2(a[11]),
        .O(\spo[28]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0100010000080081)) 
    \spo[28]_INST_0_i_2 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[3]),
        .I4(a[1]),
        .I5(a[6]),
        .O(\spo[28]_INST_0_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \spo[28]_INST_0_i_3 
       (.I0(a[7]),
        .I1(a[8]),
        .O(\spo[28]_INST_0_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hAA80)) 
    \spo[2]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[3]_INST_0_i_1_n_0 ),
        .I2(\spo[2]_INST_0_i_1_n_0 ),
        .I3(\spo[3]_INST_0_i_3_n_0 ),
        .O(spo[1]));
  LUT6 #(
    .INIT(64'h8608060006000481)) 
    \spo[2]_INST_0_i_1 
       (.I0(a[4]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[2]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0088008000080000)) 
    \spo[30]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[30]_INST_0_i_2_n_0 ),
        .I2(a[6]),
        .I3(a[7]),
        .I4(\spo[30]_INST_0_i_3_n_0 ),
        .I5(\spo[30]_INST_0_i_4_n_0 ),
        .O(spo[27]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \spo[30]_INST_0_i_1 
       (.I0(a[11]),
        .I1(a[10]),
        .I2(a[13]),
        .I3(a[12]),
        .O(\spo[30]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \spo[30]_INST_0_i_2 
       (.I0(a[8]),
        .I1(a[9]),
        .O(\spo[30]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0110000800080001)) 
    \spo[30]_INST_0_i_3 
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[0]),
        .I3(a[1]),
        .I4(a[4]),
        .I5(a[5]),
        .O(\spo[30]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000001000130000)) 
    \spo[30]_INST_0_i_4 
       (.I0(a[1]),
        .I1(a[5]),
        .I2(a[0]),
        .I3(a[4]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[30]_INST_0_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hAA80)) 
    \spo[3]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[3]_INST_0_i_1_n_0 ),
        .I2(\spo[3]_INST_0_i_2_n_0 ),
        .I3(\spo[3]_INST_0_i_3_n_0 ),
        .O(spo[2]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \spo[3]_INST_0_i_1 
       (.I0(a[7]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[8]),
        .O(\spo[3]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h9440044004402400)) 
    \spo[3]_INST_0_i_2 
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[4]),
        .I3(a[5]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[3]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000200000)) 
    \spo[3]_INST_0_i_3 
       (.I0(\spo[3]_INST_0_i_4_n_0 ),
        .I1(a[0]),
        .I2(\spo[3]_INST_0_i_5_n_0 ),
        .I3(a[5]),
        .I4(a[3]),
        .I5(a[1]),
        .O(\spo[3]_INST_0_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \spo[3]_INST_0_i_4 
       (.I0(a[7]),
        .I1(a[6]),
        .I2(a[9]),
        .I3(a[8]),
        .O(\spo[3]_INST_0_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \spo[3]_INST_0_i_5 
       (.I0(a[2]),
        .I1(a[4]),
        .O(\spo[3]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA80000000)) 
    \spo[4]_INST_0 
       (.I0(\spo[22]_INST_0_i_1_n_0 ),
        .I1(\spo[4]_INST_0_i_1_n_0 ),
        .I2(\spo[4]_INST_0_i_2_n_0 ),
        .I3(\spo[4]_INST_0_i_3_n_0 ),
        .I4(a[0]),
        .I5(\spo[4]_INST_0_i_4_n_0 ),
        .O(spo[3]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \spo[4]_INST_0_i_1 
       (.I0(a[8]),
        .I1(a[6]),
        .I2(a[7]),
        .O(\spo[4]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \spo[4]_INST_0_i_2 
       (.I0(a[4]),
        .I1(a[5]),
        .O(\spo[4]_INST_0_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \spo[4]_INST_0_i_3 
       (.I0(a[1]),
        .I1(a[2]),
        .O(\spo[4]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00000000000088F8)) 
    \spo[4]_INST_0_i_4 
       (.I0(\spo[4]_INST_0_i_5_n_0 ),
        .I1(\spo[4]_INST_0_i_2_n_0 ),
        .I2(\spo[4]_INST_0_i_6_n_0 ),
        .I3(a[6]),
        .I4(a[8]),
        .I5(a[7]),
        .O(\spo[4]_INST_0_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \spo[4]_INST_0_i_5 
       (.I0(a[2]),
        .I1(a[3]),
        .O(\spo[4]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0E5557FEBE5553FD)) 
    \spo[4]_INST_0_i_6 
       (.I0(a[1]),
        .I1(a[2]),
        .I2(a[3]),
        .I3(a[4]),
        .I4(a[5]),
        .I5(a[0]),
        .O(\spo[4]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0088008000080000)) 
    \spo[5]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[30]_INST_0_i_2_n_0 ),
        .I2(a[4]),
        .I3(a[7]),
        .I4(\spo[5]_INST_0_i_1_n_0 ),
        .I5(\spo[5]_INST_0_i_2_n_0 ),
        .O(spo[4]));
  LUT6 #(
    .INIT(64'h0013CCCD00134445)) 
    \spo[5]_INST_0_i_1 
       (.I0(a[0]),
        .I1(a[5]),
        .I2(a[3]),
        .I3(a[2]),
        .I4(a[6]),
        .I5(a[1]),
        .O(\spo[5]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000F2B20000C4F6)) 
    \spo[5]_INST_0_i_2 
       (.I0(a[2]),
        .I1(a[5]),
        .I2(a[3]),
        .I3(a[0]),
        .I4(a[6]),
        .I5(a[1]),
        .O(\spo[5]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0088008000080000)) 
    \spo[6]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[30]_INST_0_i_2_n_0 ),
        .I2(a[6]),
        .I3(a[7]),
        .I4(\spo[6]_INST_0_i_1_n_0 ),
        .I5(\spo[6]_INST_0_i_2_n_0 ),
        .O(spo[5]));
  LUT6 #(
    .INIT(64'hBCC03C04BC803080)) 
    \spo[6]_INST_0_i_1 
       (.I0(a[0]),
        .I1(a[4]),
        .I2(a[5]),
        .I3(a[1]),
        .I4(a[3]),
        .I5(a[2]),
        .O(\spo[6]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000000000000020F)) 
    \spo[6]_INST_0_i_2 
       (.I0(a[1]),
        .I1(a[3]),
        .I2(a[5]),
        .I3(a[0]),
        .I4(a[2]),
        .I5(a[4]),
        .O(\spo[6]_INST_0_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h01000000)) 
    \spo[7]_INST_0 
       (.I0(a[11]),
        .I1(a[12]),
        .I2(a[13]),
        .I3(\spo[7]_INST_0_i_1_n_0 ),
        .I4(\spo[25]_INST_0_i_2_n_0 ),
        .O(spo[6]));
  LUT6 #(
    .INIT(64'h0400200B00340021)) 
    \spo[7]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[0]),
        .I2(a[3]),
        .I3(a[5]),
        .I4(a[2]),
        .I5(a[4]),
        .O(\spo[7]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h01000000)) 
    \spo[8]_INST_0 
       (.I0(a[11]),
        .I1(a[12]),
        .I2(a[13]),
        .I3(\spo[8]_INST_0_i_1_n_0 ),
        .I4(\spo[25]_INST_0_i_2_n_0 ),
        .O(spo[7]));
  LUT6 #(
    .INIT(64'h050000924C0041E8)) 
    \spo[8]_INST_0_i_1 
       (.I0(a[3]),
        .I1(a[1]),
        .I2(a[0]),
        .I3(a[4]),
        .I4(a[5]),
        .I5(a[2]),
        .O(\spo[8]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0088008000080000)) 
    \spo[9]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[30]_INST_0_i_2_n_0 ),
        .I2(a[6]),
        .I3(a[7]),
        .I4(\spo[9]_INST_0_i_1_n_0 ),
        .I5(\spo[9]_INST_0_i_2_n_0 ),
        .O(spo[8]));
  LUT6 #(
    .INIT(64'h503122E18E080004)) 
    \spo[9]_INST_0_i_1 
       (.I0(a[1]),
        .I1(a[3]),
        .I2(a[5]),
        .I3(a[0]),
        .I4(a[2]),
        .I5(a[4]),
        .O(\spo[9]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000005001)) 
    \spo[9]_INST_0_i_2 
       (.I0(a[5]),
        .I1(a[2]),
        .I2(a[1]),
        .I3(a[0]),
        .I4(a[4]),
        .I5(a[3]),
        .O(\spo[9]_INST_0_i_2_n_0 ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
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

endmodule
`endif
