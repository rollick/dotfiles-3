#!/bin/zsh
# Loaded for interactive shells only

# Load zsh modules
zmodload -F zsh/complist

# Load zsh (upstream) functions
autoload -U add-zsh-hook
autoload -U compinit
autoload -U colors
autoload -U keeper
autoload -U promptinit
autoload -U url-quote-magic
autoload -U zmv

# Include external additions
source "/usr/share/doc/pkgfile/command-not-found.zsh" &>|/dev/null
source "/etc/zsh_command_not_found" &>|/dev/null
source "/usr/share/zsh/site-functions/git-flow-completion.zsh" &>|/dev/null
source "/usr/bin/virtualenvwrapper.sh" &>|/dev/null
source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" &>|/dev/null

# Load own functions
fpath=("${ZDOTDIR}/.zsh.d/functions.d" "${ZDOTDIR}/.zsh.d/prompt.d" ${fpath})
autoload -U ${fpath[1]}/*(.,@N:t)
autoload -U ${fpath[2]}/*(.,@N:t)

# Initialize functions
compinit
colors
keeper
promptinit

# Setup $LS_COLORS
if [[ ! -f "${XDG_CONFIG_HOME}/dircolors" ]]; then
	dircolors --print-database >| "${XDG_CONFIG_HOME}/dircolors"
fi
eval $(dircolors --sh "${XDG_CONFIG_HOME}/dircolors")

source "${ZDOTDIR}/.zsh/00-options" &>|/dev/null
source "${ZDOTDIR}/.zsh/10-completions" &>|/dev/null
source "${ZDOTDIR}/.zsh/10-hashes" &>|/dev/null
source "${ZDOTDIR}/.zsh/10-keybindings" &>|/dev/null
source "${ZDOTDIR}/.zsh/11-hooks" &>|/dev/null
source "${ZDOTDIR}/.zsh/99-global-aliases" &>|/dev/null

# Set aliases
for f in ${ZDOTDIR}/.zsh.d/alias.d/*(.N); do
	if which "$(basename "${f}")" &>|/dev/null; then
		source "${f}"
	fi
done

# Set prompt
prompt default

# Unset temporary variables
unset {a-z}
unset {A-Z}
