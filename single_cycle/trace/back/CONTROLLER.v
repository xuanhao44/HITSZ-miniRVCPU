`include "param.v"

module CONTROLLER #(
    localparam OP_R    = 7'b0110011,
    localparam OP_I    = 7'b0010011,
    localparam OP_LOAD = 7'b0000011,
    localparam OP_S    = 7'b0100011,
    localparam OP_B    = 7'b1100011,
    localparam OP_LUI  = 7'b0110111,
    localparam OP_JAL  = 7'b1101111,
    localparam OP_JALR = 7'b1100111
)
(
    input  wire [31:0] inst    ,
    input  wire        zero    ,
    input  wire        sgn     ,

    output wire [1:0]  npc_op  ,
    output wire [2:0]  sext_op ,
    output wire        rf_we   ,
    output wire [1:0]  wd_sel  ,
    output wire        alub_sel,
    output wire [3:0]  alu_op  ,
    output wire        dram_we
);

wire [6:0] opcode = inst[6 :0 ];
wire [2:0] funct3 = inst[14:12];
wire [6:0] funct7 = inst[31:25];

wire R    = (opcode == OP_R   );
wire I    = (opcode == OP_I   );
wire LOAD = (opcode == OP_LOAD);
wire S    = (opcode == OP_S   );
wire B    = (opcode == OP_B   );
wire LUI  = (opcode == OP_LUI );
wire JAL  = (opcode == OP_JAL );
wire JALR = (opcode == OP_JALR);

wire BEQ  = (B & (funct3 == 3'b000));
wire BNE  = (B & (funct3 == 3'b001));
wire BLT  = (B & (funct3 == 3'b100));
wire BGE  = (B & (funct3 == 3'b101));

wire SHIFT_I = (I & ((funct3 == 3'b001) | (funct3 == 3'b101))); // slli,(srli, srai)

// 选择 NPC.npc 输出的控制信号: npc_op
assign npc_op = (R | I | LOAD | LUI | S) ? `PC_4 :
                JALR ? `RD1_IMM :
                JAL ? `PC_IMM:
                BEQ ? (zero ? `PC_IMM : `PC_4) :
                BNE ? (zero ? `PC_4 : `PC_IMM) :
                BLT ? (sgn  ? `PC_IMM : `PC_4) :
                BGE ? (sgn  ? `PC_4 : `PC_IMM) :
                `PC_4;

// 选择写回寄存器的控制信号: wd_sel
assign wd_sel = (R | I)      ? `ALU_C    :
                LOAD         ? `DRAM_RD  :
                LUI          ? `SEXT_EXT :
                (JAL | JALR) ? `NPC_PC4  :
                `ALU_C;

// 选择 SEXT 中立即数生成模式的控制信号: sext_op
assign sext_op = (LOAD | JALR) ? `IMM_I :
                 LUI ? `IMM_U :
                 S ? `IMM_S:
                 B ? `IMM_B:
                 JAL ? `IMM_J :
                 SHIFT_I ? `IMM_SHIFT:
                 `IMM_I; // addi, andi, ori, xori...

// RF 的写控制信号: rf_we
assign rf_we = (S | B) ? `DISABLE : `ENABLE;

// 选择 ALU.B 输入的控制信号: alub_sel
assign alub_sel = (I | LOAD | S | JALR) ? `ALU_B_SEXT_EXT : `ALU_B_RF_RD2;

// 选择 ALU 运算方式: alu_op
assign alu_op = (LOAD | S | JALR) ? `ADD :
                B ? `SUB :
                R ? (
                    (funct3 == 3'b000) ? (funct7[5] ? `SUB : `ADD) :
                    (funct3 == 3'b111) ? `AND :
                    (funct3 == 3'b110) ? `OR :
                    (funct3 == 3'b100) ? `XOR :
                    (funct3 == 3'b001) ? `SLL :
                    (funct3 == 3'b101) ? (funct7[5] ? `SRA : `SRL) :
                    `AND
                ) :
                I ? (
                    (funct3 == 3'b000) ? `ADD :
                    (funct3 == 3'b111) ? `AND :
                    (funct3 == 3'b110) ? `OR :
                    (funct3 == 3'b100) ? `XOR :
                    (funct3 == 3'b001) ? `SLL :
                    (funct3 == 3'b101) ? (funct7[5] ? `SRA : `SRL) :
                    `AND
                ) :
                `AND;

// DRAM 的写控制信号: dram_we
assign dram_we = S ? `WRITE : `READ;

endmodule
