# mv /data/anr to data/media
echo "mkdir /storage/emulated/0/logs/anr"
mkdir /storage/emulated/0/logs/anr
echo "cp /data/anr /storage/emulated/0/logs/anr/"
cp /data/anr/* /storage/emulated/0/logs/anr/
# akc getlogsetting
am broadcast -a "com.asus.copyanr.completed"
