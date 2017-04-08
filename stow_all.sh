#!/bin/bash
mkdir --verbose --parents \
	"${HOME}/.gnupg" \
	"${HOME}/.ipython/profile_default" \
	"${HOME}/.local/bin" \
	"${HOME}/.local/share/virtualenvs" \
	"${HOME}/.ssh"
stow --restow --target "${HOME}" --ignore='\.venv' \
	calc \
	git \
	gnupg \
	htop \
	neovim \
	pacman \
	python \
	shells \
	ssh \
	tmux \
	zsh

if [[ ${EUID} -ne 0 ]]; then
	mkdir --verbose --parents \
		"${HOME}/.config/cmus" \
		"${HOME}/.config/gtk-2.0" \
		"${HOME}/.config/gtk-3.0" \
		"${HOME}/.config/mpv" \
		"${HOME}/.config/ranger" \
		"${HOME}/.config/systemd/user" \
		"${HOME}/.unison"
	stow --restow --target "${HOME}" --ignore='\.venv' \
		a11y \
		appearance \
		cmus \
		cower \
		dunst \
		fontconfig \
		i3 \
		mpv \
		nestopia \
		profile-cleaner \
		ranger \
		rofi \
		snes9x \
		sxiv \
		unison \
		xorg
fi

chmod --changes 700 "${HOME}/.gnupg"
chmod --changes 700 "${HOME}/.ssh"
