#!/bin/zsh
# Loaded for interactive shells only

# Create needed directories
mkdir -p "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh"

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
fpath=("${ZDOTDIR}/functions" "${ZDOTDIR}/prompts" ${fpath})
autoload -U ${fpath[1]}/*(.,@N:t)
autoload -U ${fpath[2]}/*(.,@N:t)

# Initialize functions
compinit -d "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompdump"
colors
keeper
promptinit

# Set zsh options
source "${ZDOTDIR}/options" &>|/dev/null

# Set misc. settings
source "${ZDOTDIR}/aliases" &>|/dev/null
source "${ZDOTDIR}/completions" &>|/dev/null
source "${ZDOTDIR}/hashes" &>|/dev/null
source "${ZDOTDIR}/hooks" &>|/dev/null
source "${ZDOTDIR}/keybindings" &>|/dev/null

# Set prompt
prompt default

# Set history options
export HISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/history"
export SAVEHIST=10000
export HISTSIZE=12000

# Set up syntax highlighting
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# Unset temporary variables
unset {a-z}
unset {A-Z}
