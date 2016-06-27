# Add some directories to the hashtable
[[ -d "${WORKON_HOME}" ]] && hash -d virtualenvs="${WORKON_HOME}"
[[ -d "/run/media/${USER}" ]] && hash -d media="/run/media/${USER}"
[[ -d "/var/spool/cups-pdf/${USER}" ]] && hash -d cups-pdf="/var/spool/cups-pdf/${USER}"
[[ -d '/var/cache/pacman/pkg' ]] && hash -d paccache='/var/cache/pacman/pkg'
[[ -d '/var/log' ]] && hash -d log='/var/log'
[[ -d '/var/log/old' ]] && hash -d alog='/var/log/old'

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

# Hash git repositories
() {
	local _XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
	local _XDG_DOCUMENTS_DIR="${XDG_DOCUMENTS_DIR:-${HOME}/Documents}"
	local name
	local subdir

	hash_git_repos() {
		local BASENAME="${1}"
		local ROOT="${2}"
		local name
		local subdir

		for subdir in "${ROOT}"/*(FN); do
			if [[ -d "${subdir}/.git" ]]; then
				name="${subdir:t}"
				hash -d "git-${BASENAME}-${name}"="${subdir}"
			fi
		done
	}

	# Normalize paths
	_XDG_DATA_HOME="$(readlink -m ${_XDG_DATA_HOME})"
	_XDG_DOCUMENTS_DIR="$(readlink -m ${_XDG_DOCUMENTS_DIR})"

	# Hash "regular" git repositories
	if [[ -d "${_XDG_DOCUMENTS_DIR}/Code" ]]; then
		hash -d git-root="${_XDG_DOCUMENTS_DIR}/Code"
		hash_git_repos "local" "${_XDG_DOCUMENTS_DIR}/Code/Local"
		hash_git_repos "remote" "${_XDG_DOCUMENTS_DIR}/Code/Remote"
	fi

	# Hash neovim plugins
	hash_git_repos "neovim" "${_XDG_DATA_HOME}/nvim/plugged"

	# Hash zsh plugins
	for subdir in "${ZPLUG_HOME}"/repos/*(FN); do
		name="${subdir:t}"
		hash_git_repos "${name}" "${subdir}"
	done
}
