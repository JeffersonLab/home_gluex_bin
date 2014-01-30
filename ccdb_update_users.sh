#!/bin/sh
export CCDB_HOME=/home/gluex/p12/ccdb
source /group/halld/Software/scripts/build_scripts/gluex_env_jlab.sh
perl $CCDB_HOME/scripts/users_create/group_parse.pl \
    | /apps/python/python-2.7.1/bin/python \
    $CCDB_HOME/scripts/users_create/users_create.py \
    --recreate mysql://ccdb_user@hallddb.jlab.org/ccdb
