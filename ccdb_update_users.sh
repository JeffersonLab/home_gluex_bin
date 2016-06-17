#!/bin/sh
export BUILD_SCRIPTS=/group/halld/Software/build_scripts
export BMS_OSNAME=`$BUILD_SCRIPTS/osrelease.pl`
export GLUEX_TOP=/group/halld/Software/builds/$BMS_OSNAME
eval `/group/halld/Software/build_scripts/version.pl -sbash /group/halld/www/halldweb/html/dist/version_jlab.xml`
source $CCDB_HOME/environment.bash
perl $CCDB_HOME/scripts/users_create/group_parse.pl \
    | /apps/python/python-2.7.1/bin/python \
    $CCDB_HOME/scripts/users_create/users_create.py \
    --recreate mysql://ccdb_user@hallddb.jlab.org/ccdb
