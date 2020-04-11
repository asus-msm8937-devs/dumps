#!/system/bin/sh
if ! applypatch --check EMMC:/dev/block/bootdevice/by-name/recovery:39550252:399e028c8e3335577397eb13547f7c06d1cb356b; then
  applypatch  \
          --patch /system/recovery-from-boot.p \
          --source EMMC:/dev/block/bootdevice/by-name/boot:33152296:ba00ecc190558cf0569761ff96f1ec266b639c89 \
          --target EMMC:/dev/block/bootdevice/by-name/recovery:39550252:399e028c8e3335577397eb13547f7c06d1cb356b && \
      log -t recovery "Installing new recovery image: succeeded" || \
      log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
