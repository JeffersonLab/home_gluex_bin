#!/bin/bash
today=`date +%F`
rundir=/u/scratch/gluex/profile/$today
source /group/halld/Software/build_scripts/gluex_env_boot_jlab.sh
bms_osname=`$BUILD_SCRIPTS/osrelease.pl`
gxenv /u/scratch/gluex/nightly/$today/$bms_osname/version.xml
mkdir -p $rundir
cd $rundir
/group/halld/Software/hd_utilities/profiling/profile_hd_root.sh
