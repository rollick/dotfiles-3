#!/bin/bash

# Fix for unknown terminals
if [[ -n "${SSH_CONNECTION}" ]]; then
	export TERM='xterm'
fi

# Add some directories to path
if [[ -d "/usr/lib/colorgcc/bin" ]]; then
	export PATH="/usr/lib/colorgcc/bin:${PATH}"
fi
if [[ -d "${HOME}/.local/bin" ]]; then
	export PATH="${HOME}/.local/bin:${PATH}"
fi

# Search these directories with pacdiff
export DIFFSEARCHPATH='/boot /etc /usr /var'

# Set applications
export DIFFPROG='nvim -d'
export EDITOR='nvim'
export MANPAGER='less'
export PAGER='less'
export READNULLCMD='less'
export SYSTEMD_PAGER='cat'
export VISUAL='nvim'

# Set width for manpages
export MANWIDTH='80'

# Settings for less
export LESS='-~-J-R-s'
export LESSHISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/less_history"
export SYSTEMD_LESS="${LESS}"

# Settings for startup
export PYTHONSTARTUP="${XDG_CONFIG_HOME:-${HOME}/.config}/python_startup.py"

# Set LS_COLORS
if [[ -f "${XDG_CONFIG_HOME:-${HOME}/.config}/dircolors" ]]; then
	source "${XDG_CONFIG_HOME:-${HOME}/.config}/dircolors"
else
	eval "$(dircolors --sh)"
fi

# Colorize man when using less as pager
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;5;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

# Load lesspipe, which provides advanced functions for less
which lesspipe >/dev/null 2>&1 && eval "$(lesspipe)"
which lesspipe.sh >/dev/null 2>&1 && eval "$(lesspipe.sh)"

# Set path for gnupg
export GNUPGHOME="${XDG_CONFIG_HOME:-${HOME}/.config}/gnupg"

# Set path for virtualenvwrapper
export WORKON_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/virtualenvs"

# Set default encrypted session via rsync to ssh
if which ssh >/dev/null 2>&1; then
	export RSYNC_RSH='ssh'
fi

# Settings for libdvdcss
export DVDCSS_CACHE="${XDG_CACHE_HOME:-${HOME}/.cache}/dvdcss"

# Set path to Xauthority file
export XAUTHORITY="${XDG_RUNTIME_DIR:-/run/user/${UID}}/Xauthority"

# Set path for tmux' tempory files
export TMUX_TMPDIR="${XDG_RUNTIME_DIR}/tmux"
