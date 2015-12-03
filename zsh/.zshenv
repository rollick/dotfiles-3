#!/bin/zsh
# Set up enviroment for _all_ instances of ZSH
# CAUTION: Avoid any output at all, because this script is run for every
#          instance of ZSH!

export ZDOTDIR="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh"

# Use some terminal emulators/multiplexers in 256 color mode
case "${TERM}" in
	"xterm" )	export TERM="xterm-256color";;
	"screen" )	export TERM="screen-256color";;
esac
