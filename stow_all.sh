#!/bin/bash
mkdir --verbose --parents \
	"${HOME}/.config/profile.d" \
	"${HOME}/.gnupg" \
	"${HOME}/.ipython/profile_default" \
	"${HOME}/.local/bin" \
	"${HOME}/.local/share/virtualenvs" \
	"${HOME}/.ssh"
stow --restow --target "${HOME}" --ignore='\.venv' \
	calc \
	colorgcc \
	git \
	gnupg \
	htop \
	ipython \
	less \
	neovim \
	pacman \
	python \
	rsync \
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
		"${HOME}/.config/xfce4/xfconf/xfce-perchannel-xml" \
		"${HOME}/.config/xorg/xprofile.d" \
		"${HOME}/.config/xorg/xsession.d" \
		"${HOME}/.unison"
	stow --restow --target "${HOME}" --ignore='\.venv' \
		a11y \
		appearance \
		cmus \
		cower \
		firefox \
		fontconfig \
		gimp \
		i3 \
		libreoffice \
		mpv \
		nestopia \
		numlockx \
		profile-cleaner \
		quodlibet \
		rofi \
		snes9x \
		st \
		sxiv \
		unison \
		xdg \
		xfce4-notifyd \
		xorg
fi

chmod --changes 700 "${HOME}/.gnupg"
chmod --changes 700 "${HOME}/.ssh"
