#!/bin/bash
mkdir -p "${XDG_CONFIG_HOME:-${HOME}/.config}"
mkdir -p "${XDG_DATA_HOME:-${HOME}/.local/share}"

stow --verbose -R -t ${HOME} appearance
stow --verbose -R -t ${HOME} moc
stow --verbose -R -t ${HOME} openbox
stow --verbose -R -t ${HOME} x.org
stow --verbose -R -t ${HOME} zsh-config
