#!/bin/bash

tmux_domain=''

domain=$(hostname -d 2>/dev/null)
colour=colour$((16#$( $domain | md5sum | cut -b-2)))
tmux_domain="#[fg=colour16,bg=${colour},bold] ${domain}"

echo "$tmux_domain "
