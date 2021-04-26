#!/bin/sh
echo delete old nightly builds
find /u/scratch/gluex/nightly -maxdepth 1 -mindepth 1 -type d | \
    perl -n -e 'chomp; $dir = $_; $count = `find $dir -maxdepth 2 -type f -name \*.xml | wc -l`; chomp $count; print "file count for $dir is $count\n"; if ($count < 1) {print "removing directory $dir\n"; print "rm -rf $dir\n"}'
