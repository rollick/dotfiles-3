#!/bin/zsh

if [[ -z ${DISPLAY} && ${XDG_VTNR} -eq 1 ]]; then
	if which startx &>|/dev/null; then
		exec startx
	fi
fi
