#!/usr/bin/python

import datetime
import os
#os.environ["RCDB_HOME"] = "/group/halld/www/halldweb/html/rcdb_home"
os.environ["RCDB_HOME"] = "/u/home/gluex/rcdb/"
import sys
#sys.path.append("/group/halld/www/halldweb/html/rcdb_home/python")
sys.path.append("/u/home/gluex/rcdb/python")
import rcdb

import time
import datetime

db = rcdb.RCDBProvider("mysql://rcdb@hallddb/rcdb")

# main function
# This is where the program starts
def main():

    # date and time for 24 hours previous
    beginTime = datetime.datetime.now() - datetime.timedelta(days=1) #days=1
    beginRun = 0
    CurrentPeriod = "RunPeriod-2019-11"#"RunPeriod-2017-01"
    #print beginTime
    # get first and last runs for the last 24 hours
    query = r'event_count%3E10000' # and time > %s" % beginTime
    queryfor_rcdb = r'event_count>10000' # and time > %s" % beginTime
    queryshow = ""
    runs = db.select_runs(queryfor_rcdb,70000,80000)
    #print runs
    for run in runs:
        print run.number
        print run.end_time
        print beginTime
        if beginTime is None:
            continue
        if run.end_time > beginTime:
            beginRun = run.number
            break
    endRun = runs[-1].number

    # check for new runs
    if beginRun == 0:
        sys.exit()

    # write message file
    #message_file = open("./message.txt", "w")
    #message_file = open("/group/halld/Software/scripts/simple_email_list/lists/monitoring_update/message.txt", "w")
    message_file = open("/home/gluex/simple_email_list/lists/monitoring_update/message.txt", "w")
    #message_file = open("/u/home/gluex/bin/message.txt", "w") # just for testing

    message_file.write( "Plot browser links for yesterday's runs (since %s): Runs included %d-%d \n\n" % (beginTime.strftime("%Y-%m-%d %H:%M:%S"), beginRun, endRun) )
    message_file.write( "\n ===================================================================== \n" )
    message_file.write( "Occupancy Macros: \n" )
    
    # set list of histograms titles and names in this list
    hist_names = [["CDC_occupancy","CDC"],["FDC_occupancy","FDC"],["FCAL_occupancy","FCAL"],["BCAL_occupancy","BCAL"],["PS_occupancy","PS"],["RF_TPOL_occupancy","RF & TPOL"],["ST_occupancy","ST"],["TAGGER_occupancy","TAGGER"],["TOF_occupancy","TOF"],["DigiHits_occupancy","Hit Multiplicity"],["DIRC_occupancy","DIRC South"],["DIRC_North_occupancy","DIRC North"],["DIRC_hit","DIRC Hits"],["DIRC_digihit","DIRC DigiHits"],["CCAL_occupancy","CCAL occupancy"]]
#,["ccal_cluster_et","CCAL Cluster et"],["ccal_cluster_space","CCAL Cluster Space"],["ccal_comp2","CCAL Comp 2"],["ccal_comp","CCAL Comp"],["ccal_dig_pedestal","CCAL Digi Pedestal"],["ccal_dig_pulse","CCAL Digi Pulse"],["ccal_hit_energy","CCAL Hit Energy"]]

    for hist in hist_names:
        message_file.write( "%s: https://halldweb.jlab.org/data_monitoring/Plot_Browser.html?minRunNum=%d&maxRunNum=%d&RunPeriod=%s&Version=rawdata_ver00&Plot=%s&rcdb_query=%s \n\n" % (hist[1], beginRun, endRun, CurrentPeriod, hist[0], query) )

    message_file.write( "\n ===================================================================== \n" )
    message_file.write( "\n \n High Level Online Macros: \n" )
    
    # set list of high_level titles and names in this list
    high_level_online_names = [["Beam","HistMacro_Beam"],["Kinematics","HistMacro_Kinematics"],["NumHighLevelObjects","HistMacro_NumHighLevelObjects"],["PID","HistMacro_PID"],["Trigger","HistMacro_Trigger"],["Vertex","HistMacro_Vertex"] ]

    for hist in high_level_online_names:
        message_file.write( "%s: https://halldweb.jlab.org/data_monitoring/Plot_Browser.html?minRunNum=%d&maxRunNum=%d&RunPeriod=%s&Version=rawdata_ver00&Plot=%s&rcdb_query=%s \n\n" % (hist[0], beginRun, endRun, CurrentPeriod, hist[1], query) )

    # set list of high_level titles and names in this list
   # high_level_names = [["Beam","Beam"],["Vertex","Vertex"],["Trigger","Trigger"],["NumHighLevelObjects","# HL Obj"],["PID","PID"],["Kinematics","Kinematics"]]

    #for hist in high_level_names:
    #    message_file.write( "%s: https://halldweb.jlab.org/cgi-bin/data_monitoring/monitoring/plotBrowser.py?run1=%d&run2=%d&plot=HistMacro_%s&ver=rawdata_ver00 \n\n" % (hist[1], beginRun, endRun, hist[0]) )

    message_file.close()

if __name__=="__main__":
    main()
