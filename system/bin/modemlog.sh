#!/system/bin/sh
#xuyi@wind-mobi.com 20171211 add for BugReporter

log -t savelog_modemlog -p i "modemlog.sh begin"

modemlogsize=`getprop persist.asuslog.modem.size`
modemlogcount=`getprop persist.asuslog.modem.count`
modemlogpath=`getprop persist.asuslog.modem.path`
modemcfgpath=`getprop persist.asuslog.modem.diacfg`

sdcardpath="/sdcard/"
count=1000
while [ ! -d $sdcardpath ] && [ $count -gt 0 ]
do
  ((count--))
  usleep 200000
done

if [ ! -n "$modemlogsize" ]; then
  modemlogsize='200'
fi

if [ ! -n "$modemlogcount" ]; then
  modemlogcount='3'
fi 

if [ ! -n "$modemlogpath" ]; then
  log -t savelog_modemlog -p i "path 1"
  modemlogpath='/sdcard/Asuslog/Modem'
else
   if [ ! -d "$modemlogpath" ]; then
     log -t savelog_modemlog -p i "path 2"
	 setprop persist.asuslog.modem.path /sdcard/Asuslog/Modem
 	 modemlogpath='/sdcard/Asuslog/Modem'
	 if [ ! -f "$modemlogpath" ]; then
		mkdir -p $modemlogpath
     else
		rm -r $modemlogpath
		mkdir -p $modemlogpath
	 fi
   fi
fi

if [ ! -n "$modemcfgpath" ]; then
  log -t savelog_modemlog -p i "cfgpath 1"
  modemcfgpath='/system/etc/modem_and_audio.cfg'
  setprop persist.asuslog.modem.diacfg "/system/etc/modem_and_audio.cfg"
fi 

if [ "$modemcfgpath" = "/system/etc/Diag.cfg" ]; then
    log -t savelog_modemlog -p i "run Diag.cfg begin"
	/system/bin/raw_sender 0x4b 0x12 0x21 0x0d  0xc8 0x00 0x00 0x00  0x00 0x20 0x00 0x00
	/system/bin/diag_mdlog -f $modemcfgpath -o $modemlogpath/modem_audio_gps -s $modemlogsize -n $modemlogcount -c
	log -t savelog_modemlog -p i "run Diag.cfg end"
elif [ "$modemcfgpath" = "/system/etc/modem_and_audio.cfg" ]; then
    log -t savelog_modemlog -p i "run modem_and_audio.cfg begin"
	/system/bin/raw_sender 0x4b 0x12 0x21 0x0d  0xc8 0x00 0x00 0x00  0x00 0x20 0x00 0x00
    /system/bin/diag_mdlog -f $modemcfgpath -o $modemlogpath/modem_audio -s $modemlogsize -n $modemlogcount -c
	log -t savelog_modemlog -p i "run modem_and_audio.cfg end"
elif [ "$modemcfgpath" = "/system/etc/gps.cfg" ]; then
    log -t savelog_modemlog -p i "run gps.cfg begin"
	/system/bin/raw_sender 0x4b 0x12 0x21 0x0d  0xc8 0x00 0x00 0x00  0x00 0x20 0x00 0x00
    /system/bin/diag_mdlog -f $modemcfgpath -o $modemlogpath/gps -s $modemlogsize -n $modemlogcount -c
	log -t savelog_modemlog -p i "run gps.cfg end"
elif [ "$modemcfgpath" = "/system/etc/audio.cfg" ]; then
    log -t savelog_modemlog -p i "run audio.cfg begin"
	/system/bin/raw_sender 0x4b 0x12 0x21 0x0d  0xc8 0x00 0x00 0x00  0x00 0x20 0x00 0x00
    /system/bin/diag_mdlog -f $modemcfgpath -o $modemlogpath/audio -s $modemlogsize -n $modemlogcount -c
	log -t savelog_modemlog -p i "run audio.cfg end"
elif [ "$modemcfgpath" = "/system/etc/Compact_mode.cfg" ]; then
    log -t savelog_modemlog -p i "run Compact_mode.cfg begin"
	/system/bin/raw_sender 0x4b 0x12 0x21 0x0d  0x20 0xbf 0x02 0x00  0x00 0x00 0x10 0x00
	/system/bin/diag_mdlog -f $modemcfgpath -o $modemlogpath/compact -s $modemlogsize -n $modemlogcount -c
	log -t savelog_modemlog -p i "run Compact_mode.cfg end"
elif [ "$modemcfgpath" = "/system/etc/wifi_bt.cfg" ]; then
    log -t savelog_modemlog -p i "run wifi_bt.cfg begin"
	#/system/bin/raw_sender 0x4b 0x12 0x21 0x0d  0x20 0xbf 0x02 0x00  0x00 0x00 0x10 0x00
	/system/bin/diag_mdlog -f $modemcfgpath -o $modemlogpath/wifi_bt -s $modemlogsize -n $modemlogcount -c
	log -t savelog_modemlog -p i "run wifi_bt.cfg end"
elif [ "$modemcfgpath" = "/system/etc/fm.cfg" ]; then
    log -t savelog_modemlog -p i "run fm.cfg begin"
	#/system/bin/raw_sender 0x4b 0x12 0x21 0x0d  0x20 0xbf 0x02 0x00  0x00 0x00 0x10 0x00
	/system/bin/diag_mdlog -f $modemcfgpath -o $modemlogpath/fm -s $modemlogsize -n $modemlogcount -c
	log -t savelog_modemlog -p i "run fm.cfg end"
fi
log -t savelog_modemlog -p i "modemlog.sh end"
