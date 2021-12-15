#!/bin/bash
if [ "$1" == "-y" ]
then
    answer_yes="always"
    shift
fi
version_label=$1
isitok() {
    prompt=$1
    if [ "$answer_yes" != "always" ]
    then
	while true; do
	    read -p "$prompt" yn
	    case $yn in
		[Yy]* ) break;;
		[Nn]* ) exit;;
		* ) echo "Please answer yes or no.";;
	    esac
	done
    fi
}
script=/tmp/tar_$version_label.sh
echo version_label = $version_label
current_dir=`pwd`
rm -f tar_command.txt
echo \#\!/bin/bash >$script
echo pushd /group/halld/Software/builds >>$script
pushd /group/halld/Software/builds
find . -maxdepth 3 -type d -name $version_label | awk -F/ '{print "tar zcf /cache/home/gluex/backups/releases/"$4"-"$2".tar.gz "$0}' >>$script
chmod u+x $script
echo $script:
cat $script
isitok "Is it OK to tar up the release? "
#$script
echo tar files:
ls -lh /cache/home/gluex/backups/releases/${version_label}*.tar.gz
isitok "Is it OK to delete the release? "
#find . -maxdepth 3 -type d -name $version_label -print -exec rm -rf {} \;
