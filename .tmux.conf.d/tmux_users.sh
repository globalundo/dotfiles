#!/bin/bash

USERS=$(who -q | head -n 1 | sed "s/$USER//g" | tr -d '\n')
[ -z "$USERS" ] || echo "#[fg=colour16,bg=colour11,bold]${USERS}"
