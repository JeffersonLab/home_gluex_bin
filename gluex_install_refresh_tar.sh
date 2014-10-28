#!/bin/sh
mkdir -pv /tmp/gluex
pushd /tmp/gluex
rm -rfv gluex_install
svn export https://halldweb1.jlab.org/repos/trunk/scripts/gluex_install
tar cvf gluex_install.tar gluex_install
read -p "upload? " response
echo response = $response
if [ $response = 'yes' ]
    then
    cp -pv gluex_install.tar /group/halld/www/halldweb1/html/dist/
else
    echo will not upload
fi
exit

