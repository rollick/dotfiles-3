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

# Enable/disable numlock
if which numlockx >/dev/null 2>&1; then
	if  [[ -f "${XDG_DATA_HOME:-${HOME}/.local/share}/numlock_on" ]]; then
		numlockx on &
	elif  [[ -f "${XDG_DATA_HOME:-${HOME}/.local/share}/numlock_off" ]]; then
		numlockx off &
	elif [[ -d "/sys/class/module/battery" ]] || [[ -d "/proc/acpi/battery" ]]; then
		# Disable numlock except when a external keyboard is connected,
		if [[ $(find "/dev/input/by-path" -type l -name "*-kbd" | wc -l) -gt 1 ]]; then
			numlockx on &
		else
			numlockx off &
		fi
	else
		numlockx on &
	fi
fi

# Disable bell
xset -b
