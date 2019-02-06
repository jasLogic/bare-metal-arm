# Blinking a LED in C

## Explanation
For a great explanation on how most of the code works read [this](http://www.bravegnu.org/gnu-eprog/). It is a great tutorial which explains assembler and linker, especially
chapter 10.
scripts.

### startup.s
Because the RAM is cleared with power down, initialized data needs to be
stored in flash memory. But when the data is used, it is used in the RAM
so we need to copy data from flash to RAM. Read only data does not need to
be copied, because it is only read and not used. Uninitialized data
does not need to be copied because it is uninitialized but the C standard
ensures that uninitialized data is initialized to zero so we need to
write 0 to it.

The first thing the reset program does is copy all initialized data
into RAM into the `.data` section. Initialized data is located at `__etext`
behind the code and read only data in flash. It copies all data to `__data_start__`,
which is located in RAM, until `__data_end__` is reached.

After that the program writes zeros to the uninitialized data. This section
is called `.bss` and located behind `.data` in flash.
It writes zeros from `__bss_start__` until `__bss_end__` is reached.

Also notice at the bottom that the `default` handler now is a weak function.
There is also a macro, which declares all other handler functions as
weak and points them to `default`. This way we can just add a handler function
and the weak macro would be overwritten.

### linker.ld
The only thing to notice in the `.text` section is the new `.rodata` link and
that the linker defines `__etext` which must be aligned.

The next new section is `.data` where all initialized data is written.
The script also defines `__data_start__` and `__data_end__`.

The last section is `.bss` for uninitialized data. `__bss_start__` and
`__bss_end__` are defined here.

## Compile, Link and Copy
### Compile and Link
**Important:** If you don't use the `-nostdlib` flag the compilation
is going to fail because the standard library needs many special
memory regions linked to them. I cover this in another part.

```
$ arm-none-eabi-gcc -nostdlib -Wall -mcpu=cortex-m3 -mfloat-abi=soft -mthumb -o main.elf -T linker.ld startup.s main.c
```
### Inspecting the executable
We can insect the executable with `arm-none-eabi-nm` to see if all
data sections were linked correctly:

```
08000000 T _isr_vector
08000044 T reset
0800004a t cloop
08000060 t zloop
0800006e W busfault_handler         \
0800006e W debugmonitor_handler     |
0800006e W default                  |
0800006e W hardfault_handler        |
0800006e W memmanage_handler         \ they are all located at 0x800006e where
0800006e W nmi_handler               / the default handler is
0800006e W pendsv_handler           |
0800006e W svc_handler              |
0800006e W systick_handler          |
0800006e W usagefault_handler       /
08000084 T main
080000e8 t ro_data                  <- read only data is directly behind code
080000ec T __etext                  <- the end of .text section
20000000 D __data_start__
20000000 d initialized_data         <- between __data_start__ and __data_end__
20000004 B __bss_start__            <- __data_end__ and __bss_start__ have
20000004 D __data_end__                the same address
20000004 b uninitialized_data       <- between __bss_start__ and __bss_end__
20000008 B __bss_end__
20005000 B __StackTop
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
