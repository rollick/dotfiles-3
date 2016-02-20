#!/bin/bash
mkdir --verbose -p "${HOME}/.config/gnupg"
mkdir --verbose -p "${HOME}/.local/share/virtualenvs"
mkdir --verbose -p "${HOME}/.ssh"
chmod --verbose 700 "${HOME}/.ssh"
stow --verbose -R -t ${HOME} --ignore=.venv flake8
stow --verbose -R -t ${HOME} --ignore=.venv git
stow --verbose -R -t ${HOME} --ignore=.venv gnupg
stow --verbose -R -t ${HOME} --ignore=.venv htop
stow --verbose -R -t ${HOME} --ignore=.venv neovim
stow --verbose -R -t ${HOME} --ignore=.venv python
stow --verbose -R -t ${HOME} --ignore=.venv shells
stow --verbose -R -t ${HOME} --ignore=.venv ssh
stow --verbose -R -t ${HOME} --ignore=.venv tmux
stow --verbose -R -t ${HOME} --ignore=.venv virtualenvwrapper
stow --verbose -R -t ${HOME} --ignore=.venv zsh

if [[ ${UID} -ne 0 ]]; then
	mkdir --verbose -p "${HOME}/.config/cmus"
	mkdir --verbose -p "${HOME}/.config/gtk-2.0"
	mkdir --verbose -p "${HOME}/.config/gtk-3.0"
	mkdir --verbose -p "${HOME}/.config/xfce4/xfconf/xfce-perchannel-xml"
	mkdir --verbose -p "${HOME}/.local/bin"
	mkdir --verbose -p "${HOME}/.unison"
	stow --verbose -R -t ${HOME} --ignore=.venv appearance
	stow --verbose -R -t ${HOME} --ignore=.venv cmus
	stow --verbose -R -t ${HOME} --ignore=.venv fontconfig
	stow --verbose -R -t ${HOME} --ignore=.venv i3
	stow --verbose -R -t ${HOME} --ignore=.venv pacman
	stow --verbose -R -t ${HOME} --ignore=.venv pacaur
	stow --verbose -R -t ${HOME} --ignore=.venv profile-cleaner
	stow --verbose -R -t ${HOME} --ignore=.venv termite
	stow --verbose -R -t ${HOME} --ignore=.venv unison
	stow --verbose -R -t ${HOME} --ignore=.venv x.org
fi
