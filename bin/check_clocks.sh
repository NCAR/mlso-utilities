#!/bin/sh

machines=( compdata mlsodata kaula mahi dawn sunrise twilight sunset kodiak.mlso.ucar.edu )
for m in "${machines[@]}"; do
  echo "checking $m..."
  ssh $m /home/mgalloy/bin/check_clock.sh
done
