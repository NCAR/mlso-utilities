#!/bin/sh

umask u=rw,g=rw,o=r

YEAR=$(date +"%Y" --date="-1 day")
DIR=/hao/ftp/d5/mlso/log/observer/${YEAR}
cd ${DIR}

YESTERDAY_TXT_FILENAME=$(date +"mlso.%Yd%j.txt" --date="-1 day")
YESTERDAY_OLOG_FILENAME=$(date +"mlso.%Yd%j.olog" --date="-1 day")

OLOG2PDF=$(dirname $0)/olog2pdf.sh

if [ -f "${YESTERDAY_TXT_FILENAME}" ]; then
  mv "${YESTERDAY_TXT_FILENAME}" "${YESTERDAY_OLOG_FILENAME}"
fi

if [ -f "${YESTERDAY_OLOG_FILENAME}" ]; then
    ${OLOG2PDF} ${YESTERDAY_OLOG_FILENAME}
fi

