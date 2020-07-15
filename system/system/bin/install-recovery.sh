#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:37360940:02b7dee6066e2f186aab70accdf590306e736ce2; then
  applypatch  EMMC:/dev/block/bootdevice/by-name/boot:30545192:529216803215e839a3379215eda50111a8a268bd EMMC:/dev/block/bootdevice/by-name/recovery 02b7dee6066e2f186aab70accdf590306e736ce2 37360940 529216803215e839a3379215eda50111a8a268bd:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
