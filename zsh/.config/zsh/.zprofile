# This script is run when ZSH is invoked as a login shell.
# Remember .zprofile is loaded before .zshrc. If you want to run things in a
# login shell after .zshrc is loaded use .zlogin.

# Make sure ~/.profile is always loaded.
emulate sh -c "source ${HOME}/.profile"
typeset -U path

if [[ "${SHLVL}" -eq 1 && -f "${HOME}/.hushlogin" ]]; then
	clear
fi

# Start cmus
if [[ "${XDG_VTNR}" -eq 1 && "${HOST}" == "troubadix" && "${USER}" == "lyre" ]]; then
	exec cmus
fi

# Start X session
if [[ "${EUID}" -ne 0 && -z "${DISPLAY}" && "${XDG_VTNR}" -eq 1 ]]; then
	if [[ -o 'login' && -f "${HOME}/.xinitrc" ]]; then
		if which startx &>|/dev/null; then
			# Correct SHLVL value
			SHLVL=0

			# Start X session
			exec startx
		fi
	fi
fi
