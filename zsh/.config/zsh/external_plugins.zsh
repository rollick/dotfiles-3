#!/bin/zsh
# Include external additions provided by packages, but only
# if the current user is not root.

if [[ ${EUID} -ne 0 ]]; then
	() {
		local GIT_ROOT="${XDG_DOCUMENTS_DIR:-${HOME}/Documents}/Code/Remote"

		source "${GIT_ROOT}/zsh-autopair/autopair.zsh"
		source "${GIT_ROOT}/git-flow-completion/git-flow-completion.plugin.zsh"
		source "${GIT_ROOT}/zsh-completions/zsh-completions.plugin.zsh"
		source "${GIT_ROOT}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

		source "/usr/bin/virtualenvwrapper_lazy.sh"
		source "/etc/zsh_command_not_found"
		source "/usr/share/doc/pkgfile/command-not-found.zsh"
	} &>|/dev/null

	# Plugin specific settings
	export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
fi
