################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
ICallBLE/ble_user_config.obj: C:/Users/asus/AppData/Roaming/SPB_Data/simplelink_cc2640r2_sdk_5_30_00_03/source/ti/blestack/icall/app/ble_user_config.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Arm Compiler - building file: "$<"'
	"C:/Users/asus/AppData/Roaming/SPB_Data/ti-cgt-arm_18.12.5.LTS/bin/armcl" --cmd_file="C:/Users/asus/AppData/Roaming/SPB_Data/simplelink_cc2640r2_sdk_5_30_00_03/source/ti/blestack/config/build_components.opt" --cmd_file="C:/Users/asus/AppData/Roaming/SPB_Data/simplelink_cc2640r2_sdk_5_30_00_03/source/ti/blestack/config/factory_config.opt" --cmd_file="C:/Users/asus/workspace_ccstheia/simple_peripheral_cc2640r2lp_stack_library/TOOLS/build_config.opt" --cmd_file="ccsIncludes.opt"  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=1 --define=DeviceFamily_CC26X0R2 --define=BOARD_DISPLAY_USE_LCD=0 --define=BOARD_DISPLAY_USE_UART=0 --define=BOARD_DISPLAY_USE_UART_ANSI=1 --define=CC2640R2_LAUNCHXL --define=CC26XX --define=CC26XX_R2 --define=ICALL_EVENTS --define=ICALL_JT --define=ICALL_LITE --define=ICALL_MAX_NUM_ENTITIES=6 --define=ICALL_MAX_NUM_TASKS=3 --define=ICALL_STACK0_ADDR --define=MAX_NUM_BLE_CONNS=1 --define=POWER_SAVING --define=STACK_LIBRARY --define=USE_ICALL --define=xdc_runtime_Assert_DISABLE_ALL --define=xdc_runtime_Log_DISABLE_ALL -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="ICallBLE/$(basename $(<F)).d_raw" --obj_directory="ICallBLE" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

ICallBLE/icall_api_lite.obj: C:/Users/asus/AppData/Roaming/SPB_Data/simplelink_cc2640r2_sdk_5_30_00_03/source/ti/blestack/icall/app/icall_api_lite.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Arm Compiler - building file: "$<"'
	"C:/Users/asus/AppData/Roaming/SPB_Data/ti-cgt-arm_18.12.5.LTS/bin/armcl" --cmd_file="C:/Users/asus/AppData/Roaming/SPB_Data/simplelink_cc2640r2_sdk_5_30_00_03/source/ti/blestack/config/build_components.opt" --cmd_file="C:/Users/asus/AppData/Roaming/SPB_Data/simplelink_cc2640r2_sdk_5_30_00_03/source/ti/blestack/config/factory_config.opt" --cmd_file="C:/Users/asus/workspace_ccstheia/simple_peripheral_cc2640r2lp_stack_library/TOOLS/build_config.opt" --cmd_file="ccsIncludes.opt"  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=1 --define=DeviceFamily_CC26X0R2 --define=BOARD_DISPLAY_USE_LCD=0 --define=BOARD_DISPLAY_USE_UART=0 --define=BOARD_DISPLAY_USE_UART_ANSI=1 --define=CC2640R2_LAUNCHXL --define=CC26XX --define=CC26XX_R2 --define=ICALL_EVENTS --define=ICALL_JT --define=ICALL_LITE --define=ICALL_MAX_NUM_ENTITIES=6 --define=ICALL_MAX_NUM_TASKS=3 --define=ICALL_STACK0_ADDR --define=MAX_NUM_BLE_CONNS=1 --define=POWER_SAVING --define=STACK_LIBRARY --define=USE_ICALL --define=xdc_runtime_Assert_DISABLE_ALL --define=xdc_runtime_Log_DISABLE_ALL -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="ICallBLE/$(basename $(<F)).d_raw" --obj_directory="ICallBLE" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: "$<"'
	@echo ' '


