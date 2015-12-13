alias chgrp='chgrp --change'
alias chmod='chmod --change'
alias chown='chown --change'
alias cls='clear'
if which which cmus &>|/dev/null; then
	alias cmus='cmus_wrapper'
fi
which colordiff &>|/dev/null && alias diff='colordiff'
alias cp='cp --interactive --verbose'
alias df='df --human-readable'
alias dmesg='dmesg --color --decode --human --time-format ctime'
alias du='du --human-readable'
alias free='free --mega --total --human'
alias gcc="nice -n 19 gcc"
alias grep='grep --color=auto'
alias head='head -n $(( ${LINES} - 2 * $(print ${PROMPT} |wc -l) ))'
which htop &>|/dev/null && alias uhtop='htop -u ${USER}'
if which httpserver &>|/dev/null; then
	alias httpserver_public="httpserver ${XDG_PUBLICSHARE_DIR:-${HOME}/Public}"
fi
if which i3pystatus-custom &>|/dev/null; then
	alias i3pystatus='venv i3pystatus i3pystatus-custom'
else
	alias i3pystatus='venv i3pystatus i3pystatus'
fi
alias info='info --vi-keys'
alias ln='ln --verbose'
alias ls='ls --human-readable --classify --color=auto --escape --group-directories-first'
alias la='ls --almost-all'
alias ll='ls --format=long --time-style=long-iso'
alias lla='ll --almost-all'
alias lsblk="lsblk --output=NAME,RM,SIZE,RO,TYPE,FSTYPE,MOUNTPOINT,LABEL"
alias make="nice -n 19 make"
alias mkdir='mkdir --verbose --parents'
alias modprobe='modprobe --verbose'
alias mount='mount --verbose'
alias mv='mv --interactive --verbose'
if which octave &>|/dev/null; then
	alias octave='octave --silent --no-gui'
	alias calc='noglob octave --silent --eval'
fi
if which pacman &>|/dev/null; then
	alias makepkg='PYTHONDONTWRITEBYTECODE="" nice -n 19 makepkg'
	alias paccache="paccache --verbose"
	if which which pacaur &>|/dev/null; then
		alias pacman='pacaur'
	fi
fi
alias pgrep='pgrep -l'
alias ping='ping -c4'
alias ping6='ping6 -c4'
alias rm='rm --verbose --one-file-system'
which rsync &>|/dev/null && alias rsync='rsync --verbose --compress --human-readable'
which sudo &>|/dev/null && alias sudo='sudo '
alias tail='tail -n $(( ${LINES} - 2 * $(print ${PROMPT} |wc -l) ))'
which top &>|/dev/null && alias utop='top -U ${USER}'
which tree &>|/dev/null && alias tree="tree --dirsfirst -A"
alias umount='umount --verbose'
which unison &>|/dev/null && alias unison='unison -ui text'
if which nvim &>/dev/null; then
	alias vi='nvim -p'
	alias vim='nvim -p'
elif which vim &>|/dev/null; then
	alias vim="vim -p"
	alias vi='vim'
fi
alias zcp='zcp -o --verbose'
alias zln='zln -o --verbose'
alias zmv='zmv -o --verbose'
alias zmv-all_low="zmv '(*)' '\${1:l}'"
alias zmv-space2underscore="zmv '(*)' '\${1// /_}'"

# Global aliases
alias -g C="|wc -l"
alias -g ES="2>&1"
alias -g F="&|"
alias -g G="|grep"
alias -g GE="|grep -E"
alias -g GI="|grep -i"
alias -g GV="|grep -v"
alias -g H="|head"
alias -g K="|keep --"
alias -g NE="2>|/dev/null"
alias -g NO="&>|/dev/null"
alias -g NOF="&>|/dev/null &|"
alias -g P='|${PAGER}'
alias -g S="|sort"
alias -g SU="|sort -u"
alias -g U="|uniq"
alias -g T="|tail"
alias -g X="|xargs"
alias -g X0="|xargs -0"