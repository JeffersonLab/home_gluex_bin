#!/bin/bash
version_label=$1
script=/tmp/tar_$version_label.sh
echo version_label = $version_label
current_dir=`pwd`
rm -f tar_command.txt
echo \#\!/bin/bash >$script
echo pushd /group/halld/Software/builds >>$script
pushd /group/halld/Software/builds
find . -maxdepth 3 -type d -name $version_label | awk -F/ '{print "tar zcvf /cache/home/gluex/backups/releases/"$4"-"$2".tar.gz "$0}' >>$script
chmod u+x $script
echo $script:
cat $script
