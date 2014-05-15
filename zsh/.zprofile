#!/bin/zsh
# This script is run when ZSH is invoked as a login shell.
# Remember .zprofile is loaded before .zshrc. If you want to run things in a
# login shell after .zshrc is loaded use .zlogin.

# Make sure ~/.profile is always loaded.
if [[ -e "${HOME}/.profile" ]]; then
	source "${HOME}/.profile"
fi