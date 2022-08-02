#!/bin/sh

RSYNC=/usr/bin/rsync
RSYNC_OPTIONS="-am --stats --copy-unsafe-links --omit-dir-times"

LOG_DIR=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXXXXXXXXX")
LOG=$LOG_DIR/output.log
NOTIFY_EMAIL=mgalloy@ucar.edu

STATUS=0

backup () {
  SRC_DIR=$1
  DST_DIR=$2
  cmd="${RSYNC} ${RSYNC_OPTIONS} ${SRC_DIR} ${DST_DIR}"
  $cmd >> ${LOG}
  CMD_STATUS=$?
  if [ $CMD_STATUS -ne 0 ]; then STATUS=$CMD_STATUS; fi
}

SRC_ROOT=/hao/ftpd5/mlso/log
DST_ROOT=/hao/mahidata1/Data/Backups/log

backup ${SRC_ROOT}/observer ${DST_ROOT}
backup ${SRC_ROOT}/event ${DST_ROOT}

if [ $STATUS -eq 0 ]; then
  STATUS_MSG="success"
else
  STATUS_MSG="failure"
fi

echo "Sent by $(readlink -f $0) ($(whoami)@$(hostname))" >> $LOG
SUBJECT="Backup observer logs and events: ${STATUS_MSG}"

# send results to NOTIFY_EMAIL
cat $LOG | mail -s "$SUBJECT" \
                -r $(whoami)@ucar.edu $NOTIFY_EMAIL

# clean up
rm -rf $LOG_DIR
