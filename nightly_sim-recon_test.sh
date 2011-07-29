#!/bin/sh
hosts="ifarml5 jlabl3 ifarml6"
BUILD_SCRIPTS=/group/halld/Software/scripts/build_scripts
BUILD_DIR=/scratch/gluex/halld_builds_test/`date +%F`
for host in $hosts
do
    logfile=/scratch/gluex/halld_builds_test/halld_$host.log
    rm -f $logfile
    env -u SSH_AUTH_SOCK ssh -i ~/.ssh/build_halld_test $host >& $logfile
    mv $logfile $BUILD_DIR/
done
grep -e ' Error ' -e 'Command not found' -e ' warning: ' -e ' Warning: ' $BUILD_DIR/*.log
exit
