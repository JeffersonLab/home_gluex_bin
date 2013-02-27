#!/bin/sh
hosts="jlabl3 ifarm1101 ifarm1102 roentgen"
RUN_DIR=/u/scratch/gluex/b1pi/`date +%F`
for host in $hosts
do
    logfile=/u/scratch/gluex/b1pi_$host.log
    rm -f $logfile
    env -u SSH_AUTH_SOCK ssh -i ~/.ssh/b1pi_cron $host > $logfile 2>&1
    mv $logfile $RUN_DIR/
done
/home/gluex/bin/b1pi_message.sh
exit
