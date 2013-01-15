#!/bin/sh
dumpfile=/home/$USER/ccdb_dump.sql
transferfile=/scratch/marki/ccdb_dump.sql
if [ -f $dumpfile ]
    then
    mv $dumpfile ${dumpfile}.old
fi
mysqldump -hlocalhost -uccdb_user ccdb > $dumpfile
ls -l $dumpfile
cp -pv $dumpfile $transferfile
ls -l $transferfile
