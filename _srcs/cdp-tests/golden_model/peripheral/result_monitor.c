#include "result_monitor.h"

uint32_t monitor_value_passed;
uint32_t monitor_value_failed;

uint32_t read_monitor(uint32_t rel_addr, AccessMode mode){
    Assert(mode == ACCESS_WORD && !(rel_addr & 0b11), "Access unaligned");
    switch (rel_addr)
    {
    case 0:
        return monitor_value_passed;
    case 1:
        return monitor_value_failed;
    default:
        panic("Access out of bound.");
    }
}

void write_monitor(uint32_t rel_addr, AccessMode mode, uint32_t data) {
    Assert(mode == ACCESS_WORD && !(rel_addr & 0b11), "Access unaligned");
    switch (rel_addr)
    {
    case 0:
        monitor_value_passed = data;
    case 1:
        monitor_value_failed = data;
    default:
        panic("Access out of bound.");
    }
}