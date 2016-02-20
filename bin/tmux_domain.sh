#!/bin/bash

tmux_domain=''

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
    '')
        tmux_domain=''
        ;;
    *)
        colour=colour$((16#$( $domain | md5sum | cut -b-2)))
        tmux_domain="#[fg=colour16,bg=${colour},bold] ${domain}"
        ;;
esac

echo "$tmux_domain "
