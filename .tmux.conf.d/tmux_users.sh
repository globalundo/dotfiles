#!/bin/bash

USERS=$(who | awk '{print $1}' | grep -v "$USER" | sort | uniq | tr '\n' ' ')
[ -z "$USERS" ] || echo "#[fg=colour16,bg=colour11,bold] ${USERS}"
