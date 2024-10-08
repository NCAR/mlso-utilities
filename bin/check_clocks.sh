#!/bin/sh

machines=( mahi dawn sunrise twilight sunset sundog1 sundog2 sundog3 nicole hazel kodiak.mlso.ucar.edu dusk.mlso.ucar.edu )
for m in "${machines[@]}"; do
  echo "checking $m..."
  ssh $m /home/mgalloy/bin/check_clock.sh
done
