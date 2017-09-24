#!/bin/zsh
# Allow sudo to use aliases
[[ -n ${commands[sudo]} ]] && alias sudo='sudo '

# Drop-in replacements
[[ -n ${functions[cd-git]} ]] && alias cd='cd-git'
[[ -n ${commands[colordiff]} ]] && alias diff='colordiff'
if [[ -n ${commands[vim]} ]]; then
	alias vi='vim'
	[[ -n ${aliases[vim]} ]] && unalias vim
fi
if [[ -n ${commands[nvim]} ]]; then
	alias vi='nvim'
	alias vim='nvim'
	alias vimdiff='nvim -d'
fi

# Use in non-GUI mode
[[ -n ${commands[unison]} ]] && alias unison="${aliases[unison]:-unison} -ui text"

# Force a specific nice level
[[ -n ${commands[gcc]} ]] && alias gcc="nice -n 19 ${aliases[gcc]:-gcc}"
[[ -n ${commands[make]} ]] && alias make="nice -n 19 ${aliases[make]:-make}"
[[ -n ${commands[makepkg]} ]] && alias makepkg="nice -n 19 ${aliases[makepkg]:-makepkg}"

# Secure some commands
alias chgrp="${aliases[chgrp]:-chgrp} --preserve-root"
alias chmod="${aliases[chmod]:-chmod} --preserve-root"
alias chown="${aliases[chown]:-chown} --preserve-root"
alias cp="${aliases[cp]:-cp} --interactive"
alias ln="${aliases[ln]:-ln} --interactive"
alias mv="${aliases[mv]:-mv} --interactive"
alias rm="${aliases[rm]:-rm} --one-file-system --preserve-root"

# Make some commands more verbose
alias chgrp="${aliases[chgrp]:-chgrp} --changes"
alias chmod="${aliases[chmod]:-chmod} --changes"
alias chown="${aliases[chown]:-chown} --changes"
alias cp="${aliases[cp]:-cp} --verbose"
alias dd="${aliases[dd]:-dd} status=progress"
alias ln="${aliases[ln]:-ln} --verbose"
alias mkdir="${aliases[mkdir]:-mkdir} --verbose"
alias modprobe="${aliases[modprobe]:-modprobe} --verbose"
alias mount="${aliases[mount]:-mount} --verbose"
alias mv="${aliases[mv]:-mv} --verbose"
[[ -n ${commands[paccache]} ]] && alias paccache="${aliases[paccache]:-paccache} --verbose"
alias rm="${aliases[rm]:-rm} --verbose"
alias rmdir="${aliases[rmdir]:-rmdir} --verbose"
[[ -n ${commands[rsync]} ]] && alias rsync='rsync --verbose'
alias umount="${aliases[umount]:-umount} --verbose"
[[ -n ${functions[zmv]} ]] && alias zmv='zmv -o --verbose'

# Make output human readable
alias df="${aliases[df]:-df} --human-readable"
alias dmesg="${aliases[dmesg]:-dmesg} --decode --human"
alias du="${aliases[du]:-du} --human-readable"
alias free="${aliases[free]:-free} --mega --human"
alias ip="${aliases[ip]:-ip} -human-readable -iec"
alias ls="${aliases[ls]:-ls} --human-readable"
[[ -n ${commands[rsync]} ]] && alias rsync="${aliases[rsync]:-rsync} --human-readable"

# Enable color output
alias grep="${aliases[grep]:-grep} --color=auto"
alias ip="${aliases[ip]:-ip} -color"
alias ls="${aliases[ls]:-ls} --color=auto"

# Overide default time format
alias dmesg="${aliases[dmesg]:-dmesg} --time-format ctime"
alias ls="${aliases[ls]:-ls} --time-style=long-iso"

# Set options
alias diff="${aliases[diff]:-diff} --unified"
alias free="${aliases[free]:-free} --total"
[[ -n ${commands[head]} ]] && alias head="${aliases[head]:-head} -n "'$(( LINES - 2 * $(print ${PROMPT} |wc -l) ))'
alias info="${aliases[info]:-info} --vi-keys"
alias ls="${aliases[ls]:-ls} --classify --group-directories-first --literal"
alias mkdir="${aliases[mkdir]:-mkdir} --parents"
[[ -n ${commands[mpv]} ]] && alias mpv="${aliases[mpv]:-mpv} --fullscreen=no"
alias nvim="${aliases[nvim]:-nvim} -p"
[[ -n ${commands[pgrep]} ]] && alias pgrep="${aliases[pgrep]:-pgrep} --list-name"
[[ -n ${commands[ping]} ]] && alias ping="${aliases[ping]:-ping} -c4"
[[ -n ${commands[rsync]} ]] && alias rsync="${aliases[rsync]:-rsync} --compress"
[[ -n ${commands[sxiv]} ]] && alias sxiv="${aliases[sxiv]:-sxiv} -ar"
[[ -n ${commands[tail]} ]] && alias tail="${aliases[tail]:-tail} -n "'$(( LINES - 2 * $(print ${PROMPT} |wc -l) ))'
[[ -n ${commands[tig]} ]] && alias tig="${aliases[tig]:-tig} --show-signature"
[[ -n ${commands[tmux]} ]] && alias tmux="${aliases[tmux]:-tmux} -f \"${XDG_CONFIG_HOME:-${HOME}/.config}/tmux/tmux.conf\""
if [[ -n ${commands[udiskie]} ]]; then
	alias udiskie-mount="${aliases[udiskie-mount]:-udiskie-mount} --recursive"
	alias udiskie-umount="${aliases[udiskie-umount]:-udiskie-umount} --lock"
fi
alias vi="${aliases[vi]:-vi} -p"
alias vim="${aliases[vim]:-vim} -p"

# Define new commands
alias la="${aliases[ls]:-ls} --almost-all"
alias ll="${aliases[ls]:-ls} --format=long"
alias lla="${aliases[ls]:-ls} --almost-all --format=long"
[[ -n ${commands[htop]} ]] && alias uhtop="${aliases[htop]:-htop} -u ${USER}"
if [[ -n ${commands[ionice]} ]] && [[ -n ${commands[nice]} ]]; then
	alias reallynice='nice -n 19 ionice -c 3 '
fi
if [[ -n ${commands[python3]} ]]; then
	alias httpserver='python3 -m http.server'
	alias prettyjson='python3 -m json.tool'
elif [[ -n ${commands[python2]} ]]; then
	alias httpserver='python2 -m SimpleHTTPServer'
	alias prettyjson='python2 -m json.tool'
fi
[[ -n ${commands[top]} ]] && alias utop="${aliases[top]:-top} -u ${USER}"
if [[ -n ${functions[zmv]} ]]; then
	alias zcp="${aliases[zmv]:-zmv} -C"
	alias zln="${aliases[zmv]:-zln} -L"
fi

# Hide some commands from history
[[ -n ${commands[xprop]} ]] && alias xprop=" ${aliases[xprop]:-xprop}"

# Add prompt compatibility
[[ -n ${commands[clear]} ]] && alias clear="unset PROMPT_SHOWN; ${aliases[clear]:-clear}"
[[ -n ${commands[reset]} ]] && alias reset="unset PROMPT_SHOWN; ${aliases[reset]:-reset}"

# Global aliases
alias -g C='|wc -l'
alias -g ES='2>&1'
alias -g F='&|'
alias -g G='|grep'
alias -g GI='|grep -i'
alias -g GV='|grep -v'
alias -g H='|head'
alias -g K='|keep'
alias -g NE='2>|/dev/null'
alias -g NO='&>|/dev/null'
alias -g NOF='&>|/dev/null &|'
alias -g P='|${PAGER:-less}'
alias -g S='|sort'
alias -g SN='|sort --numeric-sort'
alias -g T='|tail'
alias -g U='|uniq'
