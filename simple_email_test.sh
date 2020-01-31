#!/bin/bash
cd /home/gluex/simple_email_list/lists/example
cp /group/halld/www/halldweb/html/nightly/nightly_build_errors.txt message.txt
../../scripts/simple_email_list.pl
