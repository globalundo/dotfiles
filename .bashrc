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
[ -z ${DISPLAY+x} ] && EDITOR=$(type -p vim vi nano | tail -n +1 | head -n 1) || EDITOR=$(type -p subl sublime_text subl3 vim vi nano | tail -n +1 | head -n 1)
export EDITOR=$EDITOR
export GIT_EDITOR=$(type -p vim vi nano | tail -n +1 | head -n 1)

if [ -z "$SSH_CONNECTION" ];
then
    # Start keychain ad set SSH_AGENT variable(s)
    source <(keychain --confhost --eval --quick --quiet);
     # eval $(ssh-agent -s) 2>&1 &>/dev/null;

    # Close unused terminal windows after N seconds
    #if [ -z ${TMUX+x} ];
    #then
    #    export TMOUT=1200
    #else
    #    export TMOUT=''
    #fi

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

HISTFILESIZE=-1
HISTSIZE=-1
HISTCONTROL=ignoreboth
HISTIGNORE='ls:l:la:bg:fg'
# PROMPT_COMMAND='history -a'
# PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# CVS
# export CVS_RSH=ssh
# export CVSROOT=':ext:globalundo@localhost.localdomain:/var/cvs'

# If Skype doing bad thinds:
export PULSE_LATENCY_MSEC=60

# Gpodder default data dir
#export GPODDER_DOWNLOAD_DIR='/data/globalundo/Podcasts'

# Provided via dotfiles
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# Autogenerated
[[ -f /etc/bash_completion ]] && . /etc/bash_completion
[[ -f ~/.bash_completion ]] && . ~/.bash_completion

# Applies only to the local environment
[[ -f ~/.bash_custom ]] && . ~/.bash_custom

# PS1 and stuff
. ~/bin/liquidprompt

builtin true
export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
