# Using the STM32F10x standard peripheral library
**Note** that I did not use the ARM standard library in this example, the
`-nostdlib` flag is set.

## Changes in startup.s
Like in many examples and in the STM32F10x standard peripheral library I
added a `SystemInit` function which sets the system clock to its reset value.
The function is weak and can thus be overwritten by another `SystemInit`
function in C code.

I also added all the other interrupts found in the startup example code
of the STM32F10x standard peripheral library.

## Changes in main.c
The STM32F10x standard peripheral library header is included.
The `SET_BIT` and `CLEAR_BIT` macros are defined in the library:
```
#define SET_BIT(REG, BIT)   ((REG) |= (BIT))
#define CLEAR_BIT(REG, BIT) ((REG) &= ~(BIT))
```

There now is a `SystemInit` function which runs before main and overwrites
the `SystemInit` function in `startup.s`.
It configures the system clock to use the external oscillator and sets the
PLL in a way that the system clock runs on 72 MHz (the maximum).

In the `main` function I setup a GPIOB pin as an input with a pullup.
The loop just checks if PB12 is high and sets the PC13 (LED) accordingly.

## Changes in the Makefile
I added -D  `STM32F10X_MD` to the `DEFINES` because the STM32F10x standard
peripheral library needs this information.
There also is a `INCLUDES` variable which adds the paths of two directories
where the STM32F10x standard peripheral library is located.

## The standard peripheral driver library
In this example I am only including the CMIS library. You could easily
also include the peripheral driver library by, of course, including
it into your project and adding it to the path in the `Makefile` like this:
```
INCLUDES+=-I ~/STM32F10x_StdPeriph_Lib_V3.5.0/Libraries/STM32F10x_StdPeriph_Driver/inc
```
