STM_HAL_DIR = core/mcu/STM32F4xx_HAL_Driver

# Add inputs and outputs from these tool invocations to the build variables 
STM_HAL_C_SRCS = \
$(STM_HAL_DIR)/Src/stm32f4xx_hal.c \
$(STM_HAL_DIR)/Src/stm32f4xx_hal_cortex.c \
$(STM_HAL_DIR)/Src/stm32f4xx_hal_dma.c \
$(STM_HAL_DIR)/Src/stm32f4xx_hal_dma_ex.c \
$(STM_HAL_DIR)/Src/stm32f4xx_hal_exti.c \
$(STM_HAL_DIR)/Src/stm32f4xx_hal_flash.c \
$(STM_HAL_DIR)/Src/stm32f4xx_hal_flash_ex.c \
$(STM_HAL_DIR)/Src/stm32f4xx_hal_flash_ramfunc.c \
$(STM_HAL_DIR)/Src/stm32f4xx_hal_gpio.c \
$(STM_HAL_DIR)/Src/stm32f4xx_hal_pwr.c \
$(STM_HAL_DIR)/Src/stm32f4xx_hal_pwr_ex.c \
$(STM_HAL_DIR)/Src/stm32f4xx_hal_rcc.c \
$(STM_HAL_DIR)/Src/stm32f4xx_hal_rcc_ex.c 

# Create list of object files based on C_SRCS
OBJS += $(patsubst %.c,build/%.o,$(STM_HAL_C_SRCS))

STM_HAL_INC = -I$(STM_HAL_DIR)/Inc \
			-I$(STM_HAL_DIR)/Inc/Legacy \
			-Icore/mcu/CMSIS/Device/ST/STM32F4xx/Include \
			-Icore/mcu/CMSIS/Include \
			-Icore/mcu/config

STM_HAL_CFLAGS = -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F401xC \
			-O0 -ffunction-sections -fdata-sections -Wall -fstack-usage \
			-MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" \
			--specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb

# Each subdirectory must supply rules for building sources it contributes
build/$(STM_HAL_DIR)/Src/%.o build/$(STM_HAL_DIR)/Src/%.su: $(STM_HAL_DIR)/Src/%.c
	@mkdir -p build/$(STM_HAL_DIR)/Src
	arm-none-eabi-gcc $(STM_HAL_CFLAGS) $(STM_HAL_INC) -c "$<" -o "$@"

clean: clean-Drivers-2f-STM32F4xx_HAL_Driver-2f-Src

clean-Drivers-2f-STM32F4xx_HAL_Driver-2f-Src:
	-$(RM) build/$(STM_HAL_DIR)

.PHONY: clean-Drivers-2f-STM32F4xx_HAL_Driver-2f-Src

