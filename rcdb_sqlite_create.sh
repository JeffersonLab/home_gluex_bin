#!/bin/sh
source /group/halld/Software/build_scripts/gluex_env_jlab.sh
sqlite_file=/group/halld/Software/calib/rcdb_sqlite/rcdb_`date +%F`.sqlite
rm -f $sqlite_file
$CCDB_HOME/scripts/mysql2sqlite/mysql2sqlite.sh -hhallddb -urcdb rcdb | sqlite3 $sqlite_file | grep -v memory
size=`stat --format=%s $sqlite_file`
echo size = $size
if [ $size -gt 110000000 ]
    then
    cp -pv $sqlite_file /group/halld/www/halldweb/html/dist/rcdb.sqlite.tmp
    cd /group/halld/www/halldweb/html/dist
    mv -v rcdb.sqlite.tmp rcdb.sqlite
else
    echo error: too small to copy
fi
