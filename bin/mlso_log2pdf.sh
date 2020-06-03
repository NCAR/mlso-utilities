#!/bin/sh

canonicalpath() {
  if [ -d $1 ]; then
    pushd $1 > /dev/null 2>&1
    echo $PWD
  elif [ -f $1 ]; then
    pushd $(dirname $1) > /dev/null 2>&1
    echo $PWD/$(basename $1)
  else
    echo "Invalid path $1"
  fi
  popd > /dev/null 2>&1
}


# syntax: mlso_log2pdf.sh [LOG_FILENAME]

LOG_FILENAME=${1}

SCRIPT=$(canonicalpath $0)
SRC_ROOT=$(basename ${SCRIPT})

TMP_FILE=$(mktemp tmp.XXXXXXXXXX.tex)
echo $TMP_FILE

LATEX=pdflatex

echo "\documentclass[9pt]{article}\usepackage[margin=0.75in]{geometry}\usepackage{listings}\lstset{basicstyle=\small\ttfamily,breaklines=true,breakautoindent=false,breakindent=0pt}\begin{document}\begin{lstlisting}" >> ${TMP_FILE}
cat ${LOG_FILENAME} >> ${TMP_FILE}
echo "\end{lstlisting}\end{document}" >> ${TMP_FILE}

JOBNAME=$(basename ${LOG_FILENAME} .olog)

${LATEX} -jobname=${JOBNAME} ${TMP_FILE}

rm -f ${JOBNAME}.{aux,log}
rm -f ${TMP_FILE}
