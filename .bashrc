#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
            . /etc/bash_completion
    fi

function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo -e "\e[38;5;160m[$RETVAL]\e[m "
}

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo -e "\e[38;5;136m[${BRANCH}${STAT}]\e[m "
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

# Colors
if [[ $TERM = *-256color ]]; then
  export TERM="screen-256color"
  export PS1="\`nonzero_return\`\`parse_git_branch\`\[\033[38;05;73m\]\u\[\033[38;05;250m\]@\[\033[38;05;73m\]\H \[\033[38;05;33m\]\w\n\[\033[38;05;160m\]\$ \[\033[00m\]"
fi

# Default editor
export EDITOR='/usr/bin/vim'

# If running locally
if [ -z "$SSH_CONNECTION" ]; then

	# SSH-AGENT
	export SSH_AGENT_PID=$(pidof ssh-agent)
	export SSH_AUTH_SOCK=~/.ssh-socket
	if [[ -z $SSH_AGENT_PID ]]; then
	    rm -f ~/.ssh-socket
	    ssh-agent -a $SSH_AUTH_SOCK > /dev/null 2>&1
	    export SSH_AGENT_PID=$!
	fi

	# Automatically parse and add ssh key from ~/.ssh/config
	alias ssh='/usr/local/bin/ssh_add_hook.py';

else
	if [ 'type tmux' ]; then
		if [[ -z $TMUX ]]; then
			tmux attach -d || tmux
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
PROMPT_COMMAND='history -a'
HISTIGNORE='ls:l:la:ls++:bg:fg:history'
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# CVS
# export CVS_RSH=ssh
# export CVSROOT=':ext:globalundo@localhost.localdomain:/var/cvs'

# If Skype doing bad thinds:
# export PULSE_LATENCY_MSEC=60

# Gpodder default data dir
#export GPODDER_DOWNLOAD_DIR='/data/globalundo/Podcasts'

[[ -f '~/.bash_aliases' ]] && . ~/.bash_aliases
[[ -f '~/.bash_custom' ]] && . ~/.bash_custom
