// file: param.v

// 选择 SEXT 中立即数生成模式的控制信号: sext_op
`define IMM_I          3'b000
`define IMM_SHIFT      3'b001
`define IMM_S          3'b010
`define IMM_U          3'b011
`define IMM_B          3'b100
`define IMM_J          3'b101

// RF 的写控制信号: rf_we
`define DISABLE        1'b0
`define ENABLE         1'b1

// 选择写回寄存器的控制信号: wd_sel
`define ALU_C          2'b00
`define DRAM_RD        2'b01
`define NPC_PC4        2'b10
`define SEXT_EXT       2'b11

// 选择 ALU.B 输入的控制信号: alub_sel
`define ALU_B_RF_RD2   1'b0
`define ALU_B_SEXT_EXT 1'b1

// 选择 ALU 运算方式: alu_op
`define AND            4'b0000
`define OR             4'b0001
`define ADD            4'b0010
`define SUB            4'b0110
`define XOR            4'b0101
`define SLL            4'b1000
`define SRL            4'b1010
`define SRA            4'b1011

// DRAM 的写控制信号: dram_we
`define READ           1'b0
`define WRITE          1'b1

// 外设前缀地址
`define IO             20'hfffff
// 后 12 位判别地址
`define DIGIT          12'h000
`define KEYBOARD       12'h010
`define LED            12'h060
`define SWITCH         12'h070
`define BUTTON         12'h078
