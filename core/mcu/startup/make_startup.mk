STARTUP_DIR = core/mcu/startup

# Add inputs and outputs from these tool invocations to the build variables 
STARTUP_S_SRCS = \
$(STARTUP_DIR)/startup_stm32f401ccux.s 

# Create list of object files based on S_SRCS
OBJS += $(patsubst %.s,build/%.o,$(STARTUP_S_SRCS))

STARTUP_CFLAGS = -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP \
			--specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb \
			-MF"$(@:%.o=%.d)" -MT"$@"

# Each subdirectory must supply rules for building sources it contributes
build/$(STARTUP_DIR)/%.o: $(STARTUP_DIR)/%.s
	@mkdir -p build/$(STARTUP_DIR)
	arm-none-eabi-gcc $(STARTUP_CFLAGS) -o "$@" "$<"

clean: clean-startup

clean-startup:
	-$(RM) build/$(STARTUP_DIR)

.PHONY: clean-startup

