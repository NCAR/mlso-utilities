#!/bin/sh

TO=mgalloy@ucar.edu

if [ $# -lt 2 ]; then
  MONTH=$(date -d "-1 day" +"%m")
else
  MONTH=$2
fi

if [ $# -lt 1 ]; then
  YEAR=$(date -d "-1 day" +"%Y")
else
  YEAR=$1
fi

OLOG_BASEDIR=/hao/ftpd5/mlso/log/observer
OLOG_DIR=$OLOG_BASEDIR/$YEAR

DATE=${YEAR}${MONTH}01

BASENAME=$(basename $0)
TMPFILE=$(mktemp /tmp/$BASENAME.XXXXXX)

echo -e "checking ${YEAR}/${MONTH} on ${OLOG_DIR}...\n" > $TMPFILE

STATUS=0
while [ ${MONTH} -eq $(date -d ${DATE} +"%m") ]; do
  DOY=$(date -d ${DATE} +"%j")

  if [ ! -f ${OLOG_DIR}/mlso.${YEAR}d${DOY}.olog ]; then
    echo "no log for ${DATE} (mlso.${YEAR}d${DOY}.olog)" >> $TMPFILE
    STATUS=1
  fi

  DATE=$(date -d "${DATE} + 1 day" +"%Y%m%d")
done

if (( ${STATUS} )); then
  STATUS_MSG="fail"
  echo "" >> $TMPFILE
else
  STATUS_MSG="pass"
fi

echo -e "Sent from $(readlink -f $0) ($(whoami)@$(hostname))" >> $TMPFILE

MONTH_NAME=$(date -d ${YEAR}${MONTH}01 +"%b")
SUBJECT="Checking observer logs for ${MONTH_NAME} ${YEAR} (${STATUS_MSG})"
mail -s "${SUBJECT}" -r $(whoami)@ucar.edu ${TO} < $TMPFILE

rm $TMPFILE
