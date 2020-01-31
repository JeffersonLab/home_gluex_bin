#!/bin/bash
function farm_info {
    host=$1
    ssh $host hostname
    ssh $host cat /etc/redhat-release
    nprocs=`ssh $host cat /proc/cpuinfo | grep processor | wc -l`
    echo number of processors: $nprocs
    ssh $host uptime
}

nodes="ifarm1401 ifarm1402 ifarm1801 ifarm1802 ifarm1901"
date
for node in $nodes; do
    echo ===== $node =====
    farm_info $node
done


