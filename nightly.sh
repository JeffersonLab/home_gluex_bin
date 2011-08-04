#!/bin/sh
hosts="jlabl3 ifarm1102"
BUILD_SCRIPTS=/group/halld/Software/scripts/build_scripts
BUILD_DIR=/scratch/gluex/halld_builds/`date +%F`
for host in $hosts
do
    logfile=/scratch/gluex/halld_$host.log
    rm -f $logfile
    env -u SSH_AUTH_SOCK ssh -i ~/.ssh/build_halld $host >& $logfile
    mv $logfile $BUILD_DIR/
done
grep -e ' Error ' -e 'Command not found' -e ' warning: ' -e ' Warning: ' -e 'error: ' -e 'No such file' $BUILD_DIR/*.log
# make doxygen docs
cd $BUILD_DIR/sim-recon/src/doc
make clean
make > make.log
# make svn statistics
$BUILD_SCRIPTS/../make_SVNreport > SVNreport.log
mv SVNstats html
make install
# exit
exit
