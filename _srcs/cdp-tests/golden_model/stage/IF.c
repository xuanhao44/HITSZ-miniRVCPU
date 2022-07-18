#include <stdio.h>
#include <cpu.h>
extern riscv32_CPU_state cpu;
extern uint32_t memory[];

IF2ID IF(uint32_t npc) {
    IF2ID ret;
    Assert(npc < MEM_SZ, "PC out of boundary!\n");
    ret.inst = memory[npc >> 2];
    ret.pc = npc;
    cpu.pc = npc;
    Log("\n=====");
    Log("Fetched instruction 0x%8.8x at PC=0x%8.8x", ret.inst, ret.pc);
    cpu.npc = cpu.pc + 4;
    return ret;
}
