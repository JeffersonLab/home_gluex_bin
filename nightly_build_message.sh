#!/bin/bash
BUILD_DIR=/u/scratch/gluex/nightly/`date +%F`
REPORT_FILE=/tmp/nightly_report.txt
LIST_DIR=/home/gluex/simple_email_list/lists/nightly_build
WEB_DIR=/group/halld/www/halldweb/html/nightly
rm -f $REPORT_FILE
date > $REPORT_FILE
echo This and previous messages can be found at https://halldweb.jlab.org/nightly/ >> $REPORT_FILE
echo ================ ERRORS ================ >> $REPORT_FILE
grep -e ' Error ' -e 'Command not found' -e 'error: ' -e 'No such file' \
    $BUILD_DIR/*.log | grep -v hdview2/trk_mainframe.h >> $REPORT_FILE
echo ================ WARNINGS ============== >> $REPORT_FILE
grep -e ' warning: ' -e 'Warning: ' -e 'WARNING: ' $BUILD_DIR/*.log \
    | grep -v hdv_mainframe_Dict.cc \
    | grep -v 'has modification time' \
    | grep -v 'Clock skew detected' \
    | grep -v 'Obsolete: ' \
    | grep -v 'AMPTOOLS or CLHEP is not defined' \
    | grep -v dl_routines \
    | grep -v "variable 'pyk'" \
    | grep -v "variable 'pychge'" \
    | grep -v "variable 'pycomp'" \
    | grep -v "Nonconforming tab character" \
    | grep -v "include/Math/Functor.h" \
    | grep -v "\-Wstrict-prototypes" \
    | grep -v -P "variable \xE2\x80\x98hmin\xE2\x80\x99" \
    | grep -v -P "variable \xE2\x80\x98kmin\xE2\x80\x99" \
    | grep -v -P "variable \xE2\x80\x98lmin\xE2\x80\x99" \
    >> $REPORT_FILE
lines=`wc -l $REPORT_FILE | perl -n -e '@t = split; print $t[0]'`
echo "number of lines in report file $REPORT_FILE is $lines"
if [ $lines -gt 4 ]
then
    cp -pv $REPORT_FILE $LIST_DIR/message.txt
    pushd $LIST_DIR
    $LIST_DIR/../../scripts/simple_email_list.pl
    popd
    pushd $WEB_DIR
    mv -v nightly_build_errors_5.txt nightly_build_errors_6.txt
    mv -v nightly_build_errors_4.txt nightly_build_errors_5.txt
    mv -v nightly_build_errors_3.txt nightly_build_errors_4.txt
    mv -v nightly_build_errors_2.txt nightly_build_errors_3.txt
    mv -v nightly_build_errors_1.txt nightly_build_errors_2.txt
    mv -v nightly_build_errors.txt nightly_build_errors_1.txt
    cp -pv $REPORT_FILE nightly_build_errors.txt
fi
exit
