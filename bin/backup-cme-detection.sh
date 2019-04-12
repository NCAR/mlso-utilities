#!/bin/sh

# define source and destination locations
LOCAL_ROOT_DIR=/hao/sunset/Data/KCor/mlso-cme-detection
REMOTE_SERVER=kodiak.mlso.ucar.edu
REMOTE_ROOT_DIR=/export/data1/Data/KCor

RSYNC_OPTIONS="-av --stats --copy-unsafe-links --omit-dir-times --prune-empty-dirs"

NOTIFY_EMAIL=mgalloy@ucar.edu

LOG=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXXXXXXXXX")/output.log

STATUS=0

# choose which subdirs of REMOTE_ROOT_DIR get sync'ed
DIRS="cme_movies engineering hpr hpr_diff logs"

for d in $DIRS; do
  cmd="rsync $RSYNC_OPTIONS $REMOTE_SERVER:$REMOTE_ROOT_DIR/$d $LOCAL_ROOT_DIR/$d"
  echo "$cmd" >> $LOG
  $cmd >> $LOG

  if [ $? -ne 0 ]; then STATUS=$?; fi
  echo -e "\n\n" >> $LOG
done

if [ "$STATUS" == "0" ]; then
  STATUS_MSG="success"
else
  STATUS_MSG="failure"
fi

echo "Sent by $(readlink -f $0) ($(whoami)@$(hostname))" >> $LOG

# send results to NOTIFY_EMAIL
cat $LOG | mail -s "Backup CME detection results from MLSO: $STATUS_MSG" \
                -r $(whoami)@ucar.edu $NOTIFY_EMAIL

# clean up
rm -rf $LOG_DIR
