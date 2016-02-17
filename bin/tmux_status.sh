#!/bin/bash

tmux_domain=''
tmux_role=''

    domain=$(hostname -d 2>/dev/null)

    case $domain in
        *.rsp.*)
            tmux_domain='#[fg=colour16,bg=colour9,bold] rackspace'
            ;;
        *.prod.brs.*)
            tmux_domain='#[fg=colour16,bg=colour4,bold] boreus'
            ;;
        *de.bonial.lan)
            tmux_domain='#[fg=colour16,bg=colour2,bold] office'
            ;;
        *)
            colour=colour$((16#$( $domain | md5sum | cut -b-2)))
            tmux_domain="#[fg=colour16,bg=${colour},bold] ${domain}"
            ;;
    esac

if type facter >/dev/null; then
    role=$(facter enc_role 2>/dev/null)

    case $role in
        '')
            tmux_role='#[fg=colour233,bg=colour245,bold] no role '
            ;;
        *)
            tmux_role="#[fg=colour233,bg=colour245,bold] ${role} "
            ;;
    esac

fi

echo "${tmux_domain} ${tmux_role}"
