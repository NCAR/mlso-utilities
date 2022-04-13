#!/bin/sh

PYTHON=/home/mgalloy/anaconda3/bin/python
ROOT=$(dirname $0)
DOIS=${ROOT}/$1
OUTPUT_FILENAME=$(mktemp /tmp/doi-check.XXXXXXXXX)

${PYTHON} ${ROOT}/mlso_check_dois.py ${DOIS} > ${OUTPUT_FILENAME}
STATUS=$?

echo "Sent from $0 ($(whoami)@$(hostname))" >> ${OUTPUT_FILENAME}

if [ $STATUS -eq 0 ]; then
  STATUS_DESCRIPTION=success
else
  STATUS_DESCRIPTION=failure
fi

SUBJECT="MLSO DOI resolution check (${STATUS_DESCRIPTION})"

cat ${OUTPUT_FILENAME} | mail -s "${SUBJECT}" mgalloy@ucar.edu
