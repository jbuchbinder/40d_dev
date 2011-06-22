    .text
    .org 0
    .globl _start, start

start:
_start:
sysInit:
		 B	 main

.align 2
fin:
