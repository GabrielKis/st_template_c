# ST Template C

This repository contains an template project for an STM32F4XX MCU without the use of STM32 Cube IDE. In future commits it's interesting to configure this repository for Windows systems.

## Configuration

In order to cross-compile the code it's necessary to install GCC Arm Compiler:

```
sudo apt-get install gcc-arm-linux-gnueabihf
```

## Compilation

To compile the project, just execute:

```bash
make all
```

To clean the compilation:
```bash
make clean
```

The compilation output is located on `build`.
