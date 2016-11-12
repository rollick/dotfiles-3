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
if [[ -o 'login' && "$EUID" -ne 0 && "$XDG_VTNR" -eq 1 ]]; then
	if [[ -f "${ZDOTDIR}/autostart/${HOST}" ]]; then
		source "${ZDOTDIR}/autostart/${HOST}"
	fi
fi
