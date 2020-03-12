#!/bin/sh
list_dir=/home/gluex/simple_email_list/lists/git_update
message="$list_dir/message.txt"
rm -f $message
touch $message
for repo in halld_recon halld_sim sim-recon hdds hdpm build_scripts git_test \
    gluex_install gluex_simulations ccdb rcdb hdgeant4 gluex_root_analysis \
    gluex_MCwrapper
do
    echo ----- $repo ----- >> $message
    cd /group/halld/Repositories/$repo
    git pull --all >> $message 2>&1
done
cd $list_dir
../../scripts/simple_email_list.pl > /dev/null
