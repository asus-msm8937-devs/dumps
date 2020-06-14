#!/system/bin/sh

########################################################
# savelogs.sh
########################################################
# xuyi@wind-mobi.com 20171211 add for BugReporter
########################################################


########################################################
# Folder and property configuration
########################################################
#MODEM_LOG
MODEM_LOG=/data/media/0/ASUS/LogUploader/modem
#MODEM_LOG=/sdcard/ASUS/LogUploader/modem
#TCP_DUMP_LOG
TCP_DUMP_LOG=/data/media/0/ASUS/LogUploader/TCPdump
WD_TCP_DUMP_LOG=/data/media/0/TCPLOG
#TCP_DUMP_LOG=/sdcard/ASUS/LogUploader/TCPdump
#GENERAL_LOG
GENERAL_LOG=/data/media/0/ASUS/LogUploader/general/sdcard
LOGCAT_LOG=/data/media/0/LOGCAT/logcat_log
LOGCAT_LOG_BACKUP=/data/media/0/LOGCAT/logcat_log_backup
WD_MODEM_LOG=/data/media/0/diag_logs
#GENERAL_LOG=/sdcard/ASUS/LogUploader/general/sdcard
#Dumpsys folder
#DUMPSYS_DIR=/data/media/0/ASUS/LogUploader/dumpsys

savelogs_prop=`getprop persist.asus.savelogs`
is_tcpdump_status=`getprop init.svc.tcpdump-warp`
modem_prop=`getprop persist.asuslog.qxdmlog.enable`
startlogcat=`getprop persist.asus.startlogcat`
enable_tcpdump=`getprop persist.asus.enabletcp`


########################################################
# Save general logs
########################################################
save_general_log() {
    log -t savelog -p i "save_general_log() begin"
	
	setprop persist.asus.startlogcat 0
		
	# save cmdline
	cat /proc/cmdline > $GENERAL_LOG/cmdline.txt
	echo "cat /proc/cmdline > $GENERAL_LOG/cmdline.txt"	
	# save mount table
	cat /proc/mounts > $GENERAL_LOG/mounts.txt
	echo "cat /proc/mounts > $GENERAL_LOG/mounts.txt"
	# save getenforce
	getenforce > $GENERAL_LOG/getenforce.txt
	echo "getenforce > $GENERAL_LOG/getenforce.txt"
	# save property
	getprop > $GENERAL_LOG/getprop.txt
	echo "getprop > $GENERAL_LOG/getprop.txt"
	# save network info
	cat /proc/net/route > $GENERAL_LOG/route.txt
	echo "cat /proc/net/route > $GENERAL_LOG/route.txt"
	netcfg > $GENERAL_LOG/ifconfig.txt
	echo "ifconfig -a > $GENERAL_LOG/ifconfig.txt"
	# save software version
	log -t savelog -p i "save software version begin"
	echo "AP_VER: `getprop ro.build.display.id`" > $GENERAL_LOG/version.txt
	echo "CP_VER: `getprop gsm.version.baseband`" >> $GENERAL_LOG/version.txt
	echo "BT_VER: `getprop bt.version.driver`" >> $GENERAL_LOG/version.txt
	echo "WIFI_VER: `getprop wifi.version.driver`" >> $GENERAL_LOG/version.txt
	echo "GPS_VER: `getprop gps.version.driver`" >> $GENERAL_LOG/version.txt
	echo "BUILD_DATE: `getprop ro.build.date`" >> $GENERAL_LOG/version.txt
	# save load kernel modules
	lsmod > $GENERAL_LOG/lsmod.txt
	echo "lsmod > $GENERAL_LOG/lsmod.txt"
	# save process now
	ps >  $GENERAL_LOG/ps.txt
	echo "ps > $SAVE_LOG_PATH/ps.txt"
	ps -t -p > $GENERAL_LOG/ps_thread.txt
	echo "ps > $SAVE_LOG_PATH/ps_thread.txt"
	# save kernel message
	dmesg > $GENERAL_LOG/dmesg.txt
	echo "dmesg > $GENERAL_LOG/dmesg.txt"
	# copy data/tombstones to data/media
	ls -R -l /data/tombstones/ > $GENERAL_LOG/ls_data_tombstones.txt
	mkdir $GENERAL_LOG/tombstones
	cp /data/tombstones/* $GENERAL_LOG/tombstones/
	echo "cp /data/tombstones $GENERAL_LOG"	
	# copy Debug Ion information to data/media
	mkdir $GENERAL_LOG/ION_Debug
	cp -r /d/ion/* $GENERAL_LOG/ION_Debug/

    ################################################
	# Move logcat, kernel, main logs to $GENERAL_LOG
	################################################
	# sample to move logcat & radio
	log -t savelog -p i "copy logcat_log begin"
	if [ -d "$LOGCAT_LOG" ]; then
	    log -t savelog -p i "copy logcat_log begin in"
		#setprop persist.asus.startlogcat 0
		startlogcat=`getprop persist.asus.startlogcat`
		log -t savelog -p i "11 persist.asus.startlogcat=$startlogcat"
		#mv $LOGCAT_LOG/$x.txt $LOGCAT_LOG/$x.txt.0
		#start $x
		#mv /data/logcat_log/$x.txt.* $GENERAL_LOG/logcat_log
		mv $LOGCAT_LOG/* $GENERAL_LOG
		#setprop persist.asus.startlogcat 1
		startlogcat=`getprop persist.asus.startlogcat`
		log -t savelog -p i "22 persist.asus.startlogcat=$startlogcat"
	fi
	
	if [ -d "$LOGCAT_LOG_BACKUP" ]; then
			mv $LOGCAT_LOG_BACKUP/* $GENERAL_LOG
	fi
	log -t savelog -p i "copy logcat_log end"
	
	# copy /asdf/ASUSEvtlog.txt to ASDF
	#cp -r /sdcard/asus_log/ASUSEvtlog.txt $GENERAL_LOG #backward compatible
	#cp -r /sdcard/asus_log/ASUSEvtlog_old.txt $GENERAL_LOG #backward compatible
	#cp -r /asdf/ASUSEvtlog.txt $GENERAL_LOG
	#cp -r /asdf/ASUSEvtlog_old.txt $GENERAL_LOG
	#cp -r /asdf/ASDF $GENERAL_LOG
	#echo "cp -r /asdf/ASUSEvtlog.txt $GENERAL_LOG"
	
	# copy WiFi info
	log -t savelog -p i "copy WiFi info begin"
	ls -R -l /data/misc/wifi/ > $GENERAL_LOG/ls_wifi_asus_log.txt
	cp -r /data/misc/wifi/wpa_supplicant.conf $GENERAL_LOG
	echo "cp -r /data/misc/wifi/wpa_supplicant.conf $GENERAL_LOG"
	cp -r /data/misc/wifi/hostapd $GENERAL_LOG
	echo "cp -r /data/misc/wifi/hostapd $GENERAL_LOG"
	cp -r /data/misc/wifi/p2p_supplicant.conf $GENERAL_LOG
	echo "cp -r /data/misc/wifi/p2p_supplicant.conf $GENERAL_LOG"
	
	# mv /data/anr to data/media
	ls -R -l /data/anr > $GENERAL_LOG/ls_data_anr.txt
	mkdir $GENERAL_LOG/anr
	cp /data/anr/* $GENERAL_LOG/anr/
	echo "cp /data/anr $GENERAL_LOG/anr/"
	
    date > $GENERAL_LOG/date.txt
	echo "date > $GENERAL_LOG/date.txt"

	# save dumpstate report
	echo "dumpstate -q > $GENERAL_LOG/dumpstate.txt"
        dumpstate -q > $GENERAL_LOG/dumpstate.txt

	# Save microp_dump
    micropTest=`cat /sys/class/switch/pfs_pad_ec/state`
	if [ "${micropTest}" = "1" ]; then
	    date > $GENERAL_LOG/microp_dump.txt
	    cat /d/gpio >> $GENERAL_LOG/microp_dump.txt                   
        echo "cat /d/gpio > $GENERAL_LOG/microp_dump.txt"  
        cat /d/microp >> $GENERAL_LOG/microp_dump.txt
        echo "cat /d/microp > $GENERAL_LOG/microp_dump.txt"
	fi
	
	# Save df info
	df > $GENERAL_LOG/df.txt
	echo "df > $GENERAL_LOG/df.txt"
	log -t savelog -p i "save_general_log() end"
}



########################################################
# Save modem logs
########################################################
save_modem_log() {
    log -t savelog -p i "save_modem_log begin"
	if [ -d "$WD_MODEM_LOG" ]; then
	    log -t savelog -p i "copy modem_log begin in"
		setprop persist.asus.startmodem 0
		startmodem=`getprop persist.asus.startmodem`
		log -t savelog -p i "11 persist.asus.startmodem=$startmodem"
		mv $WD_MODEM_LOG/ $MODEM_LOG/
		setprop persist.asus.startmodem 1
		startmodem=`getprop persist.asus.startmodem`
		log -t savelog -p i "22 persist.asus.startmodem=$startmodem"
	fi
	log -t savelog -p i "copy save_modem_log end"
}



########################################################
# Save TCPDump logs
########################################################
save_tcpdump_log() {
    log -t savelog -p i "save_tcpdump_log begin"
    if [ ".$enable_tcpdump" == ".1" ]; then
        if [ -d "$WD_TCP_DUMP_LOG" ]; then
            log -t savelog -p i "copy tcpdump_log begin in"
    	    setprop persist.asus.starttcp 0
    	    starttcp=`getprop persist.asus.starttcp`
    	    log -t savelog -p i "11 persist.asus.starttcp=$starttcp"
    	    mv $WD_TCP_DUMP_LOG/ $TCP_DUMP_LOG/
    	    setprop persist.asus.starttcp 1
    	    starttcp=`getprop persist.asus.starttcp`
    	    log -t savelog -p i "22 persist.asus.starttcp=$starttcp"
        fi
    fi
    log -t savelog -p i "copy tcpdump_log end"
}



########################################################
# Remove folders
########################################################
remove_folder() {
	# remove folder
	log -t savelog -p i "remove_folder() begin"
	if [ -e $GENERAL_LOG ]; then
		rm -r $GENERAL_LOG
	fi

	if [ -e $MODEM_LOG ]; then
		rm -r $MODEM_LOG
	fi
	
	if [ -e $TCP_DUMP_LOG ]; then
		rm -r $TCP_DUMP_LOG
	fi
	log -t savelog -p i "remove_folder() end"
}



########################################################
# Create folders
########################################################
create_folder() {
    log -t savelog -p i "create_folder() begin"
	mkdir -p $GENERAL_LOG
	echo "mkdir -p $GENERAL_LOG"
	
	mkdir -p $MODEM_LOG
	echo "mkdir -p $MODEM_LOG"
	
	mkdir -p $TCP_DUMP_LOG
	echo "mkdir -p $GENERAL_LOG"
	log -t savelog -p i "create_folder() end"
}

########################################################
# Remove WIND folders
########################################################
remove_wind_folder() {
	# remove wind folder
	log -t savelog -p i "remove_wind_folder() begin"
	if [ -e $LOGCAT_LOG ]; then
		rm -r $LOGCAT_LOG
	fi
	
	if [ -e $LOGCAT_LOG_BACKUP ]; then
		rm -r $LOGCAT_LOG_BACKUP
	fi

	if [ -e $WD_MODEM_LOG ]; then
		rm -r $WD_MODEM_LOG
	fi

	if [ -e $WD_TCP_DUMP_LOG ]; then
        rm -r $WD_TCP_DUMP_LOG
    fi
	log -t savelog -p i "remove_wind_folder() end"
}

########################################################
# copy anr and prop
########################################################
copy_anr_prop() {
	# mv /data/anr to data/media
	ls -R -l /data/anr > $LOGCAT_LOG/ls_data_anr.txt
	cp /data/anr/* $LOGCAT_LOG/
	
	# save property
	getprop > $LOGCAT_LOG/getprop.txt
}

########################################################
# Main process
########################################################
log -t savelog -p i "Main process"

if [ ".$savelogs_prop" == ".0" ]; then
    log -t savelog -p i "Main process 0 begin"
	remove_folder
	# Ack BugReporter
    am broadcast -a "com.asus.removelogs.completed"
	
	logcat_prop=`getprop persist.asus.startlogcat`
	if [ ".$logcat_prop" == ".0" ]; then
	    setprop persist.asus.startlogcat 1
	    setprop persist.asus.startlogcatexec 1
	fi
	
	log -t savelog -p i "Main process 0 end"
	
elif [ ".$savelogs_prop" == ".1" ]; then
    log -t savelog -p i "Main process 1 begin"
	# check mount file
	umask 0;
	sync
	# remove folder
	remove_folder

	# create folder
	create_folder
	
	# save_general_log
	save_general_log
	#save_tcpdump_log
	
	# sync data to disk 
	chmod -R 777 $GENERAL_LOG
	sync

	# Ack BugReporter
	am broadcast -a "com.asus.savelogs.completed"
 	echo "Done"
	log -t savelog -p i "Main process 1 end"
	
elif [ ".$savelogs_prop" == ".2" ]; then
    log -t savelog -p i "Main process 2 begin"
	# check mount file
	umask 0;
	sync
	# remove folder
	remove_folder

	# create folder
	create_folder
	
	# save modem_log && general_log
	save_modem_log
	save_general_log
	#save_tcpdump_log

	# sync data to disk 
	chmod -R 777 $MODEM_LOG
	chmod -R 777 $GENERAL_LOG
	sync

	# Ack BugReporter
	am broadcast -a "com.asus.savelogs.completed"
 	echo "Done"
	log -t savelog -p i "Main process 2 end"
	
elif [ ".$savelogs_prop" == ".3" ]; then
    log -t savelog -p i "Main process 3 begin"
	# check mount file
	umask 0;
	sync
	# remove folder
	remove_folder

	# create folder
	create_folder
	
	# save_tcpdump_log && general_log
	save_tcpdump_log
	save_general_log

	# sync data to disk 
	chmod -R 777 $TCP_DUMP_LOG
	chmod -R 777 $GENERAL_LOG
	sync
	
	# Ack BugReporter
	am broadcast -a "com.asus.savelogs.completed"
 	echo "Done"
	log -t savelog -p i "Main process 3 end"
	
elif [ ".$savelogs_prop" == ".4" ]; then
    log -t savelog -p i "Main process 4 begin"
	# check mount file
	umask 0;
	sync
	# remove folder
	remove_folder

	# create folder
	create_folder
	
	# save_general_log && modem_log && tcpdump_log
	save_general_log
	save_modem_log
	save_tcpdump_log
	
	# sync data to disk 
	chmod -R 777 $GENERAL_LOG
	chmod -R 777 $MODEM_LOG
	chmod -R 777 $TCP_DUMP_LOG
	
	# Ack BugReporter
	am broadcast -a "com.asus.savelogs.completed"
 	echo "Done"
	log -t savelog -p i "Main process 4 end"
	
elif [ ".$savelogs_prop" == ".8" ]; then
    log -t savelog -p i "copy_anr_prop begin"
	copy_anr_prop
	log -t savelog -p i "copy_anr_prop end"
	
elif [ ".$savelogs_prop" == ".9" ]; then
    log -t savelog -p i "remove_wind_folder begin"
	remove_wind_folder
	setprop persist.asus.savelogs 10
	log -t savelog -p i "remove_wind_folder end"
	
elif [ ".$savelogs_prop" == ".11" ]; then
    log -t savelog -p i "backup begin"
    if [ -d "$LOGCAT_LOG" ]; then
	    if [ -e $LOGCAT_LOG_BACKUP ]; then
			log -t savelog -p i "remove backup"
			#rm $LOGCAT_LOG_BACKUP/*
	    fi
        log -t savelog -p i "mv backup"
        local logpath=$LOGCAT_LOG_BACKUP/$(date +"%y%m%d%H%M%S")
        mkdir -p $logpath
		mv  -f $LOGCAT_LOG/* $logpath

		# mv /data/anr to data/media
        ls -R -l /data/anr > $logpath/ls_data_anr.txt
        cp /data/anr/* $logpath/
        # save property
        getprop > $logpath/getprop.txt
	fi
	log -t savelog -p i "backup end"
	setprop persist.asus.startlogcatexec 1
	
fi
