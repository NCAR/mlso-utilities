#!/bin/sh

PYTHON=/home/mgalloy/anaconda3/bin/python
BIN_ROOT=$(dirname $0)
DATA_ROOT=/hao/mahidata1/Data/KCor

${BIN_ROOT}/kcor_report -d ${DATA_ROOT} $(date +"%Y %m")
