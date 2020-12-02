#!/bin/sh

backup_location=/home/mgalloy/data/crontabs

day=$(date +"%d")

machines=( compdata mlsodata kaula mahi dawn sunrise twilight sunset )
for m in "${machines[@]}"; do
  echo "checking $m..."
  ssh $m "crontab -l" > ${backup_location}/$m-crontab-${day}.txt
done
