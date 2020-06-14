#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:35956012:84a29e499c83b125e09a448824781b5917f7f234; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:33662248:344a1b30d100b4165d9d1cc46637103abd34520b EMMC:/dev/block/bootdevice/by-name/recovery 84a29e499c83b125e09a448824781b5917f7f234 35956012 344a1b30d100b4165d9d1cc46637103abd34520b:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
