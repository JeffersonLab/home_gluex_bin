#!/bin/sh
version_xml=$1
hosts="ifarm1101 ifarm1402 jlabl3 jlabl5"
# loop over hosts
for host in $hosts
do
    ( \
    env -u SSH_AUTH_SOCK ssh -i ~/.ssh/id_batch $host /home/gluex/bin/build_version_set.csh $version_xml \
    ) &
done
nprocs=999
while [ $nprocs -ne 0 ]
    do
    sleep 10
    nprocs=`ps aux | grep build_version_set.csh | grep -v grep | wc -l`
    date
    echo nprocs = $nprocs
done
echo done with all
# exit
exit
