#!/bin/bash
# Setup environment

if [[ -d "${XDG_CONFIG_HOME:-${HOME}/.config}/profile.d" ]]; then
	for f in "${XDG_CONFIG_HOME:-${HOME}/.config}/profile.d"/*.sh; do
		if [[ -x "${f}" ]]; then
			source "${f}"
		fi
	done

	unset f
fi
