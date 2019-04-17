#!/bin/sh

# define source and destination locations
LOCAL_ROOT_DIR=/hao/sunset/Data/KCor/mlso-cme-detection
#LOCAL_ROOT_DIR=
REMOTE_SERVER=kodiak.mlso.ucar.edu
REMOTE_ROOT_DIR=/export/data1/Data/KCor

RSYNC=/usr/bin/rsync
SSH_CMD="ssh -i $HOME/.ssh/id_rsa2"
RSYNC_OPTIONS="-am --stats --copy-unsafe-links --omit-dir-times -e \"$SSH_CMD\""

NOTIFY_EMAIL=mgalloy@ucar.edu

LOG_DIR=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXXXXXXXXX")
LOG=$LOG_DIR/output.log
#LOG=/dev/stdout

STATUS=0

# choose which subdirs of REMOTE_ROOT_DIR get sync'ed
DIRS="cme_movies engineering hpr hpr_diff logs"

for d in $DIRS; do
  cmd="$RSYNC $RSYNC_OPTIONS $REMOTE_SERVER:$REMOTE_ROOT_DIR/$d $LOCAL_ROOT_DIR"
  echo "$cmd" >> $LOG
  eval $cmd >> $LOG 2>&1

  CMD_STATUS=$?
  if [ $CMD_STATUS -ne 0 ]; then STATUS=$CMD_STATUS; fi

  echo -e "\n\n" >> $LOG
done

if [ $STATUS -eq 0 ]; then
  STATUS_MSG="success"
else
  STATUS_MSG="failure"
fi

echo "Sent by $(readlink -f $0) ($(whoami)@$(hostname))" >> $LOG
SUBJECT="Backup CME detection results from MLSO: ${STATUS_MSG}"

# send results to NOTIFY_EMAIL
cat $LOG | mail -s "$SUBJECT" \
                -r $(whoami)@ucar.edu $NOTIFY_EMAIL

# clean up
rm -rf $LOG_DIR
