#!/bin/sh
export PATH=/apps/python/bin:/apps/gcc/4.6.3/bin:$PATH
BUILD_DIR=/scratch/gluex/ccdb_nightly
mkdir -p $BUILD_DIR
cd $BUILD_DIR
rm -rf ccdb.old
if [ -d ccdb ]
    then
    mv ccdb ccdb.old
fi
svn checkout https://phys12svn.jlab.org/repos/trunk/ccdb
cd ccdb
. environment.bash
scons
export CCDB_CONNECTION=mysql://ccdb_user@halldweb1.jlab.org/ccdb
#tests_ccdb
ccdb -i <<EOT
help
quit
+
EOT
exit
