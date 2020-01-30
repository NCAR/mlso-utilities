#!/bin/sh

LOG_FILENAME=/home/mgalloy/clock_data/clocks.log

machines=( compdata mlsodata kaula mahi dawn sunrise twilight sunset )
times="$(date +%s)"
for m in "${machines[@]}"; do
  times="$times, $(ssh -i /home/mgalloy/.ssh/id_rsa2 $m date +%s)"
done

echo "$times" >> $LOG_FILENAME
