#include <../include/cpu.h>

uint32_t read_seven_seg(uint32_t rel_addr, AccessMode mode);
void write_seven_seg(uint32_t rel_addr, AccessMode mode, uint32_t data);

uint32_t read_keyboard(uint32_t rel_addr, AccessMode mode);
void write_keyboard(uint32_t rel_addr, AccessMode mode, uint32_t data);

uint32_t read_led(uint32_t rel_addr, AccessMode mode);
void write_led(uint32_t rel_addr, AccessMode mode, uint32_t data);

uint32_t read_switch(uint32_t rel_addr, AccessMode mode);
void write_switch(uint32_t rel_addr, AccessMode mode, uint32_t data);

uint32_t read_button(uint32_t rel_addr, AccessMode mode);
void write_button(uint32_t rel_addr, AccessMode mode, uint32_t data);