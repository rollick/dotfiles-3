# Add some directories to the hashtable
[[ -d "/var/spool/cups-pdf/${USER}" ]] && hash -d cups-pdf="/var/spool/cups-pdf/${USER}"
[[ -d '/var/cache/pacman/pkg' ]] && hash -d paccache='/var/cache/pacman/pkg'
[[ -d '/var/log' ]] && hash -d log='/var/log'
[[ -d '/var/log/old' ]] && hash -d alog='/var/log/old'
hash -d media="/run/media/${USER}"

# Add local ABS mirror
() {
	local d

	if [[ -f '/etc/abs.conf' ]]; then
		d=$(source "/etc/abs.conf"; print "${ABSROOT/%\//}")
		if [[ -d "${d}" ]]; then
			hash -d abs="${d}"
		fi
	fi
}

# Add all git repositories inside $HOME/Projects
() {
	local d
	local gitroot="${XDG_DOCUMENTS_DIR:-${HOME}/Documents}/Code"

	if [[ -d "${gitroot}" ]]; then
		hash -d git-root="${gitroot}"

		for d in "$gitroot"/{Local,Remote}/*(FN); do
			if [[ -d "${d}/.git" ]]; then
				hash -d "git-${d:h:t:l}-${d:t}"="${d}"
			fi
		done
	fi
}

# Add all zsh plugins managed by zplug
() {
	local d

	for d in "${ZPLUG_HOME}/repos/"*/*(FN); do
		if [[ -d "${d}/.git" ]]; then
			hash -d "git-zplug-${d:h:t}-${d:t}"="${d}"
		fi
	done
}

# Add all neovim plugins managed by vim-plug
() {
	local d

	for d in "${XDG_DATA_HOME:-${HOME}/.local/share}/nvim/plugged"/*(FN); do
		if [[ -d "${d}/.git" ]]; then
			hash -d "git-neovim-${${d:t}#vim-}"="${d}"
		fi
	done
}
