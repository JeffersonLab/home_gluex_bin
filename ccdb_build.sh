#!/bin/sh
cd /scratch/gluex
rm -rf ccdb.old
if [ -d ccdb ]
    then
    mv ccdb ccdb.old
fi
svn checkout https://phys12svn.jlab.org/repos/trunk/ccdb
cd ccdb
. environment.bash
scons
scons
ccdb_tests -t
chmod a+x bin/ccdbcmd
ccdbcmd -i <<EOT
help
quit
+
EOT
exit

