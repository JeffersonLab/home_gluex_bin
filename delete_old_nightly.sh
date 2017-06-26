#!/bin/sh
echo delete old nightly builds
find /u/scratch/gluex/nightly -maxdepth 1 -mindepth 1 -type d | \
    perl -n -e 'chomp; $dir = $_; $count = `find $dir -type f | wc -l`; chomp $count; print "count for $dir is $count\n"; if (! $count) {print "removing directory $dir\n"; system "rm -rf $dir\n"}'
