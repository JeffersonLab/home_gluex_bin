#!/bin/sh
echo crontab_jlabl1.txt \<\> crontab -l
tempfile=/tmp/crondiff_$USER.tmp
rm -f $tempfile
crontab -l > $tempfile
diff -s crontab_jlabl1.txt $tempfile
