#!/bin/sh
version_xml=$1
hosts="ifarm1901 jlabl4 jlabl5"
# loop over hosts
for host in $hosts
do
    echo launching on $host
    env -u SSH_AUTH_SOCK ssh -i ~/.ssh/id_batch $host \
	/home/gluex/bin/build_version_set.csh $version_xml
done
dist=/group/halld/www/halldweb/html/dist
host=ifarm1802
echo launching in singularity container on $host
env -u SSH_AUTH_SOCK ssh -i ~/.ssh/id_batch $host \
    source /etc/profile.d/modules.sh \; \
    module use /apps/modulefiles \; \
    module load singularity \; \
    singularity exec --bind /group/halld $dist/gluex_centos-7.7.1908_sng3.8_gxi2.22.sif \
    /home/gluex/bin/build_version_set.csh $version_xml
