#!/bin/bash
mkdir --verbose --parents \
	"${HOME}/.config/gnupg" \
	"${HOME}/.local/share/virtualenvs" \
	"${HOME}/.ssh"
chmod --changes 700 "${HOME}/.ssh"
stow --restow --target "${HOME}" --ignore=.venv \
	flake8 \
	git \
	gnupg \
	htop \
	neovim \
	python \
	shells \
	ssh \
	tmux \
	virtualenvwrapper \
	zsh

if [[ ${EUID} -ne 0 ]]; then
	mkdir --verbose --parents \
		"${HOME}/.config/cmus" \
		"${HOME}/.config/gtk-2.0" \
		"${HOME}/.config/gtk-3.0" \
		"${HOME}/.config/mpv" \
		"${HOME}/.config/xfce4/xfconf/xfce-perchannel-xml" \
		"${HOME}/.local/bin" \
		"${HOME}/.unison"
	stow --restow --target "${HOME}" --ignore=.venv \
		appearance \
		cmus \
		cower \
		fontconfig \
		gvbam \
		i3 \
		pacman \
		profile-cleaner \
		nestopia \
		mpv \
		rofi \
		snes9x \
		sxiv \
		unison \
		urxvt \
		x.org
fi
