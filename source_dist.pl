#!/usr/bin/env perl

$url = $ARGV[0];
$status = system "svn export $url";
print "status = $status\n";
if ($status) {die "svn export failed"}
@token = split(/\//, $url);
$dirname = $token[$#token];
$tarname = "${dirname}-src.tar.gz";
print "tar'ing up $dirname into $tarname\n";
$status = system "tar zcf $tarname $dirname";
print "status = $status\n";
if ($status) {die "tar failed"}

exit;
