![tmux logo](https://tmux.github.io/logo.png)

### Files:
- .tmux.conf
- .tmux.conf.d

### Install
Copy files to your home folder:
```cp --parents -R .tmux.conf .tmux.conf.d ~```
```find . -type f -name '*tmux*' | xargs -I % cp --parents % ~```

### Hotkeys
Set CapsLock as a modifier key in tmux:
```xmodmap -e 'keycode 0x42 = F10' && echo "xmodmap -e 'keycode 0x42 = F10'" >> ~/.xprofile```

[Hotkeys on actual keyboard](https://globalundo.github.io/ShortcutMapper/#tmux)

# [urxvt](https://github.com/exg/rxvt-unicode)

### Files:
- .urxvt/ext/selection-autotransform
- .Xresources.d/urxvt

### Install
Copy files to your home folder:
```find . -type f -name '*rxvt*' | xargs -I % cp --parents % ~```

### Hotkeys
[Hotkeys on actual keyboard](https://globalundo.github.io/ShortcutMapper/#urxvt)

# [Compton](https://github.com/chjj/compton)
# [xbindkeys](http://git.savannah.gnu.org/cgit/xbindkeys.git/)
# [rofi](https://github.com/DaveDavenport/rofi)

