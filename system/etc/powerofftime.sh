#!/system/bin/sh

########################################################
# change_longpoweroff_time.sh sample code
########################################################

longpower_prop=`getprop persist.sys.longpowertime`


########################################################
# Save general logs
########################################################
change_longpoweroff_time() {
	# change cmdline
	#cat /proc/cmdline > $GENERAL_LOG/cmdline.txt
	#echo "cat /proc/cmdline > $GENERAL_LOG/cmdline.txt"
    
    echo 0x840 > /sys/kernel/debug/spmi/spmi-0/address
    echo 4 > /sys/kernel/debug/spmi/spmi-0/count
    echo 0xf 0x0 0x7 0x80 > /sys/kernel/debug/spmi/spmi-0/data

    echo "echo 0x840 > /sys/kernel/debug/spmi/spmi-0/address"
    echo "echo 4 > /sys/kernel/debug/spmi/spmi-0/count"
    echo "echo 0xf 0x0 0x7 0x80 > /sys/kernel/debug/spmi/spmi-0/data"
}

reset_longpoweroff_time() {
	# save cmdline
	#cat /proc/cmdline > $GENERAL_LOG/cmdline.txt
	#echo "cat /proc/cmdline > $GENERAL_LOG/cmdline.txt"

    echo 0x840 > /sys/kernel/debug/spmi/spmi-0/address
    echo 4 > /sys/kernel/debug/spmi/spmi-0/count
    echo 0x7 0x7 0x7 0x80 > /sys/kernel/debug/spmi/spmi-0/data
    
    echo "echo 0x840 > /sys/kernel/debug/spmi/spmi-0/address"
    echo "echo 4 > /sys/kernel/debug/spmi/spmi-0/count"
    echo "echo 0x7 0x7 0x7 0x80 > /sys/kernel/debug/spmi/spmi-0/data"
}


########################################################
# Main process
########################################################
if [ ".$longpower_prop" == ".0" ]; then
    reset_longpoweroff_time
elif [ ".$longpower_prop" == ".1" ]; then
    change_longpoweroff_time
fi
