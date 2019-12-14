#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:30582060:a1de5f4dac6fb080284fb2e9a67d0265bcdec29c; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:28251432:e8cad3f866cc97ab3d2535f56ea3b6544dec3768 EMMC:/dev/block/bootdevice/by-name/recovery a1de5f4dac6fb080284fb2e9a67d0265bcdec29c 30582060 e8cad3f866cc97ab3d2535f56ea3b6544dec3768:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
