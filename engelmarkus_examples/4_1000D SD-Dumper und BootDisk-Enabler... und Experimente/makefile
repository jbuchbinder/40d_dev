PATH := ${HOME}/CHDK/toolchain/bin:${PATH}

name=AUTOEXEC
entryadr=0x800120

CFLAGS=-nostdlib -march=armv5te -fno-builtin -Wall -pedantic -std=gnu99
LDFLAGS=-Wl,-Ttext,$(entryadr)
CC=arm-none-eabi-gcc
AS=arm-none-eabi-as
OBJCOPY=arm-none-eabi-objcopy

all: $(name).BIN

$(name).BIN: $(name).arm.elf
	$(OBJCOPY) -O binary $(name).arm.elf $(name).BIN

$(name).arm.elf: entry.o entry_subs.o main.o link.script
	$(CC) $(CFLAGS) -Wl,-T,link.script -o$@ $^

entry.o: entry.S

entry_subs.o: entry_subs.S

main.o: main.c

clean:
	rm *.o; rm $(name).arm.elf; rm output.fir; rm $(name).BIN
	
