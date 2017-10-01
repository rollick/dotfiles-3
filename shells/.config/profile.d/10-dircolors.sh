#!/bin/bash
# Set LS_COLORS

if [[ -f "${XDG_CONFIG_HOME:-${HOME}/.config}/dircolors" ]]; then
	source "${XDG_CONFIG_HOME:-${HOME}/.config}/dircolors"
else
	eval "$(dircolors --sh)"
fi
