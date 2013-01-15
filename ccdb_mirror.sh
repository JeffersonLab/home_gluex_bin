#!/bin/sh
#
dumpfile=/scratch/marki/ccdb_dump.sql
#
env -u SSH_AUTH_SOCK ssh -i ~/.ssh/ccdb_dump -lmarki halldweb1
ls -l $dumpfile
mysql -hhallddb1 -umarki -pWga\*aba0 ccdb < $dumpfile
