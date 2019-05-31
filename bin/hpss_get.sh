#!/bin/sh

# need both hpss and local dir arguments to work
if [ $# -lt 2 ]; then
  echo "usage: $(basename $0) hpss_dir local_root [output_file]"
  echo
  echo "positional arguments:"
  echo "  hpss_dir      directory to download, i.e., /CORDYN/COMP/2018"
  echo "  local_root    local directory to download files to"
  echo "  output_file   output file for hsi commands"
  exit 1
fi

HSI=/opt/local/bin/hsi
HPSS_DIR=$1
LOCAL_ROOT=$2

if [ $# -lt 3 ]; then
  OUTPUT=hsi_cmds
else
  OUTPUT=$3
fi

WORKING_DIR=$(mktemp -d)

#echo "Output in ${WORKING_DIR}"

echo "Getting information from HPSS..."
hsi -P ls -PR ${HPSS_DIR} > ${WORKING_DIR}/hsi_output

echo "Extracting tape information..."
cat ${WORKING_DIR}/hsi_output | awk 'BEGIN {FS="[\t ]+"}; {if($1=="FILE") print $6,"\t",$2}' > ${WORKING_DIR}/tokenized

echo "Making local directories..."
cat ${WORKING_DIR}/hsi_output | awk 'BEGIN {FS="[\t ]+"}; {if($1=="FILE") print $2}' > ${WORKING_DIR}/files
while read f; do echo $(dirname "$f") >> ${WORKING_DIR}/dirs; done < ${WORKING_DIR}/files
sort ${WORKING_DIR}/dirs | uniq > ${WORKING_DIR}/uniq_dirs
while read f ; do mkdir -p $LOCAL_ROOT/$f; done < ${WORKING_DIR}/uniq_dirs

echo "Sorting..."
cat ${WORKING_DIR}/tokenized | sort > ${WORKING_DIR}/sorted

echo "Generating hsi input file..."
cat ${WORKING_DIR}/sorted | awk -v LOCAL_ROOT="${LOCAL_ROOT}" 'BEGIN {FS="[\t ]+"}; {print "cget", LOCAL_ROOT $2,":",$2}' > ${WORKING_DIR}/hsi_cmds

cat ${WORKING_DIR}/hsi_output | awk 'BEGIN {FS="\t"}; {print $3}' > ${WORKING_DIR}/sizes
TOTAL_SIZE=$(awk '{s+=$0} END {print s}' ${WORKING_DIR}/sizes)
echo "Total size: ${TOTAL_SIZE} bytes"

echo "# Total size: ${TOTAL_SIZE} bytes" > $OUTPUT
cat ${WORKING_DIR}/hsi_cmds >> ${OUTPUT}
echo "Output written to ${OUTPUT}"

echo "Cleaning up..."
rm -rf ${WORKING_DIR}

echo "Done"
