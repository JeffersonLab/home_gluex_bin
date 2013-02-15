#!/bin/sh
simple_dir=/group/halld/Software/scripts/simple_email_list/lists/b1pi
cd $simple_dir
rm -f message.txt
touch message.txt
echo https://halldweb1.jlab.org/b1pi/`date +%F`/ >> message.txt
../../scripts/simple_email_list.pl
