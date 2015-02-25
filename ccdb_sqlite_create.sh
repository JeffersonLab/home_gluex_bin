#!/bin/sh
source /group/halld/Software/scripts/build_scripts/gluex_env_jlab.sh
sqlite_file=/group/halld/Software/calib/ccdb_sqlite/ccdb_`date +%F`.sqlite
rm -fv $sqlite_file
$CCDB_HOME/scripts/mysql2sqlite/mysql2sqlite.sh -hhallddb -uccdb_user ccdb | sqlite3 $sqlite_file
size=`stat --format=%s $sqlite_file`
echo size = $size
if [ $size -gt 100000000 ]
    then
    cp -pv $sqlite_file /group/halld/www/halldweb1/html/dist/ccdb.sqlite
else
    echo too small to copy
fi
echo listing showing access time:
ls -lu /group/halld/Software/calib/ccdb_sqlite
