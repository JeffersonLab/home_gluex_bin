#!/bin/sh
rm -f c.tmp ; crontab -l > c.tmp ; diff -s crontab_jlabl1.txt c.tmp
