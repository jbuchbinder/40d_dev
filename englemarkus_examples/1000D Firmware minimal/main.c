
/*void DisableInterrupts()
{
    asm(
         "MRS     R1, CPSR\n"
         "AND     R0, R1, #0x80\n"
         "ORR     R1, R1, #0x80\n"
         "MSR     CPSR_cf, R1\n"
	 :::"r1","r0");
}


void idle()
{
    int i;

    for(i=0;i<0x78800;i++){
	asm ("nop\n");
	asm ("nop\n");
	asm ("nop\n");
	asm ("nop\n");
    }
}

void FirmwareStart()
{
    asm(
	"LDR     R3, =0xC02200bc\n"
	"MOV     R2, #0x44\n"
	"STR     R2, [R3]\n"

// looks like idle cycle is required for proper shutdown
	"MOV     R3, #0x8000\n"
"idle_cycle:"
	"SUB	R3, R3, #1\n"
	"CMP	R3, #0\n"
	"BNE	idle_cycle\n"

// ordinary startup...

	"MOV     SP, #0x1900\n"
	"MOV     R11, #0\n"

	"MRS     R1, CPSR\n"
	"BIC     R1, R1, #0x3F\n"
	"ORR     R1, R1, #0xD3\n"
	"MSR     CPSR_cf, R1\n"

	"LDR     R2, =0xC0200000\n"
	"MOV     R1, #0xFFFFFFFF\n"
	"STR     R1, [R2,#0x10C]\n"
	"STR     R1, [R2,#0xC]\n"
	"STR     R1, [R2,#0x1C]\n"
	"STR     R1, [R2,#0x2C]\n"
	"STR     R1, [R2,#0x3C]\n"
	"STR     R1, [R2,#0x4C]\n"
	"STR     R1, [R2,#0x5C]\n"
	"STR     R1, [R2,#0x6C]\n"
	"STR     R1, [R2,#0x7C]\n"
	"STR     R1, [R2,#0x8C]\n"
	"STR     R1, [R2,#0x9C]\n"
	"STR     R1, [R2,#0xAC]\n"
	"STR     R1, [R2,#0xBC]\n"
	"STR     R1, [R2,#0xCC]\n"
	"STR     R1, [R2,#0xDC]\n"
	"STR     R1, [R2,#0xEC]\n"
	"STR     R1, [R2,#0xFC]\n"

	"MOV     R1, #0x78\n"
	"MCR     p15, 0, R1,c1,c0\n"
	"MOV     R1, #0\n"
	"MCR     p15, 0, R1,c7,c10, 4\n"
	"MCR     p15, 0, R1,c7,c5\n"
	"MCR     p15, 0, R1,c7,c6\n"
	"MOV     R2, #0x40000000\n"
	"ORR     R1, R2, #6\n"
	"MCR     p15, 0, R1,c9,c1\n"
	"ORR     R1, R1, #6\n"
	"MCR     p15, 0, R1,c9,c1, 1\n"
	"MRC     p15, 0, R1,c1,c0\n"
	"ORR     R1, R1, #0x50000\n"
	"MCR     p15, 0, R1,c1,c0\n"

	"MOV     R3, #0xFF0\n"
	"LDR     R1, =0x12345678\n"
	"ADD     R3, R3, #0x4000000C\n"
	"STR     R1, [R3]\n"

	"MOV     SP, #0x1900\n"
	"MOV     LR, PC\n"
	"LDR PC, =0xffc00000\n"
    );
}

*/

  #define DELAY_SYNC   400
  #define DELAY_SPACE  175
  #define DELAY0       150
  #define DELAY1       350

#define LED_AF    0xc02200E8

#include "crc16.h"

void DisableInterrupts()
{
    asm(
         "MRS     R1, CPSR\n"
         "AND     R0, R1, #0x80\n"
         "ORR     R1, R1, #0x80\n"
         "MSR     CPSR_cf, R1\n"
	 :::"r1","r0");
}

void idle()
{
    int i;

    for(i=0;i<0x78800;i++){
	asm ("nop\n");
	asm ("nop\n");
	asm ("nop\n");
	asm ("nop\n");
    }
}


void send_byte(long b)
{

#define nop()   asm("nop\n")
#define on()    *led=0x46
#define off()   *led=0x44
#define delay(value) \
    for (i=0; i<value; ++i) { \
	nop(); \
	nop(); \
    }

#define do_bit(i) \
        on(); \
	if (b&(1<<i)) { \
	    delay(DELAY1); \
	} else { \
            delay(DELAY0); \
        } \
	off(); \
        delay(DELAY_SPACE);

    volatile long *led = (void*)LED_AF;
    int i;

    delay(DELAY_SYNC);

    // data bits
    do_bit(0);
    do_bit(1);
    do_bit(2);
    do_bit(3);
    do_bit(4);
    do_bit(5);
    do_bit(6);
    do_bit(7);
}



int main() {
 
     volatile long *p;
    long i, b, t, r, j;

    idle();

    for (i=0;i<300;i++){
	send_byte('0');
	send_byte('1');
	send_byte('2');
	send_byte('3');
	send_byte('4');
	send_byte('5');
	send_byte('6');
	send_byte('7');
	send_byte('8');
	send_byte('9');
	send_byte(13);
	send_byte(10);

//	idle();
    }

    long blkn;
    long len = 1024;

    p=(void*)0x800120;
    blkn = 0;

    while (blkn < 10) { //(blkn<4096){
	long *ptr;
	long crc;

//    toggle_red();

    ptr = (long*) (((char*)p)+blkn*len);

	send_byte(0x0a);
	send_byte(0x55);
	send_byte(0xaa);
	send_byte(0x50);

	t=(long)ptr;
	send_byte(t);
	send_byte(t>>8);
	send_byte(t>>16);
	send_byte(t>>24);

	crc = crc16(0, (unsigned char*) ptr, len);

	// send 4-byte blocks
	for (i=0;i<(len/4);i++){
	    t=ptr[i];
	    send_byte(t);
	    send_byte(t>>8);
	    send_byte(t>>16);
	    send_byte(t>>24);

	}

	//send crc
	send_byte(crc);
	send_byte(crc>>8);
	send_byte(crc);
	send_byte(crc>>8);

	blkn++;
    }

*(char*)0xC02200E0 = 0x46;

 // *(char*)LED_RED=0x46;
 //   idle();

//    shutdown();
 
 
  while (1) ;
}


