#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PATH
export PATH=$PATH:~/bin
export XDG_CONFIG_HOME=~/.config

# Colors
if [[ $TERM = *-256color ]]; then
  export TERM="screen-256color"
fi

# Default editor
[ -z ${DISPLAY+x} ] && EDITOR=$(type -p vim vi nano | head -n 1) || EDITOR=$(type -p subl sublime_text subl3 vim vi nano | head -n 1)
export EDITOR=$EDITOR
export GIT_EXPORT=$(type -p vim vi nano | head -n 1)

if [ -z "$SSH_CONNECTION" ];
then
    # Start keychain ad set SSH_AGENT variable(s)
    eval $(keychain --confhost --eval --quick --quiet)
    # Close unused terminal windows after N seconds
    export TMOUT=600

else
    # If tmux binary is present -> start or attach to tmux
    if type tmux >/dev/null;
    then
        if [ -z ${TMUX+x} ];
        then
            tmux attach -d || tmux new
        fi
    fi
fi

# History
#
# Populate history file if missing
if [ ! -f $HISTFILE ]; then
    echo history >> $HISTFILE
    chmod 600 $HISTFILE
fi
shopt -s histappend
shopt -s cmdhist # one command per line
shopt -s autocd
shopt -s cdspell
shopt -s checkjobs
shopt -s checkwinsize
shopt -s dirspell

HISTFILESIZE=10000000
HISTSIZE=10000000
HISTCONTROL=ignoreboth
HISTIGNORE='ls:l:la:ls++:bg:fg:history'
# PROMPT_COMMAND='history -a'
# PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# CVS
# export CVS_RSH=ssh
# export CVSROOT=':ext:globalundo@localhost.localdomain:/var/cvs'

# If Skype doing bad thinds:
# export PULSE_LATENCY_MSEC=60

# Gpodder default data dir
#export GPODDER_DOWNLOAD_DIR='/data/globalundo/Podcasts'

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bash_custom ]] && . ~/.bash_custom

. ~/bin/liquidprompt

builtin true
