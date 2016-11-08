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
    beginRun = 0

    # get first and last runs for the last 24 hours
    query = "event_count>100000 and @is_production" # and time > %s" % beginTime
    runs = db.select_runs(query)
    for run in runs:
        #print run.number
        if run.end_time > beginTime:
            beginRun = run.number
            break
    endRun = runs[-1].number

    # check for new runs
    if beginRun == 0:
        sys.exit()

    # write message file
    message_file = open("/group/halld/Software/scripts/simple_email_list/lists/monitoring_update/message.txt", "w")
    #message_file = open("/w/halld-scifs1a/home/tbritton/monitoring_cron/bin/message.txt", "w") # just for testing
    message_file.write( "Plot browser links for yesterday's runs (since %s): Runs included %d-%d \n\n" % (beginTime.strftime("%Y-%m-%d %H:%M:%S"), beginRun, endRun) )
    message_file.write( "\n ===================================================================== \n" )
    message_file.write( "Occupancy Macros: \n" )
    
    # set list of histograms titles and names in this list
    hist_names = [["CDC_occupancy","CDC"],["FDC_occupancy","FDC"],["FCAL_occupancy","FCAL"],["BCAL_occupancy","BCAL"],["PS_occupancy","PS"],["RF_TPOL_occupancy","RF & TPOL"],["ST_occupancy","ST"],["TAGGER_occupancy","TAGGER"],["TOF_occupancy","TOF"]]

    for hist in hist_names:
        message_file.write( "%s: https://halldweb.jlab.org/cgi-bin/data_monitoring/monitoring/plotBrowser.py?run1=%d&run2=%d&plot=%s&ver=rawdata_ver00 \n\n" % (hist[1], beginRun, endRun, hist[0]) )


    message_file.write( "\n ===================================================================== \n" )
    message_file.write( "\n \n High Level Macros: \n" )
    
    # set list of high_level titles and names in this list
    high_level_online_names = [["BCALReconstruction_p1","Recon. BCAL 1"],["BCALReconstruction_p2","Recon. BCAL 2"],["BCALReconstruction_p3","Recon. BCAL 3"],["EventInfo","Recon. Event Info"],["FCALReconstruction_p1","Recon. FCAL 1"],["FCALReconstruction_p2","Recon. FCAL 2"],["FCALReconstruction_p3","Recon. FCAL 3"],["Kinematics_p1","Recon. Kinematics 1"],["Kinematics_p2","Recon. Kinematics 2"],["Matching_BCAL","Recon. BCAL Matching"],["Matching_FCAL","Recon. FCAL Matching"],["Matching_SC","Recon. SC Matching"],["Matching_TOF","Recon. TOF Matching"],["NumHighLevelObjects","Recon. Num. High-Level Objects"],["NumLowLevelObjects_p1","Recon. Num. Low-Level Objects 1"],["NumLowLevelObjects_p2","Recon. Num. Low-Level Objects 2"],["SCReconstruction_p1","Recon. SC 1"],["SCReconstruction_p2","Recon. SC 2"],["TOFReconstruction_p1","Recon. TOF 1"],["TOFReconstruction_p2","Recon. TOF 2"],["Tracking_p1","Recon. Tracking 1"],["Tracking_p2","Recon. Tracking 2"],["Tracking_p3","Recon. Tracking 3"],["TrackMultiplicity",",Recon. Track Multiplicity"]]

    for hist in high_level_online_names:
        message_file.write( "%s: https://halldweb.jlab.org/cgi-bin/data_monitoring/monitoring/plotBrowser.py?run1=%d&run2=%d&plot=HistMacro_%s&ver=rawdata_ver00 \n\n" % (hist[1], beginRun, endRun, hist[0]) )

    # set list of high_level titles and names in this list
   # high_level_names = [["Beam","Beam"],["Vertex","Vertex"],["Trigger","Trigger"],["NumHighLevelObjects","# HL Obj"],["PID","PID"],["Kinematics","Kinematics"]]

    #for hist in high_level_names:
    #    message_file.write( "%s: https://halldweb.jlab.org/cgi-bin/data_monitoring/monitoring/plotBrowser.py?run1=%d&run2=%d&plot=HistMacro_%s&ver=rawdata_ver00 \n\n" % (hist[1], beginRun, endRun, hist[0]) )

    message_file.close()

if __name__=="__main__":
    main()
