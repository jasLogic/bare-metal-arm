# bare-metal-arm
Getting started with ARM using OpenOCD and the BusPirate

| Disclaimer |
|:----------:|
| I am no expert whatsoever. I created this repository mainly do document my process and help others who try to get started with ARM programming. The code and knowledge came mainly from reading online and looking into the example files of the arm toolchain. Any help, suggestions or criticism are welcome. |

This repository documents my progress with learning about ARM microcontrollers,
the arm-none-eabi toolchain, OpenOCD and the Bus Pirate. I created it as a
reference for others who try to learn the bare-metal basics.

I am using a STM32F103C8 microcontroller (the "bluepill") with a
Bus Pirate v3.

**TODO**
  1. How to install arm-none-eabi toolchain
  2. Installing OpenOCD
  6. Blinking in C
  7. Setting up a Makefile
  8. Using the Standard Library

## Online sources
**Some useful pieces of documentation which helped me get started**
* [This was the most informive website on ARM I could find. Read this before doing anything else.](http://www.bravegnu.org/gnu-eprog/)
* [This](https://sourceware.org/binutils/docs/as/) website and especially [this](https://sourceware.org/binutils/docs/as/ARM-Directives.html) page are a great manual on ARM assembly
* [You should of course read the OpenOCD manual](http://openocd.org/doc/pdf/openocd.pdf)
* [OpenOCD commands](http://www.openocd.org/doc/html/General-Commands.html) and [Flash commands](http://www.openocd.org/doc/html/Flash-Commands.html)
* [A great blog post on how to use and connect the BusPirate](https://research.kudelskisecurity.com/2014/05/01/jtag-debugging-made-easy-with-bus-pirate-and-openocd/)
* [This StackOverlow question](https://stackoverflow.com/questions/38033130/how-to-use-the-gdb-gnu-debugger-and-openocd-for-microcontroller-debugging-fr) had some good information (especially the part with the Makefile)
* [This Article is very informative](https://www.embedded.com/design/mcus-processors-and-socs/4007119/Building-Bare-Metal-ARM-Systems-with-GNU-Part-1--Getting-Started)
* [STM32F103x8 datasheet](https://www.st.com/resource/en/datasheet/stm32f103tb.pdf)
* [RM0008 Reference manual](https://www.st.com/content/ccc/resource/technical/document/reference_manual/59/b9/ba/7f/11/af/43/d5/CD00171190.pdf/files/CD00171190.pdf/jcr:content/translations/en.CD00171190.pdf)
