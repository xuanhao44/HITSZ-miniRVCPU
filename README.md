# 计算机设计与实践 HITSZ-miniRVCPU

## 参考

- https://hitsz-cslab.gitee.io/cpu/
- https://github.com/xyfJASON/HITSZ-miniRV-1
- https://github.com/Yikai-coder/HITsz_CPU_design
- https://github.com/FinCreWorld/miniRV-1

## 工程

|          工程版本          | 是否有 debug 信号<br>（用于 trace 比对） | IROM 和 DRAM <br>是否在 cpu 模块外部 | 是否有拨码开关<br>和 led 灯的外设 | 是否有七段数码管外设 |         功能         |
| :------------------------: | :--------------------------------------: | :----------------------------------: | :-------------------------------: | :------------------: | :------------------: |
|   single_cycle_trace_in    |                    Y                     |                  N                   |                 N                 |          N           |      trace 比对      |
|   single_cycle_trace_out   |                    Y                     |                  Y                   |                 N                 |          N           |      trace 比对      |
| single_cycle_onBoard_test1 |                    N                     |                  Y                   |                 N                 |          Y           | 上板跑老师的测试程序 |
| single_cycle_onBoard_test2 |                    N                     |                  Y                   |                 Y                 |          Y           | 上板跑自己的汇编程序 |

