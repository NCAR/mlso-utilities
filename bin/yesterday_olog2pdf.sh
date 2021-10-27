#!/bin/sh

YEAR=$(date +"%Y" --date="-1 day")
cd /hao/ftp/d5/mlso/log/observer/${YEAR}

YESTERDAY_OLOG_FILENAME=$(date +"mlso.%Yd%j.olog" --date="-1 day")

OLOG2PDF=$(dirname $0)/olog2pdf.sh

${OLOG2PDF} ${YESTERDAY_OLOG_FILENAME}
