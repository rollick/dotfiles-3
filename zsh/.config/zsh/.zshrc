# Loaded for interactive shells only

# Sanitize su environment
[[ ${EUID} -eq 0 && ! -o 'login' ]] && source '/root/.config/zsh/sanitize_su.zsh'

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

# Make sure all fpath and path entries are unique
typeset -U fpath
typeset -U path

# Initialize functions
promptinit

# Set zsh options
source "${ZDOTDIR}/options.zsh"

# Set misc. settings
source "${ZDOTDIR}/completions.zsh"
source "${ZDOTDIR}/keybindings.zsh"
source "${ZDOTDIR}/hooks.zsh"
source "${ZDOTDIR}/aliases.zsh"
[[ ${EUID} -ne 0 ]] && source "${ZDOTDIR}/external_plugins.zsh"

# Set prompt
if [[ -n ${functions[prompt_simple_setup]} ]]; then
	prompt simple
fi
