#!/bin/sh
list_dir=/group/halld/Software/scripts/simple_email_list/lists/git_update
message="$list_dir/message.txt"
rm -fv $message
touch $message
for repo in sim-recon hdds hdpm build_scripts git_test
do
    echo ----- $repo ----- >> $message
    cd /group/halld/Repositories/$repo
    git fetch >> $message
    git pull >> $message
done
cd $list_dir
../../scripts/simple_email_list.pl

