#!/bin/sh

export PATH=/opt/local/hpss/bin:$PATH

ROOT=/CORYDN

PYTHON=/home/mgalloy/anaconda3/bin/python
HPSS=/home/mgalloy/projects/mlso-utilities/bin/hpss

TO_EMAIL=mgalloy@ucar.edu
FROM_EMAIL=mgalloy@ucar.edu

HEADER="<html><body><pre>"

REPORT=$($PYTHON $HPSS $ROOT)

FOOTER="</pre></body></html>"

HTML_REPORT="$HEADER\n$REPORT\n$FOOTER"

echo -e "$HTML_REPORT" | mail -s "$(echo -e "HPSS report for $ROOT\nContent-Type: text/html")" -r $FROM_EMAIL $TO_EMAIL
