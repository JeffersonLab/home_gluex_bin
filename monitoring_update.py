#!/apps/python/python-2.7.1/bin/python2.7

import datetime
import os
os.environ["RCDB_HOME"] = "/group/halld/www/halldweb/html/rcdb_home"
import sys
sys.path.append("/group/halld/www/halldweb/html/rcdb_home/python")
import rcdb

import time
import datetime

db = rcdb.RCDBProvider("mysql://rcdb@hallddb/rcdb")

# main function
# This is where the program starts
def main():

    # date and time for 24 hours previous
    beginTime = datetime.datetime.now() - datetime.timedelta(days=1)

    # get first and last runs for the last 24 hours
    query = "event_count>100000 and @is_production" # and time > %s" % beginTime
    runs = db.select_runs(query)
    for run in runs:
        #print run.number
        if run.end_time > beginTime:
            beginRun = run.number
            break
    endRun = runs[-1].number

    # write message file
    message_file = open("/group/halld/Software/scripts/simple_email_list/lists/monitoring_update/message.txt", "w")
    message_file.write( "Plot browser links for yesterday's runs (since %s): Runs included %d-%d \n\n" % (beginTime.strftime("%Y-%m-%d %H:%M:%S"), beginRun, endRun) )

    # set list of histograms titles and names in this list
    hist_names = [["CDC Occupancy", "CDC_occupancy"]]

    for hist in hist_names:
        message_file.write( "%s: https://halldweb.jlab.org/cgi-bin/data_monitoring/monitoring/plotBrowser.py?run_number1=%d&run_number2=%d&plot=%s&ver=ver00" % (hist[0], beginRun, endRun, hist[1]) )

    message_file.close()

if __name__=="__main__":
    main()
