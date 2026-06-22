#
_XDCBUILDCOUNT = 
ifneq (,$(findstring path,$(_USEXDCENV_)))
override XDCPATH = C:/Users/asus/AppData/Roaming/SPB_Data/simplelink_cc2640r2_sdk_5_30_00_03/source;C:/Users/asus/AppData/Roaming/SPB_Data/simplelink_cc2640r2_sdk_5_30_00_03/kernel/tirtos/packages;C:/Users/asus/AppData/Roaming/SPB_Data/simplelink_cc2640r2_sdk_5_30_00_03/source/ti/blestack
override XDCROOT = C:/Users/asus/AppData/Roaming/SPB_Data/xdctools_3_51_03_28_core
override XDCBUILDCFG = ./config.bld
endif
ifneq (,$(findstring args,$(_USEXDCENV_)))
override XDCARGS = 
override XDCTARGETS = 
endif
#
ifeq (0,1)
PKGPATH = C:/Users/asus/AppData/Roaming/SPB_Data/simplelink_cc2640r2_sdk_5_30_00_03/source;C:/Users/asus/AppData/Roaming/SPB_Data/simplelink_cc2640r2_sdk_5_30_00_03/kernel/tirtos/packages;C:/Users/asus/AppData/Roaming/SPB_Data/simplelink_cc2640r2_sdk_5_30_00_03/source/ti/blestack;C:/Users/asus/AppData/Roaming/SPB_Data/xdctools_3_51_03_28_core/packages;..
HOSTOS = Windows
endif
