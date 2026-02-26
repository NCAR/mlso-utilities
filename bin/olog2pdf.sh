#!/bin/sh

OLOG_FILENAME=$1

DATE=${OLOG_FILENAME:5:8}

BIN_DIR=$(dirname $0)
YYYYMMDD_DATE=$(${BIN_DIR}/yyyyddoy2yyyymmdd.py ${DATE})

TEXT_FILENAME=mlso_observer_log.${YYYYMMDD_DATE}.txt
PS_FILENAME=mlso_observer_log.${YYYYMMDD_DATE}.ps
PDF_FILENAME=mlso_observer_log.${YYYYMMDD_DATE}.pdf

echo "creating ${PDF_FILENAME}..."
cp ${OLOG_FILENAME} ${TEXT_FILENAME}

enscript_cmd="enscript --no-header --output ${PS_FILENAME} ${TEXT_FILENAME}"
echo ${enscript_cmd}
${enscript_cmd}

ps2pdf_cmd="ps2pdf ${PS_FILENAME} ${PDF_FILENAME}"
echo ${ps2pdf_cmd}
${ps2pdf_cmd}

rm -f ${PS_FILENAME}

