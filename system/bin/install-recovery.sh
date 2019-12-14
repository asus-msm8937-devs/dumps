#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:37952812:a06f02fa69cf8d8cc0d5663dfae75e9301309998; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:33080616:f01e8ddd843ded6bfebf2fc79fa2742044ddd444 EMMC:/dev/block/bootdevice/by-name/recovery a06f02fa69cf8d8cc0d5663dfae75e9301309998 37952812 f01e8ddd843ded6bfebf2fc79fa2742044ddd444:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
