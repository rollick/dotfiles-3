#!/bin/bash
CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
mkdir --verbose -p "${HOME}/.ssh"
mkdir --verbose -p "${HOME}/.vim"
mkdir --verbose -p "${CONFIG_HOME}/gtk-3.0"
stow --verbose -R -t ${HOME} appearance
stow --verbose -R -t ${HOME} fontconfig
stow --verbose -R -t ${HOME} git
stow --verbose -R -t ${HOME} python
stow --verbose -R -t ${HOME} shells
stow --verbose -R -t ${HOME} ssh
stow --verbose -R -t ${HOME} tmux
stow --verbose -R -t ${HOME} vim
stow --verbose -R -t ${HOME} zsh

if [[ ${UID} -ne 0 ]]; then
	mkdir --verbose -p "${HOME}/.unison"
	mkdir --verbose -p "${DATA_HOME}/applications"
	stow --verbose -R -t ${HOME} dunst
	stow --verbose -R -t ${HOME} i3
	stow --verbose -R -t ${HOME} pacman
	stow --verbose -R -t ${HOME} profile-cleaner
	stow --verbose -R -t ${HOME} simpleterm
	stow --verbose -R -t ${HOME} unison
	stow --verbose -R -t ${HOME} x.org
fi
