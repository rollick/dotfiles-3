# This script is run when ZSH is invoked as a login shell.
# Remember .zprofile is loaded before .zshrc. If you want to run things in a
# login shell after .zshrc is loaded use .zlogin.

# Make sure ~/.profile is always loaded.
emulate sh -c "source ${HOME}/.profile"
typeset -U path

if [[ -z "${SSH_TTY}" && "${SHLVL}" -eq 1 && -f "${HOME}/.hushlogin" ]]; then
	clear
fi

# Autostart upon login
if [[ -o 'login' && "${EUID}" -ne 0 && -z "${DISPLAY}" && "$XDG_VTNR" -eq 1 ]]; then
	if [[ "${HOST}" == 'troubadix' && "${USER}"  == 'lyre' ]]; then
		if [[ -n ${commands[mocp]} ]]; then
			exec mocp
		fi
	else
		if [[ -n ${commands[startx]} && -f "${HOME}/.xinitrc" ]]; then
			# Correct SHLVL value
			export SHLVL=0

			# Start X session
			exec startx
		fi
	fi
fi
