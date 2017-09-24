#!/bin/zsh
# Loaded for interactive shells only

# Load zsh modules
() {
	local module
	local modules

	modules=(
		'zsh/complist'
	)

	for module in "${(@)modules}"; do
		zmodload -F "${module}"
	done
}

# Load zsh (upstream) functions
() {
	local _XDG_CACHE_HOME
	local cmnd
	local func
	local funcs

	typeset -A modules

	_XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"

	funcs=(
	    # Module            Autostart command
		'add-zsh-hook'      ''
		'colors'            'colors'
		'compinit'          'compinit -d "${_XDG_CACHE_HOME}/zsh/zcompdump"'
		'keeper'            'keeper'
		'promptinit'        ''
		'url-quote-magic'   ''
		'vcs_info'          ''
		'zmv'               ''
	)

	for func cmnd in "${(@kv)funcs}"; do
		if [[ -n "${cmnd}" ]]; then
			autoload -Uz "${func}" && eval -- "${cmnd}"
		else
			autoload -Uz "${func}"
		fi
	done
}

# Load own functions
() {
	local funcpath
	local funcpaths

	funcpaths=(
		"${ZDOTDIR}/zle"
		"${ZDOTDIR}/prompts"
		"${ZDOTDIR}/hooks"
		"${ZDOTDIR}/functions"
	)

	for funcpath in "${(@)funcpaths}"; do
		if [[ -d "${funcpath}" ]]; then
			fpath=("${funcpath}" ${fpath})
			autoload -Uz ${funcpath}/*(.,@N:t)
		fi
	done

	# Make sure all fpath entries are unique
	typeset -U fpath
}

# Load misc. settings
() {
	local file

	for file in "${ZDOTDIR}"/[0-9][0-9]-*.zsh(.N); do
		if [[ -r "${file}" ]]; then
			source "${file}"
		fi
	done
}

# Set prompt
() {
	local prompt
	local prompts

	prompts=(
		'simple'
		'adam'
	)

	# Enable prompt system
	promptinit

	# Set prompt
	for prompt in "${(@)prompts}"; do
		if [[ -n ${functions[prompt_${prompt}_setup]} ]]; then
			prompt "${prompt}"
			break
		fi
	done
}
