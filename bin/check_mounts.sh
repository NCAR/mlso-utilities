#!/bin/sh

FAILURE=0

for m in ${MOUNTS[@]}; do
    if ! ls /hao/${m} &> /dev/null; then
	echo "/hao/${m} failed" 1>&2
	FAILURE=1
    fi
done

exit ${FAILURE}
