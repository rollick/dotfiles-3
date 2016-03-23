LIB="${XDG_DATA_HOME:-${HOME}/.local/share}/../lib/"
export ADOTDIR="${XDG_DATA_HOME:-${HOME}/.local/share}/antigen"

if [[ ! -d "${LIB}/antigen" ]]; then
	mkdir -p "${LIB}/antigen"

	git clone https://github.com/zsh-users/antigen.git "${LIB}/antigen"
fi

if [[ -f "${LIB}/antigen/antigen.zsh" ]]; then
	source "${LIB}/antigen/antigen.zsh"

	[[ -n ${commands[git-flow]} ]] && antigen bundle petervanderdoes/git-flow-completion
	antigen bundle hlissner/zsh-autopair
	antigen bundle zsh-users/zsh-completions src
	antigen bundle zsh-users/zsh-syntax-highlighting

	antigen apply

	=rm "${ZDOTDIR}/.zcompdump"
	compinit -d "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompdump"
fi

unset LIB

# Include external additions provided by packages
source "/usr/share/doc/pkgfile/command-not-found.zsh" &>|/dev/null
source "/etc/zsh_command_not_found" &>|/dev/null
source "/usr/bin/virtualenvwrapper.sh" &>|/dev/null
