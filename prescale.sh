#!/bin/bash
interval=$1
count=$2
utime=`date +%s`
cycles=$(($utime/$interval))
mod=$(($cycles%$count))
exit $mod
