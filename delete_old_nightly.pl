#!/usr/bin/env perl
print "delete old nightly builds\n";
$find_command = "find /u/scratch/gluex/nightly -maxdepth 1 -mindepth 1 -type d |";
open (FIND, $find_command);
while (<FIND>) {
    chomp;
    $dir = $_;
    $count = `find $dir -maxdepth 3 -type f | wc -l`;
    chomp $count;
    if ($count < 300) {
	print "file count for $dir is $count\n";
    }
    if ($count == 0) {
	print "removing directory $dir\n";
	system "rm -rf $dir";
    }
}
exit 0;
