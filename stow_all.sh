#!/bin/sh
mkdir --verbose --parents \
	"${HOME}/.config/gnupg" \
	"${HOME}/.local/bin" \
	"${HOME}/.local/share/virtualenvs" \
	"${HOME}/.ssh"
chmod --changes 700 "${HOME}/.ssh"
stow --restow --target "${HOME}" --ignore='\.venv' \
	flake8 \
	git \
	gnupg \
	htop \
	neovim \
	octave \
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
		"${HOME}/.config/systemd/user" \
		"${HOME}/.unison"
	stow --restow --target "${HOME}" --ignore='\.venv' \
		a11y \
		appearance \
		cmus \
		cower \
		dunst \
		fontconfig \
		gvbam \
		i3 \
		mpv \
		nestopia \
		pacman \
		profile-cleaner \
		rofi \
		snes9x \
		sxiv \
		unison \
		urxvt \
		x.org
fi
