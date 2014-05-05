#!/bin/zsh
# This script is run when ZSH is invoked as a login shell.
# Remember .zprofile is loaded before .zshrc. If you want to run things in a
# login shell after .zshrc is loaded use .zlogin.

# Make sure ~/.profile is always loaded.
if [[ -e "${HOME}/.profile" ]]; then
	source "${HOME}/.profile"
fi

if  [[ "${TTY}" == "/dev/tty1" ]]; then
	if which startx &>|/dev/null && [[ -e "${HOME}/.xinitrc" ]]; then
		export SHLVL=0
		exec startx &>|/dev/null
	fi
fi
