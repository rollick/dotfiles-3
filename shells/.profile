#!/bin/bash
# Add some directories to path
[[ -d "${HOME}/.local/bin" ]] && export PATH="${PATH}:${HOME}/.local/bin"

# Search these directories with pacdiff
if which pacdiff >/dev/null 2>&1; then
	export DIFFSEARCHPATH="/boot /etc /usr /var"
fi

# Set pager
export PAGER="less"
export MANPAGER="${PAGER}"
export READNULLCMD="${PAGER}"
export SYSTEMD_PAGER="cat"

# Set width for manpages
export MANWIDTH="80"

# Settings for less
export LESS="-~-J-R-s"
export SYSTEMD_LESS="${LESS}"
export LESSHISTFILE="/dev/null"

# Load lesspipe, which provides advanced functions for less
which lesspipe.sh >/dev/null 2>&1 && eval $(lesspipe.sh)
which lesspipe >/dev/null 2>&1 && eval $(lesspipe)

# Set editor
export EDITOR="/usr/bin/vim"
export VISUAL="${EDITOR}"

# Set default encrypted session via rsync to ssh
if which rsync >/dev/null 2>&1 && which ssh >/dev/null 2>&1; then
		export RSYNC_RSH="ssh"
fi

if which python >/dev/null 2>&1; then
	# Don't write bytecode on importing
	export PYTHONDONTWRITEBYTECODE=1

	# Set up virtual environments for python
	export WORKON_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/virtualenvs"
fi

# Set some paths for mpv
export DVDCSS_CACHE="${XDG_CACHE_HOME:-${HOME}/.cache}/dvdcss"
export MPV_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}/mpv"
