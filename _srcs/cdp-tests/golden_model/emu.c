#include <cpu.h>
#include <debug.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include "peripheral/result_monitor.h"
#include "peripheral/onboard.h"

static const char *reg_name[33] = {
  "$0", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
  "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
  "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
  "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6",
  "this_pc"
};

riscv32_CPU_state cpu;
peripheral_descr peripherals[MAX_PERIPHERAL];
uint32_t num_peripherals = 0;
uint32_t memory[MEM_SZ / sizeof(uint32_t)];

extern IF2ID IF(uint32_t);
extern ID2EX ID(IF2ID);
extern EX2MEM EX(ID2EX);
extern MEM2WB MEM(EX2MEM);
extern WB_info WB(MEM2WB);
WB_info cpu_run_once() {
    IF2ID inst = IF(cpu.npc);    
    ID2EX decode_info = ID(inst);
    EX2MEM ex_info = EX(decode_info);
    MEM2WB mem_info = MEM(ex_info);
    return WB(mem_info);
}

void print_reg_state(){
    color_print("======= REG VALUE =======\n");
    color_print("x[ 0] = 0x00000000\t");
    for(int i = 1; i < 32; i++) {
        if( (i % 4) == 0 ) printf("\n");
        color_print("x[%2d] = 0x%8.8x\t", i, cpu.gpr[i]);
    }
    printf("\n");
}

void register_peripheral(const char *name, uint32_t base_addr, uint32_t len, PeripheralRCallback callback_r, PeripheralWCallback callback_w){
    color_print("Peripheral name: %s\tbase: 0x%8.8x\taddr len: 0x%8.8x\t\n", name, base_addr, len); 
    peripheral_descr new_peripheral;
    new_peripheral.name = name;
    new_peripheral.base_addr = base_addr;
    new_peripheral.len = len;
    new_peripheral.callback_r = callback_r;
    new_peripheral.callback_w = callback_w;
    Assert(num_peripherals < MAX_PERIPHERAL, "Too many peripherals.\n");
    peripherals[num_peripherals++] = new_peripheral;
}

bool is_peripheral(uint32_t addr, size_t* id){
    // Check if the address is in range of peripherals
    // If yes, return id
    // Otherwise return -1
    for(int i = 0; i < num_peripherals; i++) {
        if(addr >= peripherals[i].base_addr && addr <= peripherals[i].base_addr + peripherals[i].len) {
            *id = i;
            return true;
        }
    }
    return false;
}

void init_memory(const char *fname) {
    assert(fname != NULL);
    FILE *fp = fopen(fname, "rb");
    Assert(fp != NULL, "Cannot open file \"%s\"!\n", fname);
    Log("Using file \"%s\" as memory image.\n", fname);
    fseek(fp, 0, SEEK_END);
    int img_size = ftell(fp);
    fseek(fp, 0, SEEK_SET);
    int ret = fread(memory, img_size, 1, fp);
    assert(ret == 1);
    fclose(fp);
}

void init_cpu(const char *fname) {
    cpu.npc = 0;
    register_peripheral("MONITOR", 0x80000000, 0x8, read_monitor, write_monitor);
    register_peripheral("Digit", 0xFFFFF000, 0x4, read_seven_seg, write_seven_seg);
    init_memory(fname);
}
