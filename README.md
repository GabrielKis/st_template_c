# ST Template C
- [ST Template C](#st-template-c)
  - [Configuration](#configuration)
  - [Compilation](#compilation)
  - [Emulation - Renode](#emulation---renode)
    - [Start Execution and GDB Server on Renode](#start-execution-and-gdb-server-on-renode)
    - [Debug on VSCode](#debug-on-vscode)


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

## Emulation - Renode

To emulate the system is used Renode (version `1.15.2.6132`).

To describe an MCU is used an `.repl` file. They are inside `renode` directory.

To execute the emulation:
```bash
renode --console
```

On the renode console is needed to create an machine:
```bash
mach create
```

Then, it's necessary to load MCU. In this case: (The `@` symbol search for the renode instalation and for the path where the renode is executed)
```bash
machine LoadPlatformDescription @renode/stm32f4.repl
```

To verify if the MCU Platform was load succesfully use:
```bash
peripherals
```
It should show all the peripherals and their address

Use `logLevel` (-1, 0, 1, 2) to change the log verbosity on renode.
```bash
logLevel 0
```

Use `logLevel` (-1, 0, 1, 2) to change the log verbosity on renode. And it's possible to log the functions to see the execution trace
```bash
logLevel 0
sysbus.cpu LogFunctionNames true
```

Finally, it's necessary to load the binary on the machine and then start.
```bash
sysbus LoadELF @build/st_c_template.elf
```

NOTE: It's possible (and better) to run all these Renode commands on a script. The script is: `renode/stm32f4.resc`

The below command automates the execution of all commands above.
```bash
renode --console renode/stm32f4.resc
```

### Start Execution and GDB Server on Renode
```bash
machine StartGdbServer 3333
```

To debug on GDB command line execute:
```bash
arm-none-eabi-gdb build/st_c_template.elf
```

### Debug on VSCode

It was created an debug profile on VSCode on `.vscode` named `Debug application in Renode`. 


Notes:
* It's possible to configure GDB on some TCP port and debug it on GDB outside.
* It's possible to configure UART/USART to show data received (Prints and IHM should be helpfull).
* In order to avoid writing this commands all time, it can be used an `.resc` file to automate this.
* It's possible to write integration tests on Robot to execute some hardware related reoutines.
* If the `.repl` file does not exist, it should be created one. With this created file, all the peripherals implementation will not be implemented and, if used, should be implemented.
* Documentation about Renode is on: [Renode Documentation](https://renode.readthedocs.io/en/latest/introduction/demo.html)