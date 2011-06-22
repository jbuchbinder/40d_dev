  #define DELAY_SYNC   400
  #define DELAY_SPACE  175
  #define DELAY0       150
  #define DELAY1       350
#define LED_AF    0xc02200E8

    .text
    .org 0
    .globl _start, start

start:
_start:
sysInit:
		 B	 main

