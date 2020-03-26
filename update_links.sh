#!/bin/bash
function switch {
    directory=$1
    file=$2
    pushd $directory
    rm -fv version.xml version_jlab.xml
    ln -s $file version.xml
    cat version.xml
    ln -s $file version_jlab.xml
    cat version_jlab.xml
}
file_in=$1
if [[ -z $file_in ]]
    then
    echo "error: missing xml file argument"
    exit 1
fi
switch /group/halld/www/halldweb/html/halld_versions $file_in
