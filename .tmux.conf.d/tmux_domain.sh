#!/bin/bash

xcolor2rgb(){
    dec=$(($1%256))   ### input must be a number in range 0-255.
    if [ "$dec" -lt "16" ]; then
        bas=$(( dec%16 ))
        mul=128
        [ "$bas" -eq "7" ] && mul=192
        [ "$bas" -eq "8" ] && bas=7
        [ "$bas" -gt "8" ] && mul=255
        a="$((  (bas&1)    *mul ))"
        b="$(( ((bas&2)>>1)*mul ))"
        c="$(( ((bas&4)>>2)*mul ))"
         echo "$a" "$b" "$c"
    elif [ "$dec" -gt 15 ] && [ "$dec" -lt 232 ]; then
        b=$(( (dec-16)%6  )); b=$(( b==0?0: b*40 + 55 ))
        g=$(( (dec-16)/6%6)); g=$(( g==0?0: g*40 + 55 ))
        r=$(( (dec-16)/36 )); r=$(( r==0?0: r*40 + 55 ))
        echo "$r" "$g" "$b"
    else
        gray=$(( (dec-232)*10+8 ))
        echo "$gray" "$gray" "$gray"
    fi
}

luminace(){
    max=$(echo "$1" "$2" "$3" | tr ' ' '\n' | sort -rn | head -n 1)
    min=$(echo "$1" "$2" "$3" | tr ' ' '\n' | sort -rn | tail -n 1)
    echo $(((max+min)/255))
}

tmux_domain=''
MAX_LENGTH=32

d=$(hostname -d 2>/dev/null)
if ! [[ -z $d ]]; then
    if [ ${#d} -lt $MAX_LENGTH ]; then
        domain=$d;
    else
        # sublength=$(($MAX_LENGTH/2-2))
        # domain=${d:0:${sublength}}...${d:$NF-${sublength}:${sublength}}
        domain=${d:$NF-32:32}
    fi

    color=$((16#$(echo "$d" | md5sum | cut -b-2)))

    xbgcolor=colour${color}
    rgb=$(xcolor2rgb $color)
    lum=$(luminace "$rgb")
    [ "$lum" -eq 1 ] && xfgcolor=colour16 || xfgcolor=colour15

    tmux_domain="#[fg=${xfgcolor},bg=${xbgcolor},bold] ${domain} ";
fi
echo "$tmux_domain"
