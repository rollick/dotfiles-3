#!/bin/bash
mkdir --verbose -p "${HOME}/.moc"
mkdir --verbose -p "${HOME}/.ssh"
mkdir --verbose -p "${HOME}/.unison"
mkdir --verbose -p "${HOME}/.icons"
mkdir --verbose -p "${HOME}/.vim"
mkdir --verbose -p "${XDG_CONFIG_HOME:-${HOME}/.config}"
mkdir --verbose -p "${XDG_CONFIG_HOME:-${HOME}/.config}/gtk-3.0"

stow --verbose -R -t ${HOME} appearance
stow --verbose -R -t ${HOME} cups
stow --verbose -R -t ${HOME} dunst
stow --verbose -R -t ${HOME} moc
stow --verbose -R -t ${HOME} mpv
stow --verbose -R -t ${HOME} octave
stow --verbose -R -t ${HOME} openbox
stow --verbose -R -t ${HOME} profile-cleaner
stow --verbose -R -t ${HOME} shells
stow --verbose -R -t ${HOME} smallterm
stow --verbose -R -t ${HOME} ssh
stow --verbose -R -t ${HOME} tmux
stow --verbose -R -t ${HOME} unison
stow --verbose -R -t ${HOME} vim
stow --verbose -R -t ${HOME} x.org
stow --verbose -R -t ${HOME} zsh
