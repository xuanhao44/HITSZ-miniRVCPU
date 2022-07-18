#include <cpu.h>
#include <stdint.h>
extern riscv32_CPU_state cpu;
extern uint32_t memory[];
extern peripheral_descr peripherals[];
bool is_peripheral(uint32_t addr, size_t* id);

uint32_t mem_load(uint32_t addr, AccessMode mode, uint32_t is_signed) {
    Log("Load");
    Log("Mem addr = %8.8x", addr);
    uint32_t index = addr >> 2;
    uint32_t byte_off = addr & 0b11;
    uint32_t bit_off = byte_off * 8;

    // peripheral access
    size_t peripheral_id;
    if (is_peripheral(addr, &peripheral_id)) {
        peripheral_descr p = peripherals[peripheral_id];
        return p.callback_r(addr - p.base_addr, mode);
    }
    
    // memory access
    Assert(addr < MEM_SZ, "Memory access out of bound");
    uint32_t result;
    switch (mode) {
        case ACCESS_BYTE : 
            result = (memory[index] >> bit_off) & 0xFF; 
            if (is_signed) {
                result = (int32_t)((int8_t)result);
            }
            break;
        case ACCESS_HWORD: 
            Assert(!(addr & 0b01), "Illegal access: Memory access unaligned.");
            result = (memory[index] >> bit_off) & 0xFFFF;
            if (is_signed) {
                result = (int32_t)((int16_t)result);
            }
            break;
        case ACCESS_WORD: 
            Assert(!(addr & 0b11), "Illegal access: Memory access unaligned.");
            result = memory[index];
            break;
        default: panic("Bad byte access mode. Only Word/Half word/Byte is supported.");
    }
    Log("Load Result = %8.8x", result);
    return result;
}

void mem_store(uint32_t addr, AccessMode mode, uint32_t value) {
    uint32_t index = addr >> 2;
    uint32_t byte_off = addr & 0b11;
    uint32_t bit_off = byte_off * 8;

    // peripheral access
    size_t peripheral_id;
    if (is_peripheral(addr, &peripheral_id)) {
        peripheral_descr p = peripherals[peripheral_id];
        return p.callback_w(addr - p.base_addr, mode, value);
    }
    
    // memory access
    Assert(addr < MEM_SZ, "Memory access out of bound");
    switch (mode) {
        case ACCESS_BYTE : 
            memory[index] = memory[index] & (~(0xFF << bit_off)) | ((value & 0xFF) << bit_off);
            return;
        case ACCESS_HWORD: 
            Assert(!(addr & 0b01), "Illegal access: Memory access unaligned.");
            memory[index] = memory[index] & (~(0xFFFF << bit_off)) | ((value & 0xFFFF) << bit_off);
            return;
        case ACCESS_WORD: 
            Assert(!(addr & 0b11), "Illegal access: Memory access unaligned.");
            memory[index] = value;
            return;
        default: panic("Bad byte access mode. Only Word/Half word/Byte is supported.");
    }
}

MEM2WB MEM(EX2MEM ex_info) {
    MEM2WB ret;
    // passthrough
    ret.alu_out = ex_info.alu_out;
    ret.wb_sel = ex_info.wb_sel;
    ret.wb_en = ex_info.wb_en;
    ret.dst = ex_info.dst;
    ret.branch_taken = ex_info.branch_taken;
    ret.target_pc = ex_info.target_pc;
    ret.inst = ex_info.inst;
    ret.pc = ex_info.pc;
    Log("PC = %8.8x", ret.pc);
    uint32_t load_result = 0;
    uint32_t is_store = 0;
    AccessMode mode = ACCESS_BYTE;
    uint32_t is_signed = 0;
    if(ex_info.is_mem) {
        switch (ex_info.mem_op) {
            case MEM_SB: mode =  ACCESS_BYTE; is_store = 1; break;
            case MEM_SH: mode = ACCESS_HWORD; is_store = 1; break;
            case MEM_SW: mode =  ACCESS_WORD; is_store = 1; break;

            case MEM_LB: mode =  ACCESS_BYTE; is_signed = 1; break;
            case MEM_LH: mode = ACCESS_HWORD; is_signed = 1; break;
            case MEM_LW: mode =  ACCESS_WORD; is_signed = 1; break;

            case MEM_LBU: mode =  ACCESS_BYTE; break;
            case MEM_LHU: mode = ACCESS_HWORD; break;
 
            default: is_store = 0; is_signed = 0;
        }
        if(is_store) {
            mem_store(ret.alu_out, mode, ex_info.store_val);
        } else {
            ret.load_out = mem_load(ret.alu_out, mode, is_signed);
        }
    }
    return ret;
}

