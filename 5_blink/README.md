# Blinking a LED

## Explanation
See the [RM0008 Reference manual](https://www.st.com/content/ccc/resource/technical/document/reference_manual/59/b9/ba/7f/11/af/43/d5/CD00171190.pdf/files/CD00171190.pdf/jcr:content/translations/en.CD00171190.pdf) for all the register information.

### RCC_APB2ENR
This register enables the clocks on many peripherals which clock the values
in the registers into the peripheral.
bit 4 enables GPIO port C so it is set to 1.

### GPIOC_CRH
The `GPIOC_CRH` register configures the high GPIOs (there is a GPIOC_CRL).
See the [RM0008 Reference manual](https://www.st.com/content/ccc/resource/technical/document/reference_manual/59/b9/ba/7f/11/af/43/d5/CD00171190.pdf/files/CD00171190.pdf/jcr:content/translations/en.CD00171190.pdf) on pages 161 and 172 for more information.
In the code I configure `PC13` (the onboard LED) to be a output.

### GPIOC_BSRR
This register sets GPIOs in the lower 16 bits and clears them in the higher 16.
We want to blink `PC13` so I set bit 13 to 1. We could clear `PC13` with a 1 on
bit 29 (16 + 13) but I was to lazy to do this.

### GPIOC_BRR
This register is basically like the higher 16 bits of `GPIOC_BSRR`.
When `PC13` is reset we need to write a 1 to bit 13.

## Compile, Link and Copy
### Compile
```
$ arm-none-eabi-as -mcpu=cortex-m3 -mfloat-abi=soft -mthumb -o main.o main.s
```

### Link
```
$ arm-none-eabi-ld -T linker.ld -o main.elf main.o
```

### Copy
```
$ arm-none-eabi-objcopy -O binary main.elf main.bin
```

## Upload
### Start OpenOCD
```
$ sudo openocd -f mybuspirate.cfg -f target/stm32f1x.cfg
```

### Connect via telnet
```
$ telnet localhost 4444
```

### Halt, Reset and Flash
```
> halt
> reset
> flash write_image erase main.bin 0x8000000
```
You now need to reset the board manually.
