#!/bin/tcsh -f

# This will attempt to build sim-recon using the source
# from the latest nightly build on the scratch disk.
# It assumes no environment has been set up for this yet.
# (i.e. BMS_OSNAME). If it detects a required component is
# missing, it will quietly exit with error code 1

# Set BMS_OSNAME_DEFAULT using default compiler
module load gcc_4.9.2
if ( ! -e /group/halld/Software/scripts/osrelease.pl ) exit 1
setenv BMS_OSNAME_DEFAULT `/group/halld/Software/scripts/osrelease.pl`
echo "BMS_OSNAME_DEFAULT = $BMS_OSNAME_DEFAULT"

# Directory name of today's nightly build
set BUILD_DIR=/u/scratch/gluex/nightly/`date +%F`
if ( ! -e $BUILD_DIR/$BMS_OSNAME_DEFAULT ) exit 1
cd $BUILD_DIR/$BMS_OSNAME_DEFAULT/sim-recon/src
echo "Building from $PWD"

# Setup environment from existing build
if ( ! -e ../$BMS_OSNAME_DEFAULT/setenv.csh ) exit 1
source ../$BMS_OSNAME_DEFAULT/setenv.csh

# Make sure LD_LIBRARY_PATH is set since it is assumed to be in
# the CLANGSETUP file
if ( ! $?LD_LIBRARY_PATH ) setenv LD_LIBRARY_PATH

# Setup to use clang compiler
set CLANGSETUP=/group/halld/Software/ExternalPackages/clang-llvm/llvm_clang_3.7.0/setenv.csh
if ( ! -e $CLANGSETUP ) exit 1
source $CLANGSETUP
echo "Using clang from $CLANGSETUP"

# Set BMS_OSNAME based on clang compiler so it doesn't
# overwrite the build with the gcc compiler
setenv BMS_OSNAME `/group/halld/Software/scripts/osrelease.pl`
echo "BMS_OSNAME = $BMS_OSNAME"


# Setup gcc 4.8.2
# This is needed because the clang compiler had
# to be built with a C++11 compliant compiler.
# Seems it still needs access to the glibc that
# gcc 4.8.2 provides.
set gccpath=/apps/gcc/4.8.2
setenv LD_LIBRARY_PATH ${gccpath}/lib64:${gccpath}/lib:${LD_LIBRARY_PATH}

# Build HDDS for this BMS_OSNAME
echo "Building HDDS in $HDDS_HOME"
if ( ! -e $HDDS_HOME ) exit 1
cd $HDDS_HOME
scons -j8 install
cd -

# Remove any previously made html or binaries since we need
# the entrie tree to build
rm -rf html .$BMS_OSNAME ../$BMS_OSNAME

# Run scan-build
scan-build -o html \
	--use-cc `which cc` \
	--use-c++ `which c++` \
	--use-analyzer `which clang++` \
	scons -u -j32 install

# Move generated html to webserver and replace LATEST link to point to it
if ( ! -e html ) exit 1
cd html
set htmldir=`ls`
mv $htmldir /group/halld/www/halldweb/html/scan-build
cd /group/halld/www/halldweb/html/scan-build
rm -f LATEST
ln -s $htmldir LATEST
echo "linking LATEST -> $htmldir"
