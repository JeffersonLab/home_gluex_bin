#!/bin/sh
list_dir=/group/halld/Software/scripts/simple_email_list/lists/git_update
message="$list_dir/message.txt"
rm -fv $message
touch $message
for repo in sim-recon hdds hdpm build_scripts git_test gluex_install \
    gluex_simulations
do
    echo ----- $repo ----- >> $message
    cd /group/halld/Repositories/$repo
    git pull >> $message 2>&1
done
cd $list_dir
../../scripts/simple_email_list.pl

