#!/bin/sh

OLOG_FILENAME=$1

DATE=${OLOG_FILENAME:5:8}
PS_FILEANME=mlso_observer_log.${DATE}.ps
PDF_FILENAME=mlso_observer_log.${DATE}.pdf

enscript -p ${PS_FILENAME} ${OLOG_FILENAME}
ps2pdf ${PS_FILENMAE} ${PDF_FILENAME}
