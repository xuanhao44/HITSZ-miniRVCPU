#ifndef __DEBUG_H__
#define __DEBUG_H__

#include <stdio.h>
#include <assert.h>
#define Log_color(format, ...) \
    printf("\33[1;34m[%s,%d,%s] " format "\33[0m\n", \
        __FILE__, __LINE__, __func__, ## __VA_ARGS__)
#ifdef DEBUG_ON
#define Log(format, ...) \
    printf("[%s,%d,%s] " format "\n", \
        __FILE__, __LINE__, __func__, ## __VA_ARGS__)
#else
#define Log(format, ...) \

#endif

#define color_print(format, ...) \
    printf("\33[1;34m" format "\33[0m", \
        ## __VA_ARGS__)

#define Assert(cond, ...) \
  do { \
    if (!(cond)) { \
      fflush(stdout); \
      fprintf(stderr, "\33[1;31m"); \
      fprintf(stderr, __VA_ARGS__); \
      fprintf(stderr, "\33[0m\n"); \
      assert(cond); \
    } \
  } while (0)

#define panic(...) Assert(0, __VA_ARGS__)

#define TODO() panic("please implement me")

#endif
