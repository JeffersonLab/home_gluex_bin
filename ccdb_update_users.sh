#!/bin/sh
source /group/halld/Software/build_scripts/gluex_env_jlab.sh
perl $CCDB_HOME/scripts/users_create/group_parse.pl \
    | python $CCDB_HOME/scripts/users_create/users_create.py \
    --recreate mysql://ccdb_user@hallddb.jlab.org/ccdb
