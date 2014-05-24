#!/bin/zsh
# Loaded for interactive shells only

# Load zsh (upstream) functions
autoload -U compinit && compinit
autoload -U colors && colors
autoload -U keeper && keeper
autoload -U promptinit
autoload -U url-quote-magic
autoload -U zmv

# Load zsh modules
zmodload -F zsh/complist

# Include external additions
ext_additions=("/usr/share/doc/pkgfile/command-not-found.zsh"
               "/etc/zsh_command_not_found"
               "/usr/share/zsh/site-functions/git-flow-completion.zsh"
               "/usr/bin/virtualenvwrapper.sh")
for f in ${ext_additions}; do
	[[ -e "${f}" ]] && source ${f}
done

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
which dircolors_setup &>/dev/null && dircolors_setup

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
if promptinit; then
	prompt default
fi

# Unset temporary variables
unset {a-z}
unset {A-Z}
unset ext_additions
unset setting_files
