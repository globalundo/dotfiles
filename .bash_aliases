alias ls='ls --color=auto --group-directories-first'
alias l="ls -l"
alias ll="ls -l"
alias svim="sudo -E vim"
alias g='git'
alias s='/usr/bin/subl3'
alias sfab='fab --skip-bad-hosts --hide=status,running'
alias pfab='fab --skip-bad-hosts --hide=status,running --set=output_prefix=""'
alias vpnup='nmcli con up id globalundo.com'
alias vpndown='nmcli con down id globalundo.com'
alias takeover='tmux detach -a'

alias i='ipython'
alias ipython='ipython --no-confirm-exit --pprint --no-banner'
alias p='puppet'

alias r='ranger'

alias b='xbacklight -set '

function whatthediff {
    fab jenkins.get_diffs:$1; grep -E '^[<>]' /tmp/jenkins-diffs/* | python -c "from sys import stdin; print '\n'.join([ ''.join( _.split(':')[1:]).strip() for _ in stdin.readlines() ])" | sort -n | uniq
}

# Populate remote server with dotfiles
function dotfiles-sync {
    if [ ! -z "$1" ]; then
        builtin cd > /dev/null
        rsync -vaz --progress -R $(sed 's/^/--exclude /g' .dotfiles-exclude | tr '\n' ' ') --no-implied-dirs $(cat .dotfiles-sync | tr '\n' ' ') .dotfiles-sync $1:
        builtin cd - > /dev/null
    fi
}

function dssh {
    dotfiles-sync $@ && ssh $@
}

function sn {
    case "$1" in
    git)
        X=$(git show --pretty="format:" --name-only $2)
        [ $? -eq 0 ] && /usr/bin/subl3 -n $X
    ;;
    *)
        /usr/bin/subl3 -n "$@"
    ;;
    esac
}

function man {
    if [ "$TERM" = 'linux' ]; then
        env \
            LESS_TERMCAP_mb=$(printf "\e[34m") \
            LESS_TERMCAP_md=$(printf "\e[1;31m") \
            LESS_TERMCAP_me=$(printf "\e[0m") \
            LESS_TERMCAP_se=$(printf "\e[0m") \
            LESS_TERMCAP_so=$(printf "\e[30;43m") \
            LESS_TERMCAP_ue=$(printf "\e[0m") \
            LESS_TERMCAP_us=$(printf "\e[32m") \
                    /usr/bin/man "$@"
    else
        env \
            LESS_TERMCAP_mb=$(printf "\e[1;34m") \
            LESS_TERMCAP_md=$(printf "\e[38;5;9m") \
            LESS_TERMCAP_me=$(printf "\e[0m") \
            LESS_TERMCAP_se=$(printf "\e[0m") \
            LESS_TERMCAP_so=$(printf "\e[30;43m") \
            LESS_TERMCAP_ue=$(printf "\e[0m") \
            LESS_TERMCAP_us=$(printf "\e[38;5;10m") \
                    /usr/bin/man "$@"
    fi
}

function cd {
    builtin cd "$@" && ll -a
}
