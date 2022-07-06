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

    output reg  [1:0]  npc_op  ,
    output reg  [2:0]  sext_op ,
    output reg         rf_we   ,
    output reg  [1:0]  wd_sel  ,
    output reg         alub_sel,
    output reg  [3:0]  alu_op  ,
    output reg         dram_we
);

wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;

assign opcode = inst[6:0];
assign funct3 = inst[14:12];
assign funct7 = inst[31:25];

// 选择 NPC.npc 输出的控制信号: npc_op
always @ (*) begin
    case(opcode)
        OP_R, OP_I, OP_LOAD, OP_LUI, OP_S:
            npc_op = `PC_4;
        OP_JALR:
            npc_op = `RD1_IMM;
        OP_B: begin
            case(funct3)
                3'b000:  npc_op = zero ? `PC_IMM : `PC_4; // beq
                3'b001:  npc_op = zero ? `PC_4 : `PC_IMM; // bne
                3'b100:  npc_op = sgn  ? `PC_IMM : `PC_4; // blt
                3'b101:  npc_op = sgn  ? `PC_4 : `PC_IMM; // bge
                default: npc_op = `PC_4;
            endcase
        end
        OP_JAL:
            npc_op = `PC_IMM;
        default:
            npc_op = `PC_4;
    endcase
end

// 选择写回寄存器的控制信号: wd_sel
always @ (*) begin
    case(opcode)
        OP_R, OP_I:
            wd_sel = `ALU_C   ;
        OP_LOAD:
            wd_sel = `DRAM_RD ;
        OP_LUI:
            wd_sel = `SEXT_EXT;
        OP_JAL, OP_JALR:
            wd_sel = `NPC_PC4 ;
        default:
            wd_sel = `ALU_C   ;
    endcase
end

// 选择 SEXT 中立即数生成模式的控制信号: sext_op
always @ (*) begin
    case(opcode)
        OP_I: begin
            case (funct3)
                3'b000, 3'b111, 3'b110, 3'b100:
                    sext_op = `IMM_I; // addi, andi, ori, xori
                3'b001, 3'b101:
                    sext_op = `IMM_SHIFT; // slli,(srli, srai)
                default:
                    sext_op = `IMM_I;
            endcase
        end
        OP_LOAD, OP_JALR:
            sext_op = `IMM_I;
        OP_LUI:
            sext_op = `IMM_U;
        OP_S:
            sext_op = `IMM_S;
        OP_B:
            sext_op = `IMM_B;
        OP_JAL:
            sext_op = `IMM_J;
        default:
            sext_op = `IMM_I;
    endcase
end

// RF 的写控制信号: rf_we
always @ (*) begin
    if (opcode == OP_S) rf_we = `DISABLE;
        else if (opcode == OP_B) rf_we = `DISABLE;
        else rf_we = `ENABLE;
end

// 选择 ALU.B 输入的控制信号: alub_sel
always @ (*) begin
    case (opcode)
        OP_I, OP_LOAD, OP_S, OP_JALR:
            alub_sel = `ALU_B_SEXT_EXT;
        default:
            alub_sel = `ALU_B_RF_RD2;
    endcase
end

// 选择 ALU 运算方式: alu_op
always @ (*) begin
    case(opcode)
        OP_R: begin
            case(funct3)
                3'b000 : alu_op = funct7[5] ? `SUB : `ADD;
                3'b111 : alu_op = `AND;
                3'b110 : alu_op = `OR ;
                3'b100 : alu_op = `XOR;
                3'b001 : alu_op = `SLL;
                3'b101 : alu_op = funct7[5] ? `SRA : `SRL;
                default: alu_op = `AND;
            endcase
        end
        OP_I: begin
            case(funct3)
                3'b000 : alu_op = `ADD;
                3'b111 : alu_op = `AND;
                3'b110 : alu_op = `OR ;
                3'b100 : alu_op = `XOR;
                3'b001 : alu_op = `SLL;
                3'b101 : alu_op = funct7[5] ? `SRA : `SRL;
                default: alu_op = `AND;
            endcase
        end
        OP_LOAD, OP_S, OP_JALR:
            alu_op = `ADD;
        OP_B:
            alu_op = `SUB;
        default:
            alu_op = `AND;
    endcase
end
// DRAM 的写控制信号: dram_we
always @ (*) begin
    if (opcode == OP_S) dram_we = `WRITE;
        else dram_we = `READ;
end

endmodule
