#!/bin/sh
node=`hostname | awk -F. '{print $1}'`

echo crontab_${node}.txt \<\> crontab -l
tempfile=/tmp/crondiff_$RANDOM.tmp
echo dumping crontab into $tempfile
rm -f $tempfile
crontab -l > $tempfile
diff -s crontab_${node}.txt $tempfile
