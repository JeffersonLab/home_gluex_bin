#!/bin/bash
export TARGET_DIR=/group/halld/Software/builds/Linux_CentOS7-x86_64-gcc4.8.5-cntr/recent/`date +%A`
rm -rf $TARGET_DIR
mkdir -p $TARGET_DIR
/home/gluex/bin/build_halld.csh > $TARGET_DIR/build_halld.log 2>&1
