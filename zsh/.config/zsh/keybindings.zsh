autoload -Uz url-quote-magic

# Enable ZLE widgets
####################
zle -N expand-global-alias zle-expand-global-alias
zle -N get-help zle-get-help
zle -N get-man zle-get-man
zle -N hide-from-history zle-hide-from-history
zle -N insert-iso-date zle-insert-iso-date
zle -N self-insert url-quote-magic
zle -N toggle-alias zle-toggle-alias
zle -N toggle-sudo zle-toggle-sudo

# Keybindings
####################
# Set emacs mode
bindkey -e

# Set keybindings
() {
	local key

	# To add keys to $key, see man 5 terminfo
	typeset -A key
	key[Delete]=${terminfo[kdch1]}
	key[Down]=${terminfo[kcud1]}
	key[End]=${terminfo[kend]}
	key[Home]=${terminfo[khome]}
	key[Insert]=${terminfo[kich1]}
	key[Left]=${terminfo[kcub1]}
	key[PageDown]=${terminfo[knp]}
	key[PageUp]=${terminfo[kpp]}
	key[Right]=${terminfo[kcuf1]}
	key[ShiftLeft]=${terminfo[kLFT]}
	key[ShiftRight]=${terminfo[kRIT]}
	key[Up]=${terminfo[kcuu1]}

	[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
	[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" history-beginning-search-forward
	[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
	[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
	[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
	[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" history-beginning-search-forward
	[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" history-beginning-search-backward
	[[ -n ${key[ShiftLeft]} ]] && bindkey "${key[ShiftLeft]}" backward-word
	[[ -n ${key[ShiftRight]} ]] && bindkey "${key[ShiftRight]}" forward-word
	[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" history-beginning-search-backward
}

bindkey ' '                     expand-global-alias
bindkey '^ '                    magic-space
bindkey '^B'                    backward-kill-word
bindkey '^W'                    kill-word
bindkey '^X '                   hide-from-history
bindkey '^Xd'                   insert-iso-date
bindkey '^Xe'                   expand-word
bindkey '^Xk'                   insert-kept-result
bindkey '^Xs'                   toggle-sudo
bindkey -M menuselect 'i'       accept-and-menu-complete

# Make sure the terminal is in application mode, when zle is active.
# Only then are the values from $terminfo valid.
if [[ -n ${terminfo[smkx]} && ${terminfo[rmkx]} ]]; then
	function zle-line-init() {
		echoti smkx
	}

	function zle-line-finish() {
		echoti rmkx
	}

	zle -N zle-line-init
	zle -N zle-line-finish
fi
