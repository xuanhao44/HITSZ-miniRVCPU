#ifndef RES_MON_H
#define RES_MON_H

#include "../include/cpu.h"

uint32_t read_monitor(uint32_t rel_addr, AccessMode mode);
void write_monitor(uint32_t rel_addr, AccessMode mode, uint32_t data);

#endif