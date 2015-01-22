#!/bin/bash
# Merger user Xdefaults
if which xrdb >/dev/null 2>&1; then
	xrdb -merge ~/.Xdefaults &
fi

# Load keyboard tweaks
if which xmodmap >/dev/null 2>&1; then
	if [[ -e ${HOME}/.Xmodmap ]]; then
		xmodmap "${HOME}/.Xmodmap" &
	fi
fi

# Enable disable numlock
if which numlockx >/dev/null 2>&1; then
	if [[ -e "${XDG_DATA_HOME:-${HOME}/.local/share}/numlock_on" ]];then
		numlockx on &
	else
		numlockx off &
	fi
fi
