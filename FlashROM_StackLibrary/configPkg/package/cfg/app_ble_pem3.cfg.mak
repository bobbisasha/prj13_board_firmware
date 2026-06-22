# invoke SourceDir generated makefile for app_ble.pem3
app_ble.pem3: .libraries,app_ble.pem3
.libraries,app_ble.pem3: package/cfg/app_ble_pem3.xdl
	$(MAKE) -f C:\Users\asus\workspace_ccstheia\prj13_board_firmware\TOOLS/src/makefile.libs

clean::
	$(MAKE) -f C:\Users\asus\workspace_ccstheia\prj13_board_firmware\TOOLS/src/makefile.libs clean

