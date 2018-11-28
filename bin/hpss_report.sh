#!/bin/sh

export PATH=/opt/local/hpss/bin:$PATH

PYTHON=/home/mgalloy/anaconda3/bin/python
HPSS=/home/mgalloy/projects/mlso-utilities/bin/hpss

TO_EMAIL=mgalloy@ucar.edu
FROM_EMAIL=mgalloy@ucar.edu

$PYTHON $HPSS /CORDYN | mail -s 'HPSS /CORDYN report' -r $FROM_EMAIL $TO_EMAIL
