#!/bin/sh
hosts="jlabl1 jlabl3 ifarm1102"
BUILD_SCRIPTS=/group/halld/Software/scripts/build_scripts
BUILD_DIR=/group/halld/Software/builds/nightly/`date +%F`
for host in $hosts
do
    logfile=/u/scratch/gluex/halld_$host.log
    rm -f $logfile
    # the following ssh executes command associated with the
    # /home/gluex/.ssh/build_halld.pub key in
    # /home/gluex/.ssh/authorized_keys. That command should be
    # /group/halld/Software/scripts/build_scripts/build_halld.csh.
    env -u SSH_AUTH_SOCK ssh -i ~/.ssh/build_halld $host >& $logfile
    mv $logfile $BUILD_DIR/
done
# send results to the simple list
/home/gluex/bin/nightly_build_message.sh
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
