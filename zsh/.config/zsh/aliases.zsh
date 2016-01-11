# Allow sudo to use aliases
(( ${+commands[sudo]} )) && alias sudo='sudo '

# Drop-in replacements
(( ${+functions[cd-git]} )) && alias cd="cd-git"
(( ${+commands[colordiff]} )) && alias diff="colordiff"
(( ${+commands[cmus]} )) && (( ${+commands[cmus_wrapper]} )) && alias cmus="cmus_wrapper"
(( ${+commands[pacaur]} )) && alias pacman="pacaur"
if (( ${+commands[vim]} )); then
	alias vi="vim"; unalias vim
elif (( ${+commands[nvim]} )); then
	alias vi="nvim"
	alias vim="nvim"
	alias vimdiff="nvim -d"
fi

# Force a specific nice level
(( ${+commands[gcc]} )) && alias gcc="nice -n 19 ${aliases[gcc]:-gcc}"
(( ${+commands[make]} )) && alias make="nice -n 19 ${aliases[make]:-make}"
(( ${+commands[makepkg]} )) && alias makepkg="nice -n 19 ${aliases[makepkg]:-makepkg}"

# Secure some commands
alias chgrp="${aliases[chgrp]:-chgrp} --preserve-root"
alias chmod="${aliases[chmod]:-chmod} --preserve-root"
alias chown="${aliases[chown]:-chown} --preserve-root"
alias cp="${aliases[cp]:-cp} --interactive"
alias ln="${aliases[ln]:-ln} --interactive"
alias mv="${aliases[mv]:-mv} --interactive"
alias rm="${aliases[rm]:-rm} --one-file-system --preserve-root"

# Use in non-GUI mode
(( ${+commands[octave]} )) && alias octave="${aliases[octave]:-octave} --no-gui"
(( ${+commands[unison]} )) && alias unison="${aliases[unison]:-unison} -ui text"

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
(( ${+commands[paccache]} )) && alias paccache='paccache --verbose'
alias rm="${aliases[rm]:-rm} --verbose"
(( ${+commands[rsync]} )) && alias rsync='rsync --verbose'
alias umount="${aliases[umount]:-umount} --verbose"
(( ${+commands[zcp]} )) && alias zcp='zcp -o --verbose'
(( ${+commands[zln]} )) && alias zln='zln -o --verbose'
(( ${+commands[zmv]} )) && alias zmv='zmv -o --verbose'

# Make output human readable
alias df="${aliases[df]:-df} --human-readable"
alias dmesg="${aliases[dmesg]:-dmesg} --decode --human"
alias du="${aliases[du]:-du} --human-readable"
alias free="${aliases[free]:-free} --mega --human"
alias ls="${aliases[ls]:-ls} --human-readable"
(( ${+commands[rsync]} )) && alias rsync='rsync --human-readable'

# Enable color output
alias grep="${aliases[grep]:-grep} --color=auto"
alias ls="${aliases[ls]:-ls} --color=auto"

# Overide default time format
alias dmesg="${aliases[dmesg]:-dmesg} --time-format ctime"
alias ls="${aliases[ls]:-ls} --time-style=long-iso"

# Set options
alias free="${aliases[free]:-free} --total"
alias head="${aliases[head]:-head} -n \$(( \${LINES} - 2 * \$(print \${PROMPT} |wc -l) ))"
alias info="${aliases[info]:-info} --vi-keys"
alias ls="${aliases[ls]:-ls} --classify --escape --group-directories-first"
alias mkdir="${aliases[mkdir]:-mkdir} --parents"
(( ${+commands[octave]} )) && alias octave="${aliases[octave]:-octave} --silent"
(( ${+commands[pgrep]} )) && alias pgrep="${aliases[pgrep]:-pgrep} --list-name"
(( ${+commands[ping]} )) && alias ping="${aliases[ping]:-ping} -c4"
(( ${+commands[ping6]} )) && alias ping6="${aliases[ping6]:-ping6} -c4"
(( ${+commands[rsync]} )) && alias rsync="${aliases[rsync]:-rsync} --compress"
alias tail="${aliases[tail]:-tail} -n \$(( \${LINES} - 2 * \$(print \${PROMPT} |wc -l) ))"

# Define new commands
(( ${+commands[octave]} )) && alias calc="noglob ${aliases[octave]:-octave} --eval"
alias la="${aliases[ls]:-ls} --almost-all"
alias ll="${aliases[ls]:-ls} --format=long"
alias lla="${aliases[ls]:-ls} --almost-all --format=long"
(( ${+commands[htop]} )) && alias uhtop="${aliases[htop]:-htop} -u \${USER}"
if (( ${+commands[httpserver]} )); then
	alias httpserver_public="${aliases[httpserver]:-httpserver} ${XDG_PUBLICSHARE_DIR:-${HOME}/Public}"
fi
(( ${+commands[top]} )) && alias utop="${aliases[top]:-top} -u \${USER}"

# Global aliases
alias -g C='|wc -l'
alias -g ES='2>&1'
alias -g F='&|'
alias -g G='|grep'
alias -g GI='|grep -i'
alias -g GV='|grep -v'
alias -g H='|head'
alias -g NE='2>|/dev/null'
alias -g NO='&>|/dev/null'
alias -g NOF='&>|/dev/null &|'
alias -g P='|${PAGER:-less}'
alias -g S='|sort'
alias -g U='|uniq'
alias -g T='|tail'
