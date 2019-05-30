#!/bin/sh
version_xml=$1
hosts="ifarm1101 ifarm1402 jlabl3 jlabl5"
# loop over hosts
for host in $hosts
do
    echo launching on $host
    env -u SSH_AUTH_SOCK ssh -i ~/.ssh/id_batch $host \
	/home/gluex/bin/build_version_set.csh $version_xml
done
