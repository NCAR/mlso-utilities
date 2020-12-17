#!/bin/sh

SSH_KEY=/home/mgalloy/.ssh/id_rsa2

backup_location=/home/mgalloy/data/crontabs

day=$(date +"%d")

machines=( compdata mlsodata kaula mahi dawn sunrise twilight sunset )
for m in "${machines[@]}"; do
  #echo "checking $m..."
  ssh -i ${SSH_KEY} $m "crontab -l" > ${backup_location}/$m-crontab-${day}.txt
done
