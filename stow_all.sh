#!/bin/bash
mkdir --verbose -p "${HOME}/.moc"
mkdir -p "${HOME}/.ssh"
mkdir --verbose -p "${HOME}/.unison"
mkdir -p "${XDG_CONFIG_HOME:-${HOME}/.config}"
mkdir -p "${XDG_DATA_HOME:-${HOME}/.local/share}"

stow --verbose -R -t ${HOME} appearance
stow --verbose -R -t ${HOME} moc
stow --verbose -R -t ${HOME} openbox
stow --verbose -R -t ${HOME} ssh
stow --verbose -R -t ${HOME} tmux
stow --verbose -R -t ${HOME} unison
stow --verbose -R -t ${HOME} x.org
stow --verbose -R -t ${HOME} zsh-config
