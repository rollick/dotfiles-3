# Loaded for interactive shells only

# Sanitize su environment
[[ ${UID} -eq 0 && ! -o "login" ]] && source "/root/.sanitize_su.zsh"

# Create needed directories
mkdir -p "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh"

# Load zsh modules
zmodload -F zsh/complist

# Load zsh (upstream) functions
autoload -Uz add-zsh-hook
autoload -Uz compinit
autoload -Uz colors
autoload -Uz promptinit
autoload -Uz url-quote-magic
autoload -Uz zmv

# Load own functions
fpath=("${ZDOTDIR}/functions" ${fpath})
typeset -U path
autoload -Uz ${fpath[1]}/*(.,@N:t)

# Initialize functions
compinit -d "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompdump"
colors
promptinit

# Set zsh options
source "${ZDOTDIR}/options.zsh" &>|/dev/null

# Set misc. settings
source "${ZDOTDIR}/aliases.zsh" &>|/dev/null
source "${ZDOTDIR}/completions.zsh" &>|/dev/null
source "${ZDOTDIR}/hashes.zsh" &>|/dev/null
source "${ZDOTDIR}/keybindings.zsh" &>|/dev/null

# Set prompt
prompt simple

# Set history options
export HISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/history"
export SAVEHIST=10000
export HISTSIZE=12000

# Set up syntax highlighting
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# Include external additions
source "/usr/share/doc/pkgfile/command-not-found.zsh" &>|/dev/null
source "/etc/zsh_command_not_found" &>|/dev/null
source "/usr/share/zsh/site-functions/git-flow-completion.zsh" &>|/dev/null
source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" &>|/dev/null

# Fix for prompts, which show a $? status
true
