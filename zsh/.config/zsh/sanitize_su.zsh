if [[ ! -o "login" && $UID -eq 0 ]]; then
	unset XDG_CACHE_HOME
	unset XDG_CONFIG_HOME
	unset XDG_DATA_HOME
	unset XDG_DESKTOP_DIR

	unset XDG_DOWNLOAD_DIR
	unset XDG_TEMPLATES_DIR
	unset XDG_PUBLICSHARE_DIR
	unset XDG_DOCUMENTS_DIR
	unset XDG_MUSIC_DIR
	unset XDG_PICTURES_DIR
	unset XDG_VIDEOS_DIR

	export ZDOTDIR="${HOME}/.config/zsh"

	export GNUPGHOME="${XDG_CONFIG_HOME:-${HOME}/.config}/gnupg"
	export LESSHISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/less_history"
	export MAIL="${MAIL:h}/${HOME:t}"


	# Reload profile files
	source "${ZDOTDIR}/.zprofile" &>/dev/null

	if [[ -n $DISPLAY ]]; then
		emulate sh -c "source ${HOME}/.xprofile >/dev/null 2>&1"
		export XAUTHORITY="${HOME}/.Xauthority"
	fi

	# Set path
	export path=(${HOME}/.local/bin ${path})
	typeset -U path
fi
