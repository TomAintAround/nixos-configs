#!/usr/bin/env bash

SELECTED=$(fd . "$XDG_CONFIG_HOME"/home-manager/modules/tmux/sessions | \
	fzf --delimiter / --with-nth -1 --preview "" \
	--tmux right,25% --keep-right \
)

if [[ -z "$SELECTED" ]]; then
	exit
fi

bash "$SELECTED"
