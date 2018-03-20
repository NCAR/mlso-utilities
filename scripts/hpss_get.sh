#!/bin/sh

HSI=hsi
DIR=$1

#WORKING_DIR=$(mktemp -d)
WORKING_DIR=/tmp/tmp.NjRGzghNG7

echo "Output in ${WORKING_DIR}"

#hsi -P ls -PR ${DIR} > ${WORKING_DIR}/hsi_output

cat ${WORKING_DIR}/hsi_output | awk 'BEGIN {FS="\t"}; {if($1=="FILE") print $6, "\t", $2}' > ${WORKING_DIR}/tokenized

cat ${WORKING_DIR}/tokenized | sort > ${WORKING_DIR}/sorted

cat ${WORKING_DIR}/sorted | awk 'BEGIN {FS="\t"}; {print "cget" $2}' > ${WORKING_DIR}/hsi_cmds

#rm -rf ${WORKING_DIR}
