#!/bin/bash
tmux_puppet=''

if sudo grep -qE 'server.+ask' /etc/puppet/puppet.conf; then
    tmux_puppet='#[fg=colour15,bg=colour9,bold] ✘ puppet disabled '
elif sudo /etc/init.d/puppet status | grep -q 'puppet cronjob is disabled'; then
    tmux_puppet='#[fg=colour0,bg=colour15,bold] ✘ puppet stopped '
fi

echo "$tmux_puppet"
