#!/bin/bash
tmux_role=''
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
echo $tmux_role
