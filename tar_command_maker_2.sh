#!/bin/bash
version_label=$1
echo version_label = $version_label
pushd /group/halld/Software/builds
# write tar script
tar_script=/tmp/tar_$version_label.sh
echo \#\!/bin/bash > $tar_script
echo pushd /group/halld/Software/builds >> $tar_script
find . -maxdepth 3 -type d -name $version_label | awk -F/ '{print "tar zcvf /cache/home/gluex/backups/releases/"$4"-"$2".tar.gz "$0}' >> $tar_script
chmod u+x $tar_script
echo
echo $tar_script:
echo
cat $tar_script
# ok to execute?
# write delete scriptstar_script=/tmp/tar_$version_label.sh
del_script=/tmp/del_$version_label.sh
echo \#\!/bin/bash > $del_script
echo pushd /group/halld/Software/builds >> $del_script
find . -maxdepth 3 -type d -name $version_label | awk -F/ '{print "rm -rfv "$0}' >> $del_script
chmod u+x $del_script
echo
echo $del_script:
echo
cat $del_script
# ok to execute?
