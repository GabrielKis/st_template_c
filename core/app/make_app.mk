APP_DIR = core/app

# Add inputs and outputs from these tool invocations to the build variables 
APP_C_SRCS = \
$(APP_DIR)/main.c

# Create list of object files based on C_SRCS
OBJS += $(patsubst %.c,build/%.o,$(APP_C_SRCS))

APP_INC = -Icore/mcu/STM32F4xx_HAL_Driver/Inc \
			-Icore/mcu/STM32F4xx_HAL_Driver/Inc/Legacy \
			-Icore/mcu/CMSIS/Device/ST/STM32F4xx/Include \
			-Icore/mcu/CMSIS/Include \
			-Icore/mcu/config

APP_CFLAGS = -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F401xC \
			-O0 -ffunction-sections -fdata-sections -Wall -fstack-usage \
			-MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" \
			--specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb

# Each subdirectory must supply rules for building sources it contributes
build/$(APP_DIR)/%.o build/$(APP_DIR)/%.su: $(APP_DIR)/%.c
	@mkdir -p build/$(APP_DIR)
	arm-none-eabi-gcc $(APP_CFLAGS) $(APP_INC) -c "$<" -o "$@"

clean: clean-app

clean-app:
	-$(RM) build/$(APP_DIR)

.PHONY: clean-app

