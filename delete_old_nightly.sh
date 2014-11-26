#!/bin/sh
echo delete old nightly builds
find /u/scratch/gluex/nightly -maxdepth 1 -mindepth 1 -type d | \
    perl -n -e 'print; chomp; $dir = $_; $count = `find $dir -type f | head | wc -l`; chomp $count; print "$count\n"; if (! $count) {print "removing directory $dir\n"; system "rm -rf $dir\n"}'
