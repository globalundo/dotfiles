alias ls='ls --color=auto'
alias l="ls -l"
alias svim="sudo -E vim"
alias g='git'
alias s='/usr/bin/subl3'
alias sfab='fab --skip-bad-hosts --hide=status,running'
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
dotfiles_send() {
    if [ ! -z "$1" ]; then
        rsync -va ~/.vimrc ~/.bashrc ~/.bash_aliases ~/.tmux.conf ~/.vim --exclude '.vim/bundle/YouCompleteMe' $1:
        rsync -va ~/.config/liquidprompt* $1:~/.config/
        rsync -va ~/bin/tmux_*.sh ~/bin/liquidprompt  $1:~/bin/
    fi
}

# Dynamic font size in urxvt
function fontsize {
    printf '\33]50;%s%d\007' "xft:Dejavu Sans Mono:size=$1::antialias=false"
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
