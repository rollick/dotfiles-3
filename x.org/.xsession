#!/bin/bash
# Do some stuff if no Display Manager is used
if [[ -z ${DESKTOP_SESSION} ]]; then
	export DESKTOP_SESSION="gnome"
	export GNOME_DESKTOP_SESSION=1

	# Start policykit agent
	if [[ -x //usr/lib/mate-polkit/polkit-mate-authentication-agent-1 ]]; then
		/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
	fi

	# Start GNOME Keyring daemon
	if which gnome-keyring-daemon >/dev/null 2>&1; then
		export $(gnome-keyring-daemon --start)
	fi
fi

# Merge user Xdefaults
if which xrdb >/dev/null 2>&1; then
	xrdb -merge ~/.Xdefaults &
fi

# Load keyboard tweaks
if which xmodmap >/dev/null 2>&1; then
	if [[ -e ${HOME}/.Xmodmap ]]; then
		xmodmap "${HOME}/.Xmodmap" &
	fi
fi

# Enable disable numlock
if which numlockx >/dev/null 2>&1; then
	if [[ -e "${XDG_DATA_HOME:-${HOME}/.local/share}/numlock_on" ]];then
		numlockx on &
	else
		numlockx off &
	fi
fi
