#!/bin/sh
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

# Disable screensaver
xset s off

# Disable DPMS
xset -dpms
