# bare-metal-arm
Getting started with ARM using OpenOCD and the BusPirate

| Disclaimer |
|:----------:|
| I am no expert whatsoever. I created this repository mainly do document my process and help others who try to get started with ARM programming. The code and knowledge came mainly from reading online and looking into the example files of the arm toolchain. Any help, suggestions or criticism are welcome. |

**TODO**
  1. How to install arm-none-eabi toolchain
  2. Installing OpenOCD
  3. Updating the BusPirate
  4. First Program and Linkerscript (in progress)
  5. Blinking a LED
  6. Blinking in C
  7. Settin up a Makefile
  8. Using the Standard Library

## Online sources
**Some useful pieces of documentation which helped me get started**
* [This was the most informive website on ARM I could find. Read this before doing anything else.](http://www.bravegnu.org/gnu-eprog/)
* [This](https://sourceware.org/binutils/docs/as/) website and especially [this](https://sourceware.org/binutils/docs/as/ARM-Directives.html) page are a great manual on ARM assembly
* [You should of course read the OpenOCD manual](http://openocd.org/doc/pdf/openocd.pdf)
* [OpenOCD commands](http://www.openocd.org/doc/html/General-Commands.html) and [Flash commands](http://www.openocd.org/doc/html/Flash-Commands.html)
* [A great blog post on how to use and connect the BusPirate](https://research.kudelskisecurity.com/2014/05/01/jtag-debugging-made-easy-with-bus-pirate-and-openocd/)
* [This StackOverlow question](https://stackoverflow.com/questions/38033130/how-to-use-the-gdb-gnu-debugger-and-openocd-for-microcontroller-debugging-fr) had some good information (especially the part with the Makefile)
