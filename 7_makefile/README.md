# Makefile

This makefile can be used to compile, link, copy and upload the program of
part 6. I will use this makefile as a template in the future.

Just compile and link the elf executable:
```
$ make elf
```

Compile, link and copy to bin:
```
$ make bin
```

Same as `make bin` but this one starts OpenOCD with the commands to flash:
```
$ make flash
```

Remove all .o, .elf, and .bin files:
```
$ make clean
```
