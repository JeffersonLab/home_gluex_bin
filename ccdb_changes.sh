#!/bin/sh
tempfile=/tmp/ccdb_changes.txt
listdir=/group/halld/Software/scripts/simple_email_list
rm -f $tempfile
mysql -t -hhallddb -uccdb_user ccdb -e \
"select assignments.created, variations.name as variation, directories.name as directory, typeTables.name as type, users.name as author, runMin, runMax, substring(vault, 1, 32) as data, assignments.comment from assignments, constantSets, variations, runRanges, users, typeTables, directories where constantSetId = constantSets.id AND variationId = variations.id and runRanges.id = runRangeId and assignments.authorId = users.id and constantTypeId = typeTables.id and directoryId = directories.id having TIMESTAMPDIFF(HOUR,assignments.created, CURDATE()) < 24 order by assignments.created;" > $tempfile
cd $listdir/lists/ccdb_changes
cp $tempfile message.txt
$listdir/scripts/simple_email_list.pl > /dev/null
