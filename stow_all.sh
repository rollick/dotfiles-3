#!/bin/bash
mkdir --verbose -p "${HOME}/.config/gtk-2.0"
mkdir --verbose -p "${HOME}/.config/gtk-3.0"
mkdir --verbose -p "${HOME}/.config/ranger"
mkdir --verbose -p "${HOME}/.config/gnupg"
mkdir --verbose -p "${HOME}/.ssh"
chmod --verbose 700 "${HOME}/.config/gnupg"
chmod --verbose 700 "${HOME}/.ssh"
stow --verbose -R -t ${HOME} appearance
stow --verbose -R -t ${HOME} fontconfig
stow --verbose -R -t ${HOME} git
stow --verbose -R -t ${HOME} gnupg
stow --verbose -R -t ${HOME} neovim
stow --verbose -R -t ${HOME} python
stow --verbose -R -t ${HOME} ranger
stow --verbose -R -t ${HOME} shells
stow --verbose -R -t ${HOME} ssh
stow --verbose -R -t ${HOME} tmux
stow --verbose -R -t ${HOME} x.org
stow --verbose -R -t ${HOME} zsh

if [[ ${UID} -ne 0 ]]; then
	mkdir --verbose -p "${HOME}/.local/bin"
	mkdir --verbose -p "${HOME}/.unison"
	stow --verbose -R -t ${HOME} dunst
	stow --verbose -R -t ${HOME} i3
	stow --verbose -R -t ${HOME} pacman
	stow --verbose -R -t ${HOME} pacaur
	stow --verbose -R -t ${HOME} profile-cleaner
	stow --verbose -R -t ${HOME} scripts
	stow --verbose -R -t ${HOME} unison
elif [[ ${UID} -eq 0 ]]; then
	stow --verbose -R -t ${HOME} su
fi
