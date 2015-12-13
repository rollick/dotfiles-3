#!/bin/zsh
# This script is run when ZSH is invoked as a login shell.
# Remember .zprofile is loaded before .zshrc. If you want to run things in a
# login shell after .zshrc is loaded use .zlogin.

# Make sure ~/.profile is always loaded.
emulate sh -c "source ${HOME}/.profile >/dev/null 2>&1"
typeset -U path

# Start X session
if [[ "${UID}" -ne 0 && -z "${DISPLAY}" && "${XDG_VTNR}" -eq 1 ]]; then
	if which startx &>|/dev/null; then
		# Correct SHLVL value
		SHLVL=0

		# Start X session
		exec startx
	fi
fi
