#!/bin/sh
simple_dir=/group/halld/Software/scripts/simple_email_list/lists/single_track
cd $simple_dir
rm -f message.txt
touch message.txt
echo https://halldweb1.jlab.org/single_track/`date +%F`/ >> message.txt
../../scripts/simple_email_list.pl
