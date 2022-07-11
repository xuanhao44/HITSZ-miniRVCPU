# 计算机设计与实践 HITSZ-miniRVCPU

## 参考

- https://hitsz-cslab.gitee.io/cpu/
- https://github.com/xyfJASON/HITSZ-miniRV-1
- https://github.com/Yikai-coder/HITsz_CPU_design
- https://github.com/FinCreWorld/miniRV-1

## 工程

各个工程在时间上大概是递进的，因此后面的工程或多或少写的比前面的更合理、更简洁，但我仍然认为展示思考的过程也是很重要的；实际上，每个工程也会有微妙的差别，因此上一个工程的代码不能完美的复用到下一个步骤，所以建议比对一下文件的差别，看看相较于之前修改了什么。

- single_cycle
  - trace
    - in：IROM 和 DRAM 在 cpu 里面。
    - out：IROM 和 DRAM 在 cpu 外面。
    - back：写完单周期上板实验后，基于 out 的修改版本。
  - onBoard
    - test1：运行给定的 IROM 的指令，在数码管上显示 2500_0018。
      - 在 out 的基础上，使用老师提供的 ip 核，增添了数码管的外设（偷懒直接显示 x8），**删除了 debug 的输出**。
    - test2：将自己的汇编指令导入 IROM，实现计算器的功能。
      - 在 test1 的基础上，增添了拨码开关和 led 灯的外设（正式的外设）。
    - final：为测试 cpu 最大频率的版本。
      - 在 test2 的基础上，将绝大多数寄存器变量修改为线网，减少寄存器延迟。
    - test2 和 final 都设计好了外设，因此上板的两个实验（trace 上板、实现计算器）都可以是一样的代码，只不过需要修改 IROM 和 DRAM 的 IP 核。
- pipeline

### single_cycle/trace/in

把 IROM 和 DRAM 的实例化延迟到阶段中。

- top
  - IF
    - PC
    - NPC
    - IROM
  - ID/WB
    - SEXT
    - RF
    - MUX4_1
  - EX
    - ALU
    - MUX2_1
  - MEM
    - DRAM

### single_cycle/trace/out

在 top 里实例化 IROM 和 DRAM，便于后续上板。

- top
  - miniCPU
    - IF
      - PC
      - NPC
    - ID/WB
      - SEXT
      - RF
      - MUX4_1
    - EX
      - ALU
      - MUX2_1
  - IROM
  - DRAM

### single_cycle/trace/back

结构同 out，修改为同 onBoard/final 的寄存器改线网。

### single_cycle/onBoard/test1

- top
  - clk_div：选择 PLL，选择 global buffer，不需要 reset 和 lock；初期尝试可使用 10MHz 分频。
  - miniCPU：内部结构略。
  - IROM：使用老师提供的 IROM 的 IP 核。
  - DRAM：使用老师提供的 DRAM 的 IP 核。
  - DISPLAY：数码管的显示部件，*十六进制数字的显示方法可能各异，请注意*。

### single_cycle/onBoard/test2

- top

  - clk_div：设置略，可以尝试使用更高的频率，如 25 MHz。
  - prgrom：建一个空的 IROM 的 IP 核，**导入自己写的计算器的机器码**。
  - miniCPU：将部分输出端口名字修改的符合规范，更适合阅读。
  - BUS：总线桥，模仿实验一 SOC 设计。

  - MEM：对 dram 的包装，将输入输出端口名字修改的符合规范，更适合阅读。
    - dram：建一个空的 DRAM 的 IP 核。
  - SwitchDriver：开关外设。
  - LedDriver：LED 外设。
  - DigitDriver：七段数码管外设。
    - DISPLAY：数码管的显示部件。

### single_cycle/onBoard/final

结构同 test2，修改为：大部分变量类型由寄存器类型改为线网类型。



