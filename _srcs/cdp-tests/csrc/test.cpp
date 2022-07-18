#include "dut.h"
#include "verilated.h"
#include <stdlib.h>
#include "Vtop.h"
#include <stdio.h>
#include <string.h>
#define STR(x) #x
#define STR_MACRO(x) STR(x)

TESTBENCH<Vtop>* top;
Vtop* top_module;
extern void init_cpu(const char*);
extern WB_info cpu_run_once();
double main_time = 0;
double sc_time_stamp() {
    return main_time;
}
void reset_all(){
    printf("[mycpu] Resetting ...\n");
    top_module -> rst_n = 0;
    for(int i = 0; i<20; i++) {
        top -> tick();
    }
    top_module -> rst_n = 1;
    printf("[mycpu] Reset done.\n");
}

void print_wb_info(WB_info i) {
    printf("PC=0x%8.8x, WBEn = %d, WReg = %d, WBValue = 0x%8.8x\n", i.wb_pc, i.wb_ena, i.wb_reg, i.wb_value);
}

int check(WB_info stu, WB_info ref) {
    int fail = 0;
    if(stu.wb_pc != ref.wb_pc) {
        fail = 1;
    }
    if(stu.wb_ena != ref.wb_ena) {
        fail = 1;
    }
    if(stu.wb_ena == 1) {
        if(stu.wb_reg != ref.wb_reg || stu.wb_value != ref.wb_value) {
            fail = 1;
        }
    }
    if(fail) {
        printf("[difftest] Test Failed!\n");
        printf("=========== Diffrence ===========\n");
        printf("SIGNAL NAME\tREFERENCE\tMYCPU\n");
        printf("debug_wb_pc\t0x%8.8x\t0x%8.8x\n", ref.wb_pc, stu.wb_pc);
        printf("debug_wb_ena\t%10d\t%10d\n", ref.wb_ena, stu.wb_ena);
        printf("debug_wb_reg\t%10d\t%10d\n", ref.wb_reg, stu.wb_reg);
        printf("debug_wb_value\t0x%8.8x\t0x%8.8x\n", ref.wb_value, stu.wb_value);
        exit(-1);
    }
    return 0;
}

int main(int argc, char** argv, char** env) {
    top = new TESTBENCH<Vtop>;
    char dir[1024] = "waveform/";
    if(argc < 2 || strlen(argv[1]) > 1000) {
        printf("Bad waveform dest path.");
        exit(-1);
    }
    top -> opentrace(strcat(strcat(dir, argv[1]), ".vcd"));
    init_cpu(STR_MACRO(PATH));
    top_module = top -> dut;

    reset_all();

    printf("[difftest] Test Start!\n");
    WB_info rtl_wb_info, model_wb_info;
    for(int i = 0; i < 1000000; i++) {
        rtl_wb_info = top -> tick();
        if(rtl_wb_info.wb_have_inst) {
            if(check(rtl_wb_info, cpu_run_once()) == -1) {
                break;
            }
        }
    }
    printf("Timed out! Please check whether your CPU got stuck.\n");
    delete top;
    return 0;
}
