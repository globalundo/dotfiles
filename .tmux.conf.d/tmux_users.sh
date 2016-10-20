#!/bin/bash

USERS=$(who | awk '{print $1}' | grep -v oleg.mikhaylov | sort | uniq | tr '\n' ' ')
[ -z "$USERS" ] || echo "#[fg=colour16,bg=colour11,bold] ${USERS}"
