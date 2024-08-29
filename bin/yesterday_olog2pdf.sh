#!/bin/sh

umask u=rw,g=rw,o=r

YEAR=$(date +"%Y" --date="-1 day")
cd /hao/ftp/d5/mlso/log/observer/${YEAR}

YESTERDAY_OLOG_FILENAME=$(date +"mlso.%Yd%j.olog" --date="-1 day")

OLOG2PDF=$(dirname $0)/olog2pdf.sh

if [ -f "${YESTERDAY_OLOG_FILENAME}" ]; then
    ${OLOG2PDF} ${YESTERDAY_OLOG_FILENAME}
fi

