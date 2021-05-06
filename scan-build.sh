#!/bin/bash
cd /u/scratch/gluex
rm -rf scan-build-work
mkdir scan-build-work
cd scan-build-work
. /group/halld/Software/build_scripts/gluex_env_boot_jlab.sh
gxenv
# hdds
unset HDDS_VERSION
unset HDDS_DIRTAG
scan-build -o /group/halld/www/halldweb/html/scan-build/hdds make -f $BUILD_SCRIPTS/Makefile_hdds >& hdds.log
tail hdds.log
# halld_recon
unset HALLD_RECON_VERSION
unset HALLD_RECON_DIRTAG
scan-build -o /group/halld/www/halldweb/html/scan-build/halld_recon make -f $BUILD_SCRIPTS/Makefile_halld_recon >& halld_recon.log
tail halld_recon.log
# halld_sim
unset HALLD_SIM_VERSION
unset HALLD_SIM_DIRTAG
scan-build -o /group/halld/www/halldweb/html/scan-build/halld_sim make -f $BUILD_SCRIPTS/Makefile_halld_sim >& halld_sim.log
tail halld_sim.log
# hdgeant4
unset HDGEANT4_VERSION
unset HDGEANT4_DIRTAG
scan-build -o /group/halld/www/halldweb/html/scan-build/hdgeant4 make -f $BUILD_SCRIPTS/Makefile_hdgeant4 >& hdgeant4.log
tail hdgeant4.log
