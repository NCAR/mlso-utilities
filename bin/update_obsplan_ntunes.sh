#!/bin/sh

for obs_day in $(seq 721 1000); do
cmd="update comp_file t join comp_file s on left(s.file_name, 15) = left(t.file_name, 15) and s.file_id <> t.file_id set t.ntunes = s.ntunes, t.obs_plan = s.obs_plan where t.obs_day = ${obs_day} and (t.obs_plan = '' or t.obs_plan is NULL) and t.wavetype = '1074' and t.producttype in (20, 21) and t.ntunes is NULL and s.ntunes is not NULL and s.obs_plan <> '';"

echo "Update obs_day=${obs_day}..."
#echo "$cmd"
mysql -u pipeline_rw -e "$cmd"

done

