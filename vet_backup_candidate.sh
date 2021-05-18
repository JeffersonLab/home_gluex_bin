#!/bin/bash
dirname=$1
outdir=/tmp/`basename $dirname`
mkdir -p $outdir
echo writing output to $outdir
echo checking size
du -sh $dirname >| $outdir/size.txt
echo checking age
find $dirname -type f -atime -365 -exec ls -lu {} \; >| $outdir/find_new_files.txt
echo checking privileges
find $dirname -type f -not -perm -go+r -exec ls -l {} \; >| $outdir/find_protected_files.txt
echo making listing by mod time
ls -lrthR $dirname >| $outdir/listing_modification_time.txt
echo making listing by access time
ls -lrtuhR $dirname >| $outdir/listing_access_time.txt
