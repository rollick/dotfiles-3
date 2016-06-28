export ZPLUG_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zplug"

# Bootstrap zplug
() {
	autoload -Uz add-zsh-hook

	local tmpdir

	function zplug_install_cleanup() {
		if [[ -d "${ZPLUG_INSTALL_TMPDIR}" ]]; then
			rm -rf "/${ZPLUG_INSTALL_TMPDIR}"
		fi
	}

	if [[ ! -d "${ZPLUG_HOME}" ]]; then
		tmpdir="${XDG_RUNTIME_DIR:-/run/user/${EUID}}"

		if [[ ! -d "${tmpdir}" ]]; then
			tmpdir='/tmp'
		fi

		export ZPLUG_INSTALL_TMPDIR="$(mktemp --directory --tmpdir=${tmpdir} zplug.XXXXXXXXXX)"

		git clone --depth 1 'http://github.com/zplug/zplug.git' "${ZPLUG_INSTALL_TMPDIR}"

		if [[ -f "${ZPLUG_INSTALL_TMPDIR}/zplug" ]]; then
			mkdir -p "${ZPLUG_HOME}"
			source "${ZPLUG_INSTALL_TMPDIR}/zplug"

			zplug update --self
		fi

		add-zsh-hook zshexit zplug_install_cleanup
	else
		unfunction zplug_install_cleanup
	fi
}

if [[ -d "${ZPLUG_HOME}" ]]; then
	source "${ZPLUG_HOME}/init.zsh"

	zplug "hlissner/zsh-autopair", nice:10
	zplug "petervanderdoes/git-flow-completion"
	zplug "zplug/zplug" # Let zplug handle itself correctly
	zplug "zsh-users/zsh-completions"
	zplug "zsh-users/zsh-syntax-highlighting", nice:10

	if ! zplug check; then
		zplug install
	fi

	zplug load

	# Run plugin specific code
	if zplug check zsh-users/zsh-syntax-highlighting; then
		export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
	fi
fi

# Include external additions provided by packages
source "/etc/zsh_command_not_found" &>|/dev/null
source "/usr/bin/virtualenvwrapper_lazy.sh" &>|/dev/null
source "/usr/share/doc/pkgfile/command-not-found.zsh" &>|/dev/null
