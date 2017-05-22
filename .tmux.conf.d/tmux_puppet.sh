#!/bin/bash
export SUDO_ASKPASS=/bin/false

if sudo grep -qE 'server.+ask' /etc/puppet/puppet.conf;
then
    echo '#[fg=colour15,bg=colour9,bold] ✘ puppet disabled ';
else
    [ -f /etc/init.d/puppet ] && daemon='/etc/init.d/puppet' || daemon='service puppet'
    sudo $daemon status 2>&1 >/dev/null || echo '#[fg=colour0,bg=colour15,bold] ✘ puppet stopped '
fi
