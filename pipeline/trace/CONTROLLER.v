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
    input  wire [31:0] inst,

    output reg  [1:0]  wd_sel,
    output reg  [3:0]  alu_op,
    output wire        alub_sel,
    output wire        rf_we,
    output wire        dram_we,
    output reg  [2:0]  sext_op,
    output wire [2:0]  branch,
    output wire [1:0]  jump,
    output wire        re1, // whether rD1 will be used
    output wire        re2, // whether rD2 will be used

    output wire        debug_have_inst
);

wire [6:0] opcode = inst[6:0];
wire [2:0] funct3 = inst[14:12];
wire [6:0] funct7 = inst[31:25];

wire R    = (opcode == OP_R);
wire I    = (opcode == OP_I);
wire lw   = (opcode == OP_LOAD);
wire lui  = (opcode == OP_LUI);
wire sw   = (opcode == OP_S);
wire jalr = (opcode == OP_JALR);
wire jal  = (opcode == OP_JAL);
wire B    = (opcode == OP_B);

assign is_inst = R | I | lw | lui | sw | jalr | jal | B;

assign debug_have_inst = is_inst;

always @ (*) begin
    if (R)         wd_sel = 2'b00;
    else if (I)    wd_sel = 2'b00;
    else if (lw)   wd_sel = 2'b01;
    else if (lui)  wd_sel = 2'b11;
    else if (jalr) wd_sel = 2'b10;
    else if (jal)  wd_sel = 2'b10;
    else           wd_sel = 2'b00;
end

always @ (*) begin
    if (R) begin
        case (funct3)
            3'b000:  alu_op = funct7[5] ? 4'b0110 : 4'b0010;
            3'b111:  alu_op = 4'b0000;
            3'b110:  alu_op = 4'b0001;
            3'b100:  alu_op = 4'b0101;
            3'b001:  alu_op = 4'b1000;
            3'b101:  alu_op = funct7[5] ? 4'b1011 : 4'b1010;
            default: alu_op = 4'b0000;
        endcase
    end
    else if (I) begin
        case (funct3)
            3'b000:  alu_op = 4'b0010;
            3'b111:  alu_op = 4'b0000;
            3'b110:  alu_op = 4'b0001;
            3'b100:  alu_op = 4'b0101;
            3'b001:  alu_op = 4'b1000;
            3'b101:  alu_op = funct7[5] ? 4'b1011 : 4'b1010;
            default: alu_op = 4'b0000;
        endcase
    end
    else if (lw)   alu_op = 4'b0010;
    else if (sw)   alu_op = 4'b0010;
    else if (jalr) alu_op = 4'b0010;
    else if (B)    alu_op = 4'b0110;
    else           alu_op = 4'b0000;
end

assign alub_sel = (I | lw | sw | jalr);
assign rf_we = is_inst & ~(sw | B);
assign dram_we = sw;

always @ (*) begin
    if (I) begin
        if (funct3 == 3'b000 || funct3 == 3'b111 || funct3 == 3'b110 || funct3 == 3'b100) sext_op = 3'b000;
        else if (funct3 == 3'b001 || funct3 == 3'b101) sext_op = 3'b001;
        else sext_op = 3'b000;
    end
    else if (lw)   sext_op = 3'b000;
    else if (lui)  sext_op = 3'b011;
    else if (sw)   sext_op = 3'b010;
    else if (jalr) sext_op = 3'b000;
    else if (B)    sext_op = 3'b100;
    else if (jal)  sext_op = 3'b101;
    else           sext_op = 3'b000;
end

assign branch = {funct3[2], funct3[0], B}; // 00:beq; 01:bne; 10:blt; 11:bge
assign jump = {opcode[3], jalr | jal};     // 0:jalr; 1:jal

assign re1 = is_inst & ~(lui | jal);
assign re2 = (R | sw | B);

endmodule
