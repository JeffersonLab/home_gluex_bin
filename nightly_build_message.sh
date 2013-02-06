#!/bin/sh
BUILD_DIR=/group/halld/Software/builds/nightly/`date +%F`
REPORT_FILE=/tmp/nightly_report.txt
LIST_DIR=/group/halld/Software/scripts/simple_email_list/lists/nightly_build
rm -f $REPORT_FILE
echo ================ ERRORS ================ > $REPORT_FILE
grep -e ' Error ' -e 'Command not found' -e 'error: ' -e 'No such file' $BUILD_DIR/*.log >> $REPORT_FILE
echo ================ WARNINGS ============== >> $REPORT_FILE
grep -e ' warning: ' -e 'Warning: ' $BUILD_DIR/*.log | grep -v hdv_mainframe_Dict.cc | grep -v 'has modification time' | grep -v 'Clock skew detected' | grep -v 'Obsolete: ' >> $REPORT_FILE
lines=`wc -l $REPORT_FILE | perl -n -e 'split; print $_[0]'`
echo "number of lines in report file $REPORT_FILE is $lines"
if [ $lines -gt 2 ]
then
    cp -pv $REPORT_FILE $LIST_DIR/message.txt
    pushd $LIST_DIR
    $LIST_DIR/../../scripts/simple_email_list.pl
fi
exit
