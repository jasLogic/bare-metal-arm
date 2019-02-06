# First Program and Linkerscript

## Connecting the Bus Pirate to the STM32F103x8
According to [this table for Bus Pirate to JTAG](http://dangerousprototypes.com/docs/Bus_Pirate_JTAG_connections_for_OpenOCD)
and [the STM32F103x8 datasheet](https://www.st.com/resource/en/datasheet/stm32f103tb.pdf)
(page 28-33) we connect the Bus Pirate to the microcontroller like this:

| Bus Pirate | JTAG  | STM32f1x |
|------------|-------|----------|
| VPU        | VTref | 3v3      |
| GND        | GND   | GND      |
| MOSI       | TDI   | PA15     |
| MISO       | TDO   | PB3      |
| CLK        | TCK   | PA14     |
| CS         | TMS   | PA13     |
| AUX        | SRST  | PB4      |

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

## Check with GDB
```
$ arm-none-eabi-gdb
```

## Connect to remote
```
(gdb) target remote localhost:3333
```

## Step and view registers
For this to work you firstly need to `halt` the execution in the telnet session.
```
(gdb) info registers
(gdb) stepi
(gdb) info registers
```
You often need `stepi` another time because of the branch instruction which needs one instruction cycle.

Ideally your output should look like this:
```
(gdb) info registers
r0             0x6da53f            7185727
r1             0x2a                42
    (...)
sp             0x20005000          0x20005000
    (...)
pc             0x8000048           0x8000048
    (...)
(gdb) stepi
0x0800004c in ?? ()
(gdb) info registers
r0             0x6da540            7185728
r1             0x2a                42
    (...)
sp             0x20005000          0x20005000
    (...)
pc             0x800004c           0x800004c
    (...)
```
Notice that r0 incremented by one and that r1 is 42 which we set in main.s.
Also take a look at the sp (stack pointer), it has the value which we defined
at address `0x8000000` with `__StackTop`.
Another interesting thing to know is the pc (program counter).
Its value is always the address of the instrucion which is executed at the time.
