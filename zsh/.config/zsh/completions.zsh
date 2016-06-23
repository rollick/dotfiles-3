zmodload -F zsh/complist
autoload -Uz compinit && compinit -d "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompdump"
autoload -Uz colors && colors

zstyle ':completion:*' verbose true

# Allow completion for '..'
zstyle ':completion:*' special-dirs '..'

# Setup completion menu
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=1
zstyle ':completion:*:corrections' format "%{$fg_bold[green]%}%U%d (errors: %e)%u%{$reset_color%}"
zstyle ':completion:*:default' select-prompt "%{$fg_bold[black]%}Match %M%P%{$reset_color%}"
zstyle ':completion:*:descriptions' format "%{$fg_bold[green]%}%U%d%u%{$reset_color%}"
zstyle ':completion:*:messages' format "%{$fg_bold[yellow]%}%U%d%u%{$reset_color%}"
zstyle ':completion:*:warnings' format "%{$fg_bold[red]%}No matches for: %d%{$reset_color%}"

# Hide some files in completion, except when using (rm|cp|mv|zmv)
zstyle ':completion:*:(all-|)files' ignored-patterns '(*.BAK|*.bak|*.o|*.aux|*.toc|*.swp|*~)'
zstyle ':completion:*:(rm|mv|cp|zmv):*:(all-|)files' ignored-patterns

# Use $LS_COLORS for file listings
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Automaticly rehash
zstyle ':completion::complete:*' rehash true

# Ignore what's already in the line
zstyle ':completion:*:(kill|pacman|rm):*' ignore-line yes
zstyle ':completion:*:colordiff:*' ignore-line yes
zstyle ':completion:*:diff:*' ignore-line yes

# Completion for kill
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u ${USER} -o pid,cmd'
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:kill:*' insert-ids single

zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*:ssh:*' tag-order users hosts
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

# List repo packages before aur packages in pacaur
zstyle ':completion:*:pacaur:*' group-order repo_packages packages

# Provide more processes in completion of programs like killall:
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

# ignore completion functions for commands you don't have
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# Completion for man-pages
zstyle ':completion:*:man:*' menu yes select
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals*' insert-sections true

# Completions for lp
zstyle ':completion:*:*:lp*:*' tag-order jobs

# Only list non daemon users
zstyle ':completion:*:*:*:users' ignored-patterns \
	$(awk -F: '{if ($3 > 0 && $3 < 1000) print $1}' /etc/passwd)

# Use the generic gnu-style help (command --help) for the following commands
() {
	local cmd
	local commands=(
		abs
		dircolors
		eyed3
		flake8
		gpasswd
		htop
		makearchroot
		mocp
		mv
		namcap
		pkgclean
		pkgstats
		powertop
		stow
		udisks
	)

	for cmd in $commands; do
		if [[ -z ${_comps[$cmd]} ]]; then
			compdef _gnu_generic $cmd
		else
			print "Completion for \"${cmd}\" is already installed."
		fi
	done
}

# Enable completion for some wrappers
compdef _cd cd-git
compdef _diff colordiff
compdef _ping ping6
