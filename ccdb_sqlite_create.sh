#!/bin/sh
source /group/halld/Software/scripts/build_scripts/gluex_env_jlab.sh
sqlite_file=/group/halld/Software/calib/ccdb_sqlite/ccdb_`date +%F`.sqlite
rm -fv $sqlite_file
$CCDB_HOME/scripts/mysql2sqlite/mysql2sqlite.sh -hhalldweb1 -uccdb_user ccdb | sqlite3 $sqlite_file
ls -l /group/halld/Software/calib/ccdb_sqlite
