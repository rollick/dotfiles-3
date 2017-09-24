#!/bin/zsh

# Enable ZLE widgets
####################
() {
	local widget
	local widgets

	typeset -A widgets

	widgets=(
		# widget                function
		'expand-global-alias'   'zle-expand-global-alias'
		'hide-from-history'     'zle-hide-from-history'
		'insert-iso-date'       'zle-insert-iso-date'
		'self-insert'           'url-quote-magic'
		'toggle-sudo'           'zle-toggle-sudo'
	)

	for widget in "${(@k)widgets}"; do
		zle -N "${widget}" "${widgets[${widget}]}"
	done
}

# Keybindings
####################
# Set emacs mode
bindkey -e

# Set keybindings
() {
	local bindings
	local conversion_table
	local func
	local keycombo
	local terminfo_code

	typeset -A bindings
	typeset -A conversion_table

	# To add keys to $key, see man 5 terminfo
	conversion_table=(
		# Key           terminfo codename
		'Delete'        'kdch1'
		'Down'          'kcud1'
		'End'           'kend'
		'Home'          'khome'
		'Insert'        'kich1'
		'Left'          'kcub1'
		'PageDown'      'knp'
		'PageUp'        'kpp'
		'Right'         'kcuf1'
		'ShiftLeft'     'kLFT'
		'ShiftRight'    'kRIT'
		'Up'            'kcuu1'
	)

	bindings=(
		# Key combination   function
		'Delete'            'delete-char'
		'Down'              'history-beginning-search-forward'
		'End'               'end-of-line'
		'Home'              'beginning-of-line'
		'Insert'            'overwrite-mode'
		'PageDown'          'history-beginning-search-forward'
		'PageUp'            'history-beginning-search-backward'
		'ShiftLeft'         'backward-word'
		'ShiftRight'        'forward-word'
		'Up'                'history-beginning-search-backward'

		' '                 'expand-global-alias'
		' ^'                'magic-space'
		'^B'                'backward-kill-word'
		'^W'                'kill-word'
		'^X '               'hide-from-history'
		'^Xd'               'insert-iso-date'
		'^Xe'               'expand-word'
		'^Xk'               'insert-kept-result'
		'^Xs'               'toggle-sudo'
	)

	for keycombo func in "${(@kv)bindings}"; do
		terminfo_code="${terminfo[${conversion_table[${keycombo}]}]}"

		if [[ -n ${terminfo_code} ]]; then
			bindkey "${terminfo_code}" "${func}"
		else
			bindkey "${keycombo}" "${func}"
		fi
	done
}

bindkey -M menuselect 'i'   accept-and-menu-complete

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
