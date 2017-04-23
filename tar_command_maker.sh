#!/bin/bash
version_label=$1
echo version_label = $version_label
current_dir=`pwd`
rm -f tar_command.txt
echo pushd /group/halld/Software/builds > $current_dir/tar_command.txt
pushd /group/halld/Software/builds
find . -maxdepth 3 -type d -name $version_label | awk -F/ '{print "tar zcvf /scratch/$USER/"$4"-"$2".tar.gz "$0}' >> $current_dir/tar_command.txt
popd
echo tar_command.txt:
cat tar_command.txt
