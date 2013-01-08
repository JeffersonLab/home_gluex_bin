#!/bin/sh
dumpfile=/scratch/$USER/ccdb_dump.sql
if [ -f $dumpfile ]
    then
    mv $dumpfile ${dumpfile}.old
fi
mysqldump -hhalldweb1 -uccdb_user ccdb > $dumpfile
mysql -hhallddb1 -umarki -pWga\*aba0 ccdb < $dumpfile
