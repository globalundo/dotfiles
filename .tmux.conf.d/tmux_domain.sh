#!/bin/bash

tmux_domain=''
MAX_LENGTH=32

d=$(hostname -d 2>/dev/null)
if ! [[ -z $d ]]; then
    if [ ${#d} -lt $MAX_LENGTH ]; then
        domain=$d;
    else
        # sublength=$(($MAX_LENGTH/2-2))
        # domain=${d:0:${sublength}}...${d:$NF-${sublength}:${sublength}}
        domain=${d:$NF-32:32}
    fi
    colour=colour$((16#$(echo $d | md5sum | cut -b-2)))
    tmux_domain="#[fg=colour15,bg=${colour},bold] ${domain}";
fi
echo "$tmux_domain"
