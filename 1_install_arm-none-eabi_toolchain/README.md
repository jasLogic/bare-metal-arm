# Installing the arm-none-eabi toolchain (on Linux)

## Installing the binaries

To download the binaries go to [this](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads)
site and download the archive corresponding to your OS. Extract the archive and move it to a directory of your choice

```
$ tar -xvf gcc-arm-none-eabi-*-yyyy-qx-major-linux.tar.bz2
$ mv gcc-arm-none-eabi-*-yyyy-qx-major-linux.tar.bz2 ARM
```

After this you can (for convienience) add the `bin` folder to your path

```
export PATH=$PATH:$install_dir/gcc-arm-none-eabi-*/bin
```
