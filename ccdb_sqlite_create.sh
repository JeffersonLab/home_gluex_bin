#!/bin/sh
source /group/halld/Software/build_scripts/gluex_env_jlab.sh
sqlite_file=/group/halld/Software/calib/ccdb_sqlite/ccdb_`date +%F`.sqlite
rm -f $sqlite_file
$CCDB_HOME/scripts/mysql2sqlite/mysql2sqlite.sh -hhallddb -uccdb_user ccdb | sqlite3 $sqlite_file
size=`stat --format=%s $sqlite_file`
echo size = $size
if [ $size -gt 100000000 ]
    then
    cp -p $sqlite_file /group/halld/www/halldweb/html/dist/ccdb.sqlite.tmp
    pushd /group/halld/www/halldweb/html/dist
    mv ccdb.sqlite.tmp ccdb.sqlite
else
    echo error: too small to copy
fi
