#!/bin/bash
if voms-proxy-info --exists ; then
    echo there is a proxy
else
    echo no proxy, need to generate one
    /home/gluex/bin/test.tcl
fi
gsiscp -o GSSAPIDelegateCredentials=yes /group/halld/www/halldweb/html/dist/ccdb.sqlite oasis-login.opensciencegrid.org:/stage/oasis/gluex/group/halld/www/halldweb/html/dist/ccdb.sqlite.new
gsissh -o GSSAPIDelegateCredentials=yes oasis-login.opensciencegrid.org mv -v /stage/oasis/gluex/group/halld/www/halldweb/html/dist/ccdb.sqlite.new /stage/oasis/gluex/group/halld/www/halldweb/html/dist/ccdb.sqlite
gsissh -o GSSAPIDelegateCredentials=yes oasis-login.opensciencegrid.org osg-oasis-update
