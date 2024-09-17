#!/bin/sh

tools=( screen xv xanim evince mplayer display eog )
for t in "${tools[@]}"; do
    if which $t &> /dev/null; then
	STATUS="👍"
    else
	STATUS="not found"
    fi
    
    echo -e "$t\t${STATUS}"
done

    
