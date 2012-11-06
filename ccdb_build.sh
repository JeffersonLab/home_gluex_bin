#!/bin/sh
use python 27
export PATH=/apps/gcc/4.6.3/bin:$PATH
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
ccdb_tests -t
chmod a+x bin/ccdbcmd
ccdbcmd -i <<EOT
help
quit
+
EOT
exit

