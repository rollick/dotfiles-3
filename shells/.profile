#!/bin/bash

# Fix for unknown terminals
if [[ -n "${SSH_CONNECTION}" ]]; then
	export TERM=xterm
fi

# Add some directories to path
export PATH="${HOME}/.local/bin:${PATH}"

# Search these directories with pacdiff
export DIFFSEARCHPATH="/boot /etc /usr /var"

# Set applications
export BROWSER='w3m'
export DIFFPROG='nvim -d'
export EDITOR="nvim"
export MANPAGER="less"
export PAGER="less"
export READNULLCMD="less"
export SYSTEMD_PAGER="cat"
export VISUAL="nvim"

# Set width for manpages
export MANWIDTH="80"

# Settings for less
export LESS="-~-J-R-s"
export SYSTEMD_LESS="${LESS}"

# Set LS_COLORS
eval `dircolors --sh`

# Colorize man when using less as pager

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;5;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

# Load lesspipe, which provides advanced functions for less
which lesspipe.sh >/dev/null 2>&1 && eval $(lesspipe.sh)
which lesspipe >/dev/null 2>&1 && eval $(lesspipe)

# Set default encrypted session via rsync to ssh
if which ssh >/dev/null 2>&1; then
	export RSYNC_RSH="ssh"
fi
