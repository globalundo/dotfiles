#!/bin/bash
sudo grep -qE 'server.+ask' /etc/puppet/puppet.conf && echo '#[fg=colour15,bg=colour9,bold] ✘ puppet disabled ' || sudo /etc/init.d/puppet status 2>&1 >/dev/null || echo '#[fg=colour0,bg=colour15,bold] ✘ puppet stopped '
