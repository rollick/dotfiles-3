#!/bin/zsh
# Loaded for interactive shells only

# Load zsh (upstream) functions
autoload -U add-zsh-hook
autoload -U compinit && compinit
autoload -U colors && colors
autoload -U keeper && keeper
autoload -U promptinit && promptinit
autoload -U url-quote-magic
autoload -U zmv

# Load zsh modules
zmodload -F zsh/complist

# Add prompts to fpath
if [[ -d ${HOME}/.zsh.d/prompt.d ]]; then
	fpath=(${HOME}/.zsh.d/prompt.d ${fpath})
fi

# Load own functions
if [[ -d "${HOME}/.zsh.d/functions.d" ]]; then
	fpath=("${HOME}/.zsh.d/functions.d" ${fpath})
	autoload -U ${fpath[1]}/*(.,@N:t)
fi

# Setup $LS_COLORS
if [[ ! -f "${XDG_CONFIG_HOME}/dircolors" ]]; then
	dircolors --print-database >| "${XDG_CONFIG_HOME}/dircolors"
fi
eval $(dircolors --sh "${XDG_CONFIG_HOME}/dircolors")

# Include other settings
for f in ${HOME}/.zsh.d/[0-9]*(.N); do
	source "${f}"
done

# Set aliases
for f in ${HOME}/.zsh.d/alias.d/*(.N); do
	if which "$(basename "${f}")" &>|/dev/null; then
		source "${f}"
	fi
done

# Set prompt
promptinit && prompt default

# Include external additions
ext_additions=("/usr/share/doc/pkgfile/command-not-found.zsh"
               "/etc/zsh_command_not_found"
               "/usr/share/zsh/site-functions/git-flow-completion.zsh"
               "/usr/bin/virtualenvwrapper.sh"
               "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh")
for f in ${ext_additions}; do
	[[ -e "${f}" ]] && source ${f}
done

# Unset temporary variables
unset {a-z}
unset {A-Z}
unset ext_additions
unset setting_files
