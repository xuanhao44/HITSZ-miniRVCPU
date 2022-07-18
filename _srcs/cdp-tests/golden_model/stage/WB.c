#include <cpu.h>
extern riscv32_CPU_state cpu;
WB_info WB(MEM2WB mem_info) {
    WB_info ret;
    ret.wb_have_inst = 1;
    if(mem_info.branch_taken) {
        cpu.npc = mem_info.target_pc;
    } 
    uint32_t wb_val;
    if(mem_info.wb_en) {
        switch(mem_info.wb_sel) {
            case WB_ALU: wb_val = mem_info.alu_out; break;
            case WB_PC: wb_val = mem_info.pc + 4; break;
            case WB_LOAD: wb_val = mem_info.load_out; break;
            default: wb_val = 0; break;
        }
        cpu.gpr[mem_info.dst] = wb_val;
    }
    ret.wb_value = wb_val;
    ret.wb_ena = mem_info.wb_en;
    ret.wb_pc = mem_info.pc;
    ret.wb_reg = mem_info.dst;
    cpu.gpr[0] = 0;
    Log("WB Stage:");
    Log("PC = %8.8x", mem_info.pc);
    if(mem_info.wb_en) {
        Log("WB value = %8.8x, WReg = %d, npc = 0x%8.8x", wb_val, mem_info.dst, cpu.npc);
    }
    if(mem_info.branch_taken) {
        Log("Branch Taken, target is %8.8x", mem_info.target_pc);
    }
    return ret;
}
