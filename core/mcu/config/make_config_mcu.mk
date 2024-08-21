MCU_CONFIG_DIR = core/mcu/config

# Add inputs and outputs from these tool invocations to the build variables 
MCU_CONFIG_C_SRCS = \
$(MCU_CONFIG_DIR)/stm32f4xx_hal_msp.c \
$(MCU_CONFIG_DIR)/stm32f4xx_it.c \
$(MCU_CONFIG_DIR)/syscalls.c \
$(MCU_CONFIG_DIR)/sysmem.c \
$(MCU_CONFIG_DIR)/system_stm32f4xx.c 

# Create list of object files based on C_SRCS
OBJS += $(patsubst %.c,build/%.o,$(MCU_CONFIG_C_SRCS))

MCU_CONFIG_INC = -Icore/mcu/config -Icore/mcu/CMSIS/Include \
			-Icore/app \
			-Icore/mcu/CMSIS/Device/ST/STM32F4xx/Include \
			-Icore/mcu/STM32F4xx_HAL_Driver/Inc \
			-Icore/mcu/STM32F4xx_HAL_Driver/Inc/Legacy

MCU_CONFIG_CFLAGS = -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F401xC \
				-O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP \
				--specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb

# Each subdirectory must supply rules for building sources it contributes
build/$(MCU_CONFIG_DIR)/%.o build/$(MCU_CONFIG_DIR)/%.su: $(MCU_CONFIG_DIR)/%.c
	@mkdir -p build/$(MCU_CONFIG_DIR)
	arm-none-eabi-gcc $(MCU_CONFIG_CFLAGS) $(MCU_CONFIG_INC) -c "$<" -MF"$(@:%.o=%.d)" -MT"$@" -o "$@"

clean: clean-config-mcu

clean-config-mcu:
	-$(RM) build/$(MCU_CONFIG_DIR)

.PHONY: clean-config-mcu

