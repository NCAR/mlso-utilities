#!/bin/sh

LOG_FILENAME=/home/mgalloy/clock_data/clocks.log

machines=( mahi dawn sunrise twilight sunset sundog1 sundog2 sundog3 nicole hazel kodiak.mlso.ucar.edu dusk.mlso.ucar.edu )
times="$(date +%s)"
for m in "${machines[@]}"; do
  times="$times, $(ssh -i /home/mgalloy/.ssh/id_rsa2 $m date +%s)"
done

echo "$times" >> $LOG_FILENAME
