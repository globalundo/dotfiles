#!/bin/bash
ENV_ETAG=${LC_PAPER:='empty env tag'}
FILES_ETAG=$(cat ~/.dotfiles-etag 2>/dev/null || echo "empty files tag")
if [ "$ENV_ETAG" != "$FILES_ETAG" ]; then
    echo '#[fg=colour11,bg=colour6,bold] ▲ ';
else
    echo ''
fi
