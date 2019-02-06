# Updating the Bus Pirate and setting up OpenOCD

## Updating the Bus Pirate

Since most Bus Pirates are shipped with old firmware, we need to update to at
least version 5.8 for OpenOCD to work. You also need to enable OpenOCD support
in some versions. See [this](http://dangerousprototypes.com/docs/Bus_Pirate#JTAG_and_OpenOCD) table:

| Version       | Banner                | Works?   |
|---------------| ----------------------|----------|
| 6.1           | Firmware v6.1 r1676   | Enabled  |
| 6.0           | Firmware v6.0 r1625   | Enabled  |
| 5.10          | Firmware v5.10 (r559  | Disabled |
| 5.9-extras    | Firmware v5.9 (r529)  | Disabled |
| 5.9           | Firmware v5.9 (r539)  | Disabled |
| 5.8           | Firmware v5.8 (r504)  | Enabled  |
| robots custom | Firmware v6.0RC (r572)| Enabled  |

The most simple way to update the firmware is to just clone the
[GitHub repository](https://github.com/BusPirate/Bus_Pirate) and use
the precompiled hex with the pirate-loader program.

### Cloning
```
$ git clone https://github.com/BusPirate/Bus_Pirate.git
```

### Putting the Bus Pirate into Bootloader mode

Check what port the Bus Pirate is on (in my case /dev/ttyUSB0) and setup a
serial terminal.
```
$ sudo screen /dev/ttyUSB0 115200
```
In the serial terminal we put the Bus Pirate into Bootloader mode
```
HiZ>$
Are you sure? y
BOOTLOADER
```
After this it is very important to **close the serial terminal again** because
the pirate-loader needs the connection.

### Updating

Now go into the `BusPirate/package/BPvx-firmware/` directory, with
x being the version of your Bus Pirate, I have a Bus Pirate v3. Than you could use
the precompiled `pirate-loader_lnx` program. This did not work for me,
so I went into the `pirate-loader-source` and build the program myself.
```
$ cd BusPirate/package/BPv3-firmware/pirate-loader-source
$ chmod +x build-unix.sh
$ ./build-unix.sh
```
Now you can just run the `pirate-loader_lnx` and hope that everything works well. I just
used the newest firmware I could find.
```
$ ./pirate-loader_lnx --dev=/dev/ttyUSB0 --hex=../BPv3-firmware-v6.3-r2151.hex
```
When you now open a serial terminal again and press i the new firmware
version should be installed.

## Setting up OpenOCD
There are many places where you can store your custom `.cfg` files for
OpenOCD, see [the OpenOCD manual](http://openocd.org/doc/pdf/openocd.pdf).
I created a `.openocd` folder in my home directory, this is a place where
OpenOCD will look for config files.
```
$ mkdir .openocd
$ cd .openocd
```
When you take a look at the [buspirate.cfg](buspirate.cfg) file, which came with OpenOCD,
you can see that there are some options that are commented out. Because I
didn't want to change the file I created my own called
[mybuspirate.cfg](mybuspirate.cfg).

You also need to specify a target or board for OpenOCD. OpenOCD supports many
targets and boards so take a look at the `tcl/board` and `tcl/target`
directories inside of OpenOCD.
When you found you target (in my case `stm32f1x.cfg`) you can run the
OpenOCD command.
```
$ sudo openocd -f mybuspirate.cfg -f target/stm32f1x.cfg
```
