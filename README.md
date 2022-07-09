# 计算机设计与实践 HITSZ-miniRVCPU

## 参考

- https://hitsz-cslab.gitee.io/cpu/
- https://github.com/xyfJASON/HITSZ-miniRV-1
- https://github.com/Yikai-coder/HITsz_CPU_design
- https://github.com/FinCreWorld/miniRV-1

## 工程

- single_cycle
  - trace
    - in：IROM 和 DRAM 在 cpu 里面。
    - out：IROM 和 DRAM 在 cpu 外面。
  - onBoard
    - test1：运行给定的 IROM 的指令，在数码管上显示 2500_0018。
      - 在 out 的基础上，使用老师提供的 ip 核，增添了数码管的外设（偷懒直接显示 x8），删除了 debug 的输出。
    - test2：将自己的汇编指令导入 IROM，实现计算器的功能。
      - 在 test1 的基础上，增添了拨码开关和 led 灯的外设（正式的外设）。
- pipeline

