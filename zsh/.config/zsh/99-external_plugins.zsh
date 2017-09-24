#!/bin/zsh
# Include external additions provided by packages, but only
# if the current user is not root.

if [[ ${EUID} -ne 0 ]]; then
	() {
		local GIT_ROOT="${XDG_DOCUMENTS_DIR:-${HOME}/Documents}/Code/Remote"
		local module
		local modules

		modules=(
			"${GIT_ROOT}/zsh-autopair/autopair.zsh"
			"${GIT_ROOT}/git-flow-completion/git-flow-completion.plugin.zsh"
			"${GIT_ROOT}/zsh-completions/zsh-completions.plugin.zsh"
			"${GIT_ROOT}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

			"/usr/bin/virtualenvwrapper_lazy.sh"
			"/etc/zsh_command_not_found"
			"/usr/share/doc/pkgfile/command-not-found.zsh"
		)

		for module in "${(@)modules}"; do
			source "${module}" &>|/dev/null
		done
	}

	# Plugin specific settings
	if [[ -n ${ZSH__HIGHLIGHT_VERSION} ]]; then
		export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
	fi
fi
