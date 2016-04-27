export ZPLUG_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zplug"

if [[ ! -d "${ZPLUG_HOME}" ]]; then
	tmpdir="$(mktemp --directory)"

	git clone --depth 1 "http://github.com/b4b4r07/zplug.git" "${tmpdir}"

	if [[ -f "${tmpdir}/zplug" ]]; then
		mkdir -p "${ZPLUG_HOME}"
		source "${tmpdir}/zplug"

		zplug update --self
	fi

	unset tmpdir
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
