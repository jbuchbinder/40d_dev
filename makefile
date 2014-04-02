name=AUTOEXEC
entryadr=0x800000

CFLAGS=-nostdlib -march=armv5te -fno-builtin -Wall -pedantic -std=gnu99
LDFLAGS=-Wl,-Ttext,$(entryadr)
GCCPATH=/opt/gcc-arm-none-eabi-4_7-2013q2/bin
CC=$(GCCPATH)/arm-none-eabi-gcc
AS=$(GCCPATH)/arm-none-eabi-as
OBJCOPY=$(GCCPATH)/arm-none-eabi-objcopy

all: $(name).BIN

$(name).BIN: $(name).arm.elf
	$(OBJCOPY) -O binary $(name).arm.elf $(name).BIN
$(name).arm.elf:entry.o entry_subs.o main.o link.script
	$(CC) $(CFLAGS) -Wl,-T,link.script -o$@ $^

entry.o:entry.S

main.o:main.c

entry_subs.o: entry_subs.S


clean:
	rm *.o; rm $(name).arm.elf
