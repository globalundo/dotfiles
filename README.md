![tmux logo](https://tmux.github.io/logo.png)

### Files:
- .tmux.conf
- .tmux.20.conf
- .tmux.21.conf
- bin/tmux_puppet.sh
- bin/tmux_domain.sh

### Install
Copy files to your home folder:
```find . -type f -name '*tmux*' | xargs -I % cp --parents % ~```

### Hotkeys
Set CapsLock as a modifier key in tmux:
```xmodmap -e 'keycode 0x42 = F10 >> ~/.xprofile && ~/.xprofile'```

[Hotkeys on actual keyboard](https://globalundo.github.io/ShortcutMapper/#tmux)

# [Compton](https://github.com/chjj/compton)
# [xbindkeys](http://git.savannah.gnu.org/cgit/xbindkeys.git/)
# [rofi](https://github.com/DaveDavenport/rofi)
# [urxvt](https://github.com/exg/rxvt-unicode)
