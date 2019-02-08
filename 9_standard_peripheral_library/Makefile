PROJECT=main

# notice the define, it is important for the library to work
DEFINES=-D STM32F10X_MD

OBJS =main.o
OBJS+=startup.o

TOOLCHAIN=arm-none-eabi-
CC=$(TOOLCHAIN)gcc

ARMFLAGS=-mcpu=cortex-m3 -mfloat-abi=soft -mthumb
CFLAGS=-nostdlib -Wall $(DEFINES) $(ARMFLAGS)
LFLAGS=-T linker.ld
# include both the device library and the core
INCLUDES =-I ~/STM32F10x_StdPeriph_Lib_V3.5.0/Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x
INCLUDES+=-I ~/STM32F10x_StdPeriph_Lib_V3.5.0/Libraries/CMSIS/CM3/CoreSupport

# OpenOCD upload
FLASH =-c 'halt'
FLASH+=-c 'sleep 5'
FLASH+=-c 'reset'
FLASH+=-c 'sleep 5'
FLASH+=-c 'flash write_image erase $(PROJECT).bin 0x8000000'
FLASH+=-c 'sleep 5'
FLASH+=-c 'shutdown'


%.o: %.s
	$(CC) $(CFLAGS) $(INCLUDES) -c -o $@ $<

%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -c -o $@ $<

bin: $(PROJECT).bin
$(PROJECT).bin: $(PROJECT).elf
	$(TOOLCHAIN)objcopy -O binary $< $@

elf: $(PROJECT).elf
$(PROJECT).elf: $(OBJS)
	$(CC) $(CFLAGS) $(INCLUDES) $(LFLAGS) -o $@ $^

flash: $(PROJECT).bin
	sudo openocd -f mybuspirate.cfg -f target/stm32f1x.cfg -c init $(FLASH)

.PHONY: clean
clean:
	rm -f *.o *.elf *.bin
