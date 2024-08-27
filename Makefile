RM := rm -rf

TOOLCHAIN = arm-none-eabi

# All of the sources participating in the build are defined here
OBJS := 
S_DEPS := 
S_UPPER_DEPS := 
C_DEPS := 

-include core/mcu/STM32F4xx_HAL_Driver/Src/make_stm_hal.mk
-include core/mcu/startup/make_startup.mk
-include core/mcu/config/make_config_mcu.mk
-include core/app/make_app.mk

BUILD_ARTIFACT_NAME := st_c_template
BUILD_ARTIFACT_EXTENSION := elf
BUILD_ARTIFACT_PREFIX :=
BUILD_ARTIFACT := $(BUILD_ARTIFACT_PREFIX)$(BUILD_ARTIFACT_NAME)$(if $(BUILD_ARTIFACT_EXTENSION),.$(BUILD_ARTIFACT_EXTENSION),)

# Add inputs and outputs from these tool invocations to the build variables 
EXECUTABLE = build/$(BUILD_ARTIFACT_NAME).elf
MAP_FILE = build/$(BUILD_ARTIFACT_NAME).map
SIZE_OUTPUT = default.size.stdout
OBJDUMP_LIST = build/$(BUILD_ARTIFACT_NAME).list

CFLAGS = -mcpu=cortex-m4 \
		-T"STM32F401CCUX_FLASH.ld" \
		--specs=nosys.specs \
		-Wl,-Map="$(MAP_FILE)" \
		-Wl,--gc-sections -static \
		--specs=nano.specs -mfpu=fpv4-sp-d16 \
		-mfloat-abi=hard -mthumb -Wl,--start-group \
		-lc -lm -Wl,--end-group

# All Target
all: main-build

# Main-build Target
main-build: $(EXECUTABLE) secondary-outputs

# Tool invocations
$(EXECUTABLE) $(MAP_FILE): $(OBJS) STM32F401CCUX_FLASH.ld
	$(TOOLCHAIN)-gcc -o $(EXECUTABLE) $(OBJS) $(CFLAGS)
	@echo 'Finished building target: $@'
	@echo ' '

$(SIZE_OUTPUT): $(EXECUTABLE)
	$(TOOLCHAIN)-size  $(EXECUTABLE)
	@echo 'Finished building: $@'
	@echo ' '

$(OBJDUMP_LIST): $(EXECUTABLE)
	$(TOOLCHAIN)-objdump -h -S $(EXECUTABLE) > "$(OBJDUMP_LIST)"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) build
	-@echo ' '

secondary-outputs: $(SIZE_OUTPUT) $(OBJDUMP_LIST)

.PHONY: all clean dependents main-build

-include ../makefile.targets
