PROJECT=main


DEFINES=

OBJS =main.o
OBJS+=startup.o

TOOLCHAIN=arm-none-eabi-
CC=$(TOOLCHAIN)gcc

ARMFLAGS=-mcpu=cortex-m3 -mfloat-abi=soft -mthumb
CFLAGS=-nostdlib -Wall $(DEFINES) $(ARMFLAGS)
LFLAGS=-T linker.ld

# OpenOCD upload
FLASH =-c 'halt'
FLASH+=-c 'sleep 5'
FLASH+=-c 'reset'
FLASH+=-c 'sleep 5'
FLASH+=-c 'flash write_image erase $(PROJECT).bin 0x8000000'
FLASH+=-c 'sleep 5'
FLASH+=-c 'shutdown'


%.o: %.s
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

flash: $(PROJECT).bin
	sudo openocd -f mybuspirate.cfg -f target/stm32f1x.cfg -c init $(FLASH)

bin: $(PROJECT).bin
$(PROJECT).bin: $(PROJECT).elf
	$(TOOLCHAIN)objcopy -O binary $< $@

elf: $(PROJECT).elf
$(PROJECT).elf: $(OBJS)
	$(CC) $(CFLAGS) $(LFLAGS) -o $@ $^

.PHONY: clean
clean:
	rm -f *.o *.elf *.bin
