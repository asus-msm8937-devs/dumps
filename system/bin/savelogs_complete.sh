#!/system/bin/sh
# xuyi@wind-mobi.com 20171211 add for BugReporter

uts=`getprop persist.asus.uts`
am broadcast -a com.asus.removelogs.completed
