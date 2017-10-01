#!/bin/bash
# Executed for each X session

if [[ -d "${XDG_CONFIG_HOME:-${HOME}/.config}/xorg/xsession.d" ]]; then
	for f in "${XDG_CONFIG_HOME:-${HOME}/.config}/xorg/xsession.d"/*.sh; do
		if [[ -x "${f}" ]]; then
			source "${f}"
		fi
	done
fi
