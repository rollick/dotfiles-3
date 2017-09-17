#!/bin/bash
# Setup environment

if [[ -d "${XDG_CONFIG_HOME:-${HOME}/.config}/profile.d" ]]; then
	for f in "${XDG_CONFIG_HOME:-${HOME}/.config}/profile.d"/*.sh; do
		if [[ -x "${f}" ]]; then
			source "${f}"
		fi
	done
fi

# Add some directories to path
if [[ -d "${HOME}/.local/bin" ]]; then
	export PATH="${HOME}/.local/bin:${PATH}"
fi

# Set LS_COLORS
if [[ -f "${XDG_CONFIG_HOME:-${HOME}/.config}/dircolors" ]]; then
	source "${XDG_CONFIG_HOME:-${HOME}/.config}/dircolors"
else
	eval "$(dircolors --sh)"
fi
