name=autoexec
entryadr=0x800120

CFLAGS=-nostdlib -march=armv5te -fno-builtin -Wall -pedantic -std=gnu99
LDFLAGS=-Wl,-Ttext,$(entryadr)
CC=arm-none-eabi-gcc
AS=arm-none-eabi-as
OBJCOPY=arm-none-eabi-objcopy

all: $(name).bin

$(name).bin: $(name).arm.elf
	$(OBJCOPY) -O binary $(name).arm.elf $(name).bin
$(name).arm.elf:entry.o entry_subs.o main.o link.script
	$(CC) $(CFLAGS) -Wl,-T,link.script -o$@ $^

entry.o:entry.S

main.o:main.c

entry_subs.o: entry_subs.S


clean:
	rm *.o; rm $(name).arm.elf
