#!/bin/tcsh
#
# environment
#
set VERSION_FILENAME=$1
set start_dir=/home/gluex/chore
set HALLD_VERSIONS=/group/halld/www/halldweb/html/halld_versions
set VERSION_XML=$HALLD_VERSIONS/$VERSION_FILENAME
set nthreads_max=12
source /group/halld/Software/build_scripts/gluex_env_jlab.csh $VERSION_XML
if ($status != 0) then
    echo error in build_version_set.csh: environment setup failed, exiting
    exit 1
else
    echo setup went OK
endif
set nprocs=`grep processor /proc/cpuinfo | wc -l`
set nthreads=`echo $nprocs/2 | bc`
if ($nthreads > $nthreads_max) then
    set nthreads=$nthreads_max
endif
setenv SIM_RECON_SCONS_OPTIONS "SHOWBUILD=1"
setenv HALLD_RECON_SCONS_OPTIONS "SHOWBUILD=1"
setenv HALLD_SIM_SCONS_OPTIONS "SHOWBUILD=1"
setenv NTHREADS $nthreads
pushd $GLUEX_TOP
#
# build
#
set logname=$start_dir/make_${VERSION_FILENAME}_`hostname`_`date +%m-%d:%T`.log
rm -fv $logname
echo info from build_version_set.csh: running make on `hostname` with $NTHREADS threads, log file = $logname
make -f $BUILD_SCRIPTS/Makefile_all gluex_pass1 gluex_pass2 > & $logname &
