#!/bin/sh
hosts="jlabl3 ifarml6"
RUN_DIR=/scratch/gluex/b1pi/`date +%F`
for host in $hosts
do
    logfile=/scratch/gluex/b1pi_$host.log
    rm -f $logfile
    env -u SSH_AUTH_SOCK ssh -i ~/.ssh/b1pi_cron $host >& $logfile
    mv $logfile $RUN_DIR/
done
exit
