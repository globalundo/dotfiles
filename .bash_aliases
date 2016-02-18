# If running locally
if [ -z "$SSH_CONNECTION" ]; then
    # Automatically parse and add ssh key from ~/.ssh/config
    alias ssh='/usr/local/bin/ssh_add_hook.py';
fi

alias ls='ls --color=auto'
alias l="ls -l"
alias svim="sudo -E vim"
alias g='git'
alias s='/usr/bin/subl3'
alias sn='/usr/bin/subl3 -n'
alias sfab='fab --skip-bad-hosts --hide=status,running'
alias vpnup='nmcli con up id globalundo.com'
alias vpndown='nmcli con down id globalundo.com'
alias takeover='tmux detach -a'
function whatthediff {
    fab jenkins.get_diffs:$1; grep -E '^[<>]' /tmp/jenkins-diffs/* | python -c "from sys import stdin; print '\n'.join([ ''.join( _.split(':')[1:]).strip() for _ in stdin.readlines() ])" | sort -n | uniq
}

# Delete orphans packages
# orphans() {
#   if [[ ! -n $(pacman -Qdt) ]]; then
#     echo "No orphans to remove."
#   else
#     sudo pacman -Rns $(pacman -Qdtq)
#   fi
# }

# Populate remote server with dotfiles
dotfiles_send() {
    if [ ! -z "$1" ]; then
        rsync -va ~/.vimrc ~/.bashrc ~/.bash_aliases ~/.tmux.conf ~/.vim --exclude '.vim/bundle/YouCompleteMe' $1:
    fi
}

# Dynamic font size in urxvt
function fontsize {
    printf '\33]50;%s%d\007' "xft:Dejavu Sans Mono:size=$1::antialias=false"
}
