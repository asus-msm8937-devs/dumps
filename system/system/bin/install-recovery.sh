#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:39161132:86204b227c2a05b7c81ab9e808d95848df0bb081; then
  applypatch  EMMC:/dev/block/bootdevice/by-name/boot:32347432:bd5b92a2b8381888b2d70c550790e27914c7849f EMMC:/dev/block/bootdevice/by-name/recovery 86204b227c2a05b7c81ab9e808d95848df0bb081 39161132 bd5b92a2b8381888b2d70c550790e27914c7849f:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
