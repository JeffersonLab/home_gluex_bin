#!/bin/bash
cd /group/halld/Software/scripts/simple_email_list/lists/duplicate_cache
rm -f message.txt
env -u SSH_AUTH_SOCK ssh -i ~/.ssh/duplicate_cache ifarm > message.txt
../../scripts/simple_email_list.pl
