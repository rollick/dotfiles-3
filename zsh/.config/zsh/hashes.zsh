# Add some directories to the hashtable
[[ -d '/var/log' ]] && hash -d log='/var/log'
[[ -d '/var/log/old' ]] && hash -d alog='/var/log/old'
[[ -d "/var/spool/cups-pdf/${USER}" ]] && hash -d cups-pdf="/var/spool/cups-pdf/${USER}"
[[ -d "/var/cache/pacman/pkg" ]] && hash -d paccache="/var/cache/pacman/pkg"
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

	if [[ -d "$gitroot" ]]; then
		hash -d git-root=$gitroot

		for d in "$gitroot"/{Local,Remote}/*(FN); do
			if [[ -d "${d}/.git" ]]; then
				hash -d "git-${d:h:t:l}-${d:t}"="${d}"
			fi
		done
	fi
}
