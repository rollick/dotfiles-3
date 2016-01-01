# Enable ZLE widgets
####################
zle -N expand-global-alias zle-expand-global-alias
zle -N get-help zle-get-help
zle -N get-man zle-get-man
zle -N hide-from-history zle-hide-from-history
zle -N self-insert url-quote-magic
zle -N toggle-alias zle-toggle-alias
zle -N toggle-sudo zle-toggle-sudo

# Keybindings
####################
# Set emacs mode
bindkey -e

# Set keybindings
# To add keys to $key, see man 5 terminfo
typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}
key[ShiftLeft]=${terminfo[kLFT]}
key[ShiftRight]=${terminfo[kRIT]}

[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[ShiftLeft]} ]] && bindkey "${key[ShiftLeft]}" backward-word
[[ -n ${key[ShiftRight]} ]] && bindkey "${key[ShiftRight]}" forward-word
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" history-beginning-search-backward
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" history-beginning-search-forward
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" history-beginning-search-backward
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" history-beginning-search-forward

bindkey	"^B"					backward-kill-word
bindkey	"^W"					kill-word
bindkey "^X "					hide-from-history
bindkey	"^Xd"					insert-iso-date
bindkey	"^Xe"					expand-word
bindkey	"^Xk"					insert-kept-result
bindkey	"^Xs"					toggle-sudo
bindkey	" "						expand-global-alias
bindkey -M menuselect	"i"		accept-and-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        print -n "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        print -n "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# Clean up
unset key
