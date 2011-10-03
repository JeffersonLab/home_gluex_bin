#!/bin/sh
pushd /tmp
mkdir -p svn_kludge
cd svn_kludge
svn checkout https://halldsvn.jlab.org/repos/trunk/sim-recon
popd
cp -pr /tmp/svn_kludge/sim-recon .
exit
