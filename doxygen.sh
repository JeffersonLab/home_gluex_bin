#!/bin/sh
echo make doxygen docs
DOXDIR=/u/scratch/gluex/doxygen/`date +%F`
WEBDIR=/group/halld/www/halldweb/html/doxygen
mkdir -pv $DOXDIR
echo cd to $DOXDIR
cd $DOXDIR
echo ls
ls

make_html () {
    package=$1
    echo remove previous $package directory
    rm -rf $package
    git clone --quiet https://github.com/jeffersonlab/$package
    cd $package/src/doc
    make \
	| grep -v Generating | grep -v Preprocessing | grep -v Parsing \
	| grep -v Searching
    cp -r html $WEBDIR/${package}_new
    echo cd to $WEBDIR
    cd $WEBDIR
    ls -l $package/index.html
    mv -v $package ${package}_old
    mv -v ${package}_new $package
    rm -rf ${package}_old
    ls -l $package/index.html
}

make_html "halld_recon"
make_html "halld_sim"
