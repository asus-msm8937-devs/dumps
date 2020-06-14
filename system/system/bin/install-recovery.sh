#!/system/bin/sh
if ! applypatch --check EMMC:/dev/block/bootdevice/by-name/recovery:39173420:09d4f35b8abb2144f8552bda5f1fa792baaa50b0; then
  applypatch  \
          --patch /system/recovery-from-boot.p \
          --source EMMC:/dev/block/bootdevice/by-name/boot:32077096:ef8dd4a3a652fc2f5d55f5812b4fddae43faa1b2 \
          --target EMMC:/dev/block/bootdevice/by-name/recovery:39173420:09d4f35b8abb2144f8552bda5f1fa792baaa50b0 && \
      log -t recovery "Installing new recovery image: succeeded" || \
      log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
