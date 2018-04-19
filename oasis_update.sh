#!/bin/bash
rsync_comment[0]='dist directory'
rsync_command[0]='rsync -ruvtl --delete --stats -e '\''ssh -i ~/.ssh/oasis_update_rsa'\'' /group/halld/www/halldweb/html/dist/version*.xml /group/halld/www/halldweb/html/dist/*.sqlite ouser.gluex@oasis-login.opensciencegrid.org:/home/login/ouser.gluex/stage/group/halld/www/halldweb/html/dist/'
rsync_comment[1]="resources directory"
rsync_command[1]='rsync -ruvtl --delete --stats -e '\''ssh -i ~/.ssh/oasis_update_rsa'\'' /group/halld/www/halldweb/html/resources/ ouser.gluex@oasis-login.opensciencegrid.org:/home/login/ouser.gluex/stage/group/halld/www/halldweb/html/resources'
rsync_comment[2]="build_scripts directory"
rsync_command[2]='rsync -ruvtl --delete --stats -e '\''ssh -i ~/.ssh/oasis_update_rsa'\'' /group/halld/Software/build_scripts/ ouser.gluex@oasis-login.opensciencegrid.org:/home/login/ouser.gluex/stage/group/halld/Software/build_scripts/'
rsync_comment[3]="container build directory"
rsync_command[3]='rsync -ruvtl --delete --delete-excluded --exclude-from=/home/gluex/bin/oasis_exclude_build.txt --stats -e '\''ssh -i ~/.ssh/oasis_update_rsa'\'' /group/halld/Software/builds/Linux_CentOS7-x86_64-gcc4.8.5-cntr/ ouser.gluex@oasis-login.opensciencegrid.org:/home/login/ouser.gluex/stage/group/halld/Software/builds/Linux_CentOS7-x86_64-gcc4.8.5-cntr/'
rsync_stdout=/tmp/rsync_stdout.txt
rsync_script=/tmp/rsync_script.sh
files_transferred=false
for i in "${!rsync_command[@]}";
  do
  this_comment=${rsync_comment[$i]}
  this_command=${rsync_command[$i]}
  echo rsync command ${i}: $this_comment
#  echo $i $this_command
  rm -f $rsync_stdout $rsync_script
  echo '#!/bin/bash' > $rsync_script
  echo $this_command >> $rsync_script
  chmod a+x $rsync_script
  nxfer=`$rsync_script | tee $rsync_stdout | grep "Number of regular files transferred" | awk -F ":" '{print $2}'`
  echo nxfer = $nxfer
  if [ $nxfer -gt 0 ]
  then
      echo files transferred
      files_transferred=true
  else
      echo nothing transferred
  fi
  cat $rsync_stdout
  echo ___________________________________________________
  echo
done
echo files_transferred = $files_transferred
if [ "$files_transferred" = "true" ]
then
    echo do something
    ssh -i ~/.ssh/oasis_update_rsa ouser.gluex@oasis-login.opensciencegrid.org \
	osg-oasis-update
else
    echo do nothing
fi


