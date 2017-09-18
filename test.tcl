#!/usr/bin/expect --
set timeout 60
spawn voms-proxy-init -voms Gluex
expect "Enter GRID"
send "\r"
interact
