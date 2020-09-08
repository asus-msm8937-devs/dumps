#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:29902124:926d066de5480577e64566099c82b01770c012df; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:27571496:feb3f29fde44407317271569f4c17c1d5d352983 EMMC:/dev/block/bootdevice/by-name/recovery 926d066de5480577e64566099c82b01770c012df 29902124 feb3f29fde44407317271569f4c17c1d5d352983:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
