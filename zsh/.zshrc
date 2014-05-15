#!/bin/zsh
# Loaded for interactive shells only

# Load options
[[ -e ${HOME}/.zsh.d/options ]] && source ${HOME}/.zsh.d/options

# Load zsh (upstream) functions
autoload -U zmv

# Include external additions
ext_additions=("/usr/share/doc/pkgfile/command-not-found.zsh"
				 "/etc/zsh_command_not_found"
				 "/usr/share/zsh/site-functions/git-flow-completion.zsh")
for f in ${ext_additions}; do
	[[ -e "${f}" ]] && source ${f}
done

# Load own functions
if [[ -d "${HOME}/.zsh.d/functions.d" ]]; then
	fpath=("${HOME}/.zsh.d/functions.d" ${fpath})
	autoload -U ${fpath[1]}/*(.,@N:t)
fi

# Setup $LS_COLORS
which dircolors_setup &>/dev/null && dircolors_setup

# Include other settings
setting_files=("completions"
               "hashes"
               "keybindings"
               "prompt"
               "zftp")
for f in ${setting_files}; do
	f="${HOME}/.zsh.d/${f}"
	[[ -e "${f}" ]] && source "${f}"
done

# Set aliases
for f in ${HOME}/.zsh.d/alias.d/*(.N); do
	source ${f}
done

# Unset temporary variables
unset {a-z}
unset {A-Z}
unset ext_additions
unset setting_files