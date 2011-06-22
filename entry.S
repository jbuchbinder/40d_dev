    .text
    .org 0
    .globl _start, start

start:
_start:
                BL      COPY
                LDR     R0, =0xC0220000 // blue led address
                LDR     R1, =0x46       // led on
                STR     R1, [R0]        // turn on blue led

				LDR     R0, =0xC0400000
				LDR     R1, =0x430005
				STR     R1, [R0,#8]
				MOV     R0, #0xC0000000
				LDR     R1, =0xD9C50000
				STR     R1, [R0,#0x10]
				LDR     R2, =0xC0200000
				MOV     R1, #0xFFFFFFFF
				STR     R1, [R2,#0x10C]
				STR     R1, [R2,#0xC]
				STR     R1, [R2,#0x1C]
				STR     R1, [R2,#0x2C]
				STR     R1, [R2,#0x3C]
				STR     R1, [R2,#0x4C]
				STR     R1, [R2,#0x5C]
				STR     R1, [R2,#0x6C]
				STR     R1, [R2,#0x7C]
				STR     R1, [R2,#0x8C]
				STR     R1, [R2,#0x9C]
				STR     R1, [R2,#0xAC]
				STR     R1, [R2,#0xBC]
				STR     R1, [R2,#0xCC]
				STR     R1, [R2,#0xDC]
				STR     R1, [R2,#0xEC]
				STR     R1, [R2,#0xFC]
				LDR     SP, =0x1900
				MOV     R11, #0
				LDR     PC, =my_romStart


.align 2
fin:
