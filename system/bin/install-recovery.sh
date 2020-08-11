#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:35480876:0817fa73ddd7eef0fbf658d9d6750973b20b6151; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:30596392:b6307f05c38505e5a4af6bbd1a0eac8ffa807866 EMMC:/dev/block/bootdevice/by-name/recovery 0817fa73ddd7eef0fbf658d9d6750973b20b6151 35480876 b6307f05c38505e5a4af6bbd1a0eac8ffa807866:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
