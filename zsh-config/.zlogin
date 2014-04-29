#!/bin/zsh
# This script is run when ZSH is invoked as a login shell.

# Make sure ~/.profile is always loaded.
if [[ -e "${HOME}/.profile" ]]; then
	source "${HOME}/.profile"
fi
