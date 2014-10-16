#!/bin/zsh

if [[ "${TTY}" == "/dev/tty1" ]] && ! pgrep Xorg.bin; then
	if which startx &>|/dev/null; then
		exec startx
	fi
fi
