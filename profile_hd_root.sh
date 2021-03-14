#!/bin/bash
cd /scratch/gluex
mkdir -p profile_hd_root
cd profile_hd_root
perf record -g hd_root -PEVENTS_TO_KEEP=10000 -PPLUGINS=danarest /cache/halld/RunPeriod-2017-01/rawdata/hd_rawdata_030300_000.evio
perf report --call-graph fractal --stdio > hd_root_call_graph.txt
