#ifndef __DUT__
#define __DUT__

#include <sys/types.h>
#include <verilated_vcd_c.h>
#include <cpu.h>

template<class MODULE> class TESTBENCH {
    public:
        VerilatedVcdC	*vltdump;
        MODULE *dut;
        unsigned long count;

        TESTBENCH(void) {
            Verilated::traceEverOn(true);
            dut = new MODULE;
            count = 0;
        }

        ~TESTBENCH(void) {
            closetrace();
            if(!vltdump) delete vltdump;
            delete dut;
        }

        // Open/create a trace file
        void opentrace(const char *vcdname) {
            if (!vltdump) {
                vltdump = new VerilatedVcdC;
                dut->trace(vltdump, 99);
                vltdump->open(vcdname);
            }
        }

        // Close a trace file
        void closetrace(void) {
            if (vltdump) {
                vltdump->close();
                vltdump = NULL;
            }
        }

        WB_info tick(void) {
            count++;

            dut->clk = 0;
            dut->eval();

            if(vltdump) vltdump->dump((vluint64_t)(10*count-1));

            // Repeat for the positive edge of the clock
            dut->clk = 1;
            dut->eval();
            if(vltdump) vltdump->dump((vluint64_t)(10*count));

            // Now the negative edge
            dut->clk = 0;
            dut->eval();
            if (vltdump) {
                vltdump->dump((vluint64_t)(10*count+5));
                vltdump->flush();
            }
            WB_info ret;
            ret.wb_have_inst = dut->debug_wb_have_inst;
            ret.wb_pc = dut->debug_wb_pc;
            ret.wb_ena = dut->debug_wb_ena;
            ret.wb_reg = dut->debug_wb_reg;
            ret.wb_value = dut->debug_wb_value;
            return ret;
        }
};
#endif
