#!/bin/sh
source /group/halld/Software/build_scripts/gluex_env_jlab.sh
export PATH=/apps/python/PRO/bin:$PATH
export LD_LIBRARY_PATH=/apps/python/PRO/lib:$LD_LIBRARY_PATH
ccdb
