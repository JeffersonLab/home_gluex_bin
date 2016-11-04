#!/bin/sh
hosts="ifarm1102 ifarm1402 jlabl3 jlabl5"
SCRIPTS=/group/halld/Software/scripts
BUILD_SCRIPTS=/group/halld/Software/build_scripts
BUILD_DIR=/u/scratch/gluex/nightly/`date +%F`
# loop over hosts
for host in $hosts
do
    logfile=/u/scratch/gluex/halld_$host.log
    module_to_load_file=/u/scratch/gluex/nightly_module.txt
    # the following ssh executes command associated with the
    # /home/gluex/.ssh/build_halld.pub key in
    # /home/gluex/.ssh/authorized_keys. That command should be
    # /group/halld/Software/build_scripts/build_halld.csh.
    env -u SSH_AUTH_SOCK ssh -i ~/.ssh/build_halld $host >& $logfile
    mv $logfile $BUILD_DIR/
done
# send results to the simple list
/home/gluex/bin/nightly_build_message.sh
grep -e ' Error ' -e 'Command not found' -e ' warning: ' -e ' Warning: ' -e 'error: ' -e 'No such file' $BUILD_DIR/*.log
# make doxygen docs
nodename=`uname -n`
if [[ $nodename =~ ^i*farm[0-9]* ]]
    then
    export MODULESHOME=/usr/share/Modules
    source $MODULESHOME/init/bash
    module load gcc_4.9.2
fi
cd $BUILD_DIR/`$BUILD_SCRIPTS/osrelease.pl`/sim-recon/src/doc
make clean
make > make.log
# exit
exit
