#!/bin/sh
source /group/halld/Software/scripts/build_scripts/gluex_env.sh
$CCDB_HOME/scripts/mysql2sqlite/mysql2sqlite.sh -hhalldweb1 -uccdb_user ccdb | \
    sqlite3 /group/halld/Software/calib/ccdb_`date +%F`.sqlite
