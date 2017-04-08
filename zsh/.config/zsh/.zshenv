#!/bin/zsh
# Set up enviroment for _all_ instances of zsh.
# CAUTION: Avoid any output at all, because this script is run for every
#          instance of zsh!

export ZDOTDIR="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh"

# Use some terminal emulators/multiplexers in 256 color mode
case "${TERM}" in
	'screen' )	export TERM='screen-256color';;
	'xterm' )	export TERM='xterm-256color';;
esac
