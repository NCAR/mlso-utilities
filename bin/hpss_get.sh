#!/bin/sh

# need both action and instrument arguments to work
if [ $# -lt 1 ]; then
  echo "usage: $(basename $0) hpss_dir [output_file]"
  echo
  echo "positional arguments:"
  echo "  hpss_dir      directory to download, i.e., /CORDYN/COMP/2018"
  echo "  output_file   output file for hsi commands"
  exit 1
fi

HSI=/opt/local/bin/hsi
DIR=$1

if [ $# -lt 2 ]; then
  OUTPUT=hsi_cmds
else
  OUTPUT=$2
fi

WORKING_DIR=$(mktemp -d)

#echo "Output in ${WORKING_DIR}"

echo "Getting information from HPSS..."
hsi -P ls -PR ${DIR} > ${WORKING_DIR}/hsi_output

echo "Extracting tape information..."
cat ${WORKING_DIR}/hsi_output | awk 'BEGIN {FS="\t"}; {if($1=="FILE") print $6, "\t", $2}' > ${WORKING_DIR}/tokenized

echo "Sorting..."
cat ${WORKING_DIR}/tokenized | sort > ${WORKING_DIR}/sorted

echo "Generating hsi input file..."
cat ${WORKING_DIR}/sorted | awk 'BEGIN {FS="\t"}; {print "cget" $2}' > ${WORKING_DIR}/hsi_cmds

cp ${WORKING_DIR}/hsi_cmds ${OUTPUT}
echo "Output written to ${OUTPUT}"

echo "Cleaning up..."
rm -rf ${WORKING_DIR}

echo "Done"
