autoload -Uz add-zsh-hook

function zplug_install_cleanup() {
	if [[ -d "${ZPLUG_INSTALL_TMPDIR}" ]]; then
		rm -rf "/${ZPLUG_INSTALL_TMPDIR}"
	fi
}


export ZPLUG_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zplug"

if [[ ! -d "${ZPLUG_HOME}" ]]; then
	if [[ -d "${XDG_RUNTIME_DIR}" ]]; then
		tmpdir="${XDG_RUNTIME_DIR}"
	elif [[ -d "/run/user/${EUID}" ]]; then
		tmpdir="/run/user/${EUID}"
	else
		tmpdir="/tmp"
	fi

	export ZPLUG_INSTALL_TMPDIR="$(mktemp --directory --tmpdir=${tmpdir} zplug.XXXXXXXXXX)"
	unset tmpdir

	git clone --depth 1 "http://github.com/b4b4r07/zplug.git" "${ZPLUG_INSTALL_TMPDIR}"

	if [[ -f "${ZPLUG_INSTALL_TMPDIR}/zplug" ]]; then
		mkdir -p "${ZPLUG_HOME}"
		source "${ZPLUG_INSTALL_TMPDIR}/zplug"

		zplug update --self
	fi

	add-zsh-hook zshexit zplug_install_cleanup
fi

if [[ -d "${ZPLUG_HOME}" ]]; then
	source "${ZPLUG_HOME}/init.zsh"

	zplug "b4b4r07/zplug" # Let zplug handle itself correctly

	zplug "hlissner/zsh-autopair"
	zplug "zsh-users/zsh-completions"
	zplug "petervanderdoes/git-flow-completion"
	zplug "zsh-users/zsh-syntax-highlighting", nice:18
	zplug "knu/zsh-manydots-magic", use:manydots-magic, nice:19

	if ! zplug check; then
		zplug install
	fi

	zplug load


	# Run plugin specific code
	if zplug check knu/zsh-manydots-magic; then
		manydots-magic
	fi

	if zplug check zsh-users/zsh-syntax-highlighting; then
		export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
	fi
fi

# Include external additions provided by packages
source "/usr/share/doc/pkgfile/command-not-found.zsh" &>|/dev/null
source "/etc/zsh_command_not_found" &>|/dev/null
source "/usr/bin/virtualenvwrapper_lazy.sh" &>|/dev/null
