#!/bin/bash
if voms-proxy-info ; then
    echo there is a proxy
else
    echo no proxy, need to generate one
    test.tcl
fi
gsiscp -o GSSAPIDelegateCredentials=yes /group/halld/www/halldweb/html/dist/ccdb.sqlite oasis-login.opensciencegrid.org:/stage/oasis/gluex/group/halld/www/halldweb/html/dist/
