#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:38827308:fd9f5c2f39e71699acf330b858eca083b016491f; then
  applypatch  EMMC:/dev/block/bootdevice/by-name/boot:32376104:698e577d5c54ebcf434a2f42f7ed8c08f88305ba EMMC:/dev/block/bootdevice/by-name/recovery fd9f5c2f39e71699acf330b858eca083b016491f 38827308 698e577d5c54ebcf434a2f42f7ed8c08f88305ba:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
