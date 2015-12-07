#!/bin/bash
# Set XDG paths
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

if [[ -f "${XDG_CONFIG_HOME}/user-dirs.dirs" ]]; then
	source "${XDG_CONFIG_HOME}/user-dirs.dirs"
fi
export XDG_DESKTOP_DIR="${XDG_DESKTOP_DIR:-${HOME}}"
export XDG_DOCUMENTS_DIR="${XDG_DOCUMENTS_DIR:-${HOME}/Documents}"
export XDG_DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-${HOME}/Downloads}"
export XDG_MUSIC_DIR="${XDG_MUSIC_DIR:-${HOME}/Music}"
export XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-${HOME}/Pictures}"
export XDG_PUBLICSHARE_DIR="${XDG_PUBLICSHARE_DIR:-${HOME}/Public}"
export XDG_TEMPLATES_DIR="${XDG_TEMPLATES_DIR:-${HOME}/Templates}"
export XDG_VIDEOS_DIR="${XDG_VIDEOS_DIR:-${HOME}/Videos}"

# Use XDG dirs in various programs
export DVDCSS_CACHE="${XDG_CACHE_HOME}/dvdcss"
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"
export PYTHON_EGG_CACHE="${XDG_CACHE_HOME}/python-eggs"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python_startup.py"
export WORKON_HOME="${XDG_DATA_HOME}/virtualenvs"

# Fix for unknown terminals
if [[ -n "${SSH_CONNECTION}" ]] || [[ ! -z "${SSH_TTY}" ]]; then
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
export LESSHISTFILE="${XDG_CACHE_HOME}/less_history"
export SYSTEMD_LESS="${LESS}"

# Set LS_COLORS
eval `dircolors --sh`

# Load lesspipe, which provides advanced functions for less
which lesspipe.sh >/dev/null 2>&1 && eval $(lesspipe.sh)
which lesspipe >/dev/null 2>&1 && eval $(lesspipe)

# Set default encrypted session via rsync to ssh
if which ssh >/dev/null 2>&1; then
	export RSYNC_RSH="ssh"
fi
