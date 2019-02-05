# First Program and Linkerscript

## Compile, Link and Copy

### Compile
```
arm-none-eabi-as -mcpu=cortex-m3 -mfloat-abi=soft -mthumb -o main.o main.s
```

### Link
```arm-none-eabi-ld -T linker.ld -o main.elf main.o```

### Copy
```arm-none-eabi-objcopy -O binary main.elf main.bin```

## Upload

### Start OpenOCD
```sudo openocd -f mybuspirate.cfg -f target/stm32f1x.cfg```

### Connect via telnet
```telnet localhost 4444```

### Halt, Reset and Flash
```
halt
reset
flash write_image erase main.bin 0x8000000
```
