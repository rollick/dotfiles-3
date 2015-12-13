zstyle ':completion:*' verbose true

# Allow completion for '..'
zstyle ':completion:*' special-dirs '..'

# Setup completion menu
zstyle ':completion:*' menu select=1
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format "%{$bg[yellow]%}%{$fg[black]%}%d%{$reset_color%}"
zstyle ':completion:*:default' select-prompt "%{$bg[yellow]%}%{$fg[black]%}Match %M%P%{$reset_color%}"

# Hide some files in completion, except when using (rm|cp|mv|zmv)
zstyle ':completion:*:(all-|)files' ignored-patterns "(*.BAK|*.bak|*.o|*.aux|*.toc|*.swp|*~)"
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
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:kill:*' command 'ps -u ${USER} -o pid,cmd'
zstyle ':completion:*:kill:*' insert-ids single

zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*:ssh:*' tag-order users hosts

# List repo packages before aur packages in pacaur
zstyle ':completion:*:pacaur:*' group-order repo_packages packages

# Provide more processes in completion of programs like killall:
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

# ignore completion functions for commands you don't have
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# Completion for man-pages
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:man:*' menu yes select
zstyle ':completion:*:manuals*' insert-sections true

# Completions for lp
zstyle ':completion:*:*:lp*:*' tag-order jobs

# Only list non daemon users
zstyle ':completion:*:*:*:users' ignored-patterns \
	$(awk -F: '{if ($3 > 0 && $3 < 1000) print $1}' /etc/passwd)

# Use the generic gnu-style help (command --help) for the following commands
() {
	until [[ -z "${1}" ]]; do
		if ! which "_${1}" &>|/dev/null; then
			compdef _gnu_generic "${1}"
		else
			print "${1} already has a completion."
		fi
		shift
	done
}  abs \
	dircolors \
	eyeD3 \
	flake8 \
	gpasswd \
	head \
	htop \
	makechrootpkg \
	makepkg \
	makearchroot \
	mocp \
	mv \
	namcap \
	pacman-key \
	pkgclean \
	powertop \
	rmdir \
	tail \
	udisks \

# Enable completion for some wrappers
compdef _diff colordiff
compdef _ping ping6