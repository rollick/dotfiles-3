#!/bin/bash
# Executed by startx (run your window manager from here)

if [[ -d "/etc/X11/xinit/xinitrc.d" ]]; then
	for f in '/etc/X11/xinit/xinitrc.d'/*.sh; do
		if [[ -x "${f}" ]]; then
			source "${f}"
		fi
	done

	unset f
fi

# Load xprofile
if [[ -f  "${HOME}/.xprofile" ]]; then
	source "${HOME}/.xprofile"
fi

# Merge user Xdefaults
if [[ -f "${HOME}/.Xresources" ]] && which xrdb >/dev/null 2>&1; then
	xrdb -merge -I"${HOME}" "${HOME}/.Xresources" &
fi

# Load keyboard tweaks
if [[ -f "${HOME}/.Xmodmap" ]] && which xmodmap >/dev/null 2>&1; then
	xmodmap "${HOME}/.Xmodmap" &
fi

# Load session specific commands
if [[ -f "${HOME}/.xsession" ]]; then
	source "${HOME}/.xsession"
fi

# Start WM/DE
exec i3
