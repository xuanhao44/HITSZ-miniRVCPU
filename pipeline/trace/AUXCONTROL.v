module AUXCONTROL (
    input  wire [2:0]  branch,
    input  wire [1:0]  jump  ,
    input  wire        zero  ,
    input  wire        sgn   ,
    input  wire [31:0] pcimm ,
    input  wire [31:0] alu_c ,

    output reg         npc_op,
    output reg  [31:0] npc_bj
);

always @ (*) begin
    if (jump[0] == 1'b1) npc_op = 1'b1; // jal or jalr
    else if (branch[0] == 1'b1) begin
        case (branch[2:1])
            2'b00: npc_op = zero ? 1'b1 : 1'b0; // beq
            2'b01: npc_op = zero ? 1'b0 : 1'b1; // bne
            2'b10: npc_op = sgn  ? 1'b1 : 1'b0; // blt
            2'b11: npc_op = sgn  ? 1'b0 : 1'b1; // bge
        endcase
    end
    else npc_op = 1'b0;
end

always @ (*) begin
    if (jump == 2'b01)      npc_bj = {alu_c[31:1], 1'b0}; // jalr
    else if (jump == 2'b11) npc_bj = pcimm; // jal
    else                    npc_bj = pcimm; // otherwise
end

endmodule
