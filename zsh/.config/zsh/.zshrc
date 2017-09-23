#!/bin/zsh
# Loaded for interactive shells only

# Create needed directories
mkdir -p "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh"

# Load zsh (upstream) functions
autoload -Uz keeper && keeper
autoload -Uz promptinit
autoload -Uz zmv

# Load own functions
if [[ -d "${ZDOTDIR}/functions" ]]; then
	fpath=("${ZDOTDIR}/functions" ${fpath})
	autoload -Uz ${fpath[1]}/*(.,@N:t)
fi

# Make sure all fpath entries are unique
typeset -U fpath

# Set zsh options
source "${ZDOTDIR}/options.zsh"

# Set misc. settings
source "${ZDOTDIR}/completions.zsh"
source "${ZDOTDIR}/keybindings.zsh"
source "${ZDOTDIR}/hooks.zsh"
source "${ZDOTDIR}/aliases.zsh"
source "${ZDOTDIR}/external_plugins.zsh"

# Set prompt
promptinit

if [[ -n ${functions[prompt_simple_setup]} ]]; then
	prompt simple
else
	prompt adam2
fi
