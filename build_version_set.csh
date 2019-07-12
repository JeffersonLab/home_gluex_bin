#!/bin/tcsh
#
# environment
#
set start_dir=/home/gluex/chore
set HALLD_VERSIONS=/group/halld/www/halldweb/html/halld_versions
set VERSION_XML=$HALLD_VERSIONS/$1
source /group/halld/Software/build_scripts/gluex_env_jlab.csh $VERSION_XML
if ($status != 0) then
    echo error in build_version_set.csh: environment setup failed, exiting
    exit 1
else
    echo setup went OK
endif
set nprocs=`grep processor /proc/cpuinfo | wc -l`
set nthreads=`echo $nprocs/2 | bc`
if ($nthreads > 6) then
    set nthreads=6
endif
setenv SIM_RECON_SCONS_OPTIONS "SHOWBUILD=1"
setenv HALLD_RECON_SCONS_OPTIONS "SHOWBUILD=1"
setenv HALLD_SIM_SCONS_OPTIONS "SHOWBUILD=1"
setenv NTHREADS $nthreads
pushd $GLUEX_TOP
#
# build
#
set logname=$start_dir/make_`hostname`_`date +%F`.log
rm -fv $logname
make -f $BUILD_SCRIPTS/Makefile_all gluex_pass2 > & $logname &