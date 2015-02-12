#!/bin/zsh
# Set up enviroment for _all_ instances of ZSH
# CAUTION: Avoid any output at all, because this script is run for every
#          instance of ZSH!

# Set history options
export HISTFILE="${HOME}/.zsh_history"
export SAVEHIST=10000
export HISTSIZE=12000

# Use some terminal emulators/multiplexers in 256 color mode
case "${TERM}" in
	"xterm" )	export TERM="xterm-256color";;
	"screen" )	export TERM="screen-256color";;
esac

# Set up syntax highlighting
if [[ -d "/usr/share/zsh/plugins/zsh-syntax-highlighting/" ]]; then
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
	export ZSH_HIGHLIGHT_HIGHLIGHTERS
fi
