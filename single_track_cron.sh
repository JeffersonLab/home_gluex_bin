#!/bin/sh
hosts="ifarm1101"
WEBDIR=/group/halld/www/halldweb1/html/single_track/`date +%F`
for host in $hosts
do
    logfile=/u/scratch/gluex/single_track_$host.log
    rm -f $logfile
    env -u SSH_AUTH_SOCK ssh -i ~/.ssh/single_track_cron $host > $logfile 2>&1
    mv $logfile $WEBDIR/
done
/home/gluex/bin/single_track_message.sh
exit
