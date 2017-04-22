#!/bin/sh
source /group/halld/Software/build_scripts/gluex_env_jlab.sh
sqlite_file=/scratch/gluex/rcdb_`date +%F`.sqlite
minutes_since_change=`mysql -hhallddb -urcdb rcdb \
    -e "select timestampdiff(MINUTE, created, now()) from logs \
    order by created desc limit 1;" | grep -v timestampdiff`
echo info: minutes_since_change = $minutes_since_change
if [ $minutes_since_change -lt 1440 ]
    then
    echo info: recent entries exist, creating $sqlite_file
    rm -f $sqlite_file
    $CCDB_HOME/scripts/mysql2sqlite/mysql2sqlite.sh -hhallddb -urcdb rcdb \
	| sqlite3 $sqlite_file | grep -v memory
    size=`stat --format=%s $sqlite_file`
    echo info: size = $size
    if [ $size -gt 110000000 ]
        then
	cp -pv $sqlite_file /group/halld/www/halldweb/html/dist/rcdb.sqlite
	cp -pv $sqlite_file /cache/halld/home/gluex/rcdb_sqlite/
    else
	echo error: too small to copy
    fi
else
    echo info: no recent entries, not creating new rcdb sqlite file
fi

