#!/bin/bash

# Set path for the history file
export LESSHISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/less_history"

# Settings for less
# -J = Display a status column
# -M = More verbose prompt
# -Ph = Prompt for the help screen
# -R = Display "raw" control characters
# -s = Fold consecutive blank lines into a single line
# -~ = Don't use '~' to indicate lines after the end of a file
LESS='-J-M-R-s-~'
LESS+='-PhHELP ?ltlines %lt-%lb?L/%L. ?e(END):?pB(%pB\%)..%t$'
export LESS
export SYSTEMD_LESS="${LESS}"

# Colorize man when using less as pager
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;5;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

# Load lespipe, which provides advanced functionality for less
which lesspipe >/dev/null 2>&1 && eval "$(lesspipe)"
which lesspipe.sh >/dev/null 2>&1 && eval "$(lesspipe.sh)"

# Set less as the default pager
export MANPAGER='less'
export PAGER='less'
export READNULLCMD='less'
export SYSTEMD_PAGER='less'

# Use a nice textwidth for man pages
export MANWIDTH='80'

# Set a much nicer prompt for manpage display with less
MANLESS='Manual page \$MAN_PN ?ltlines %lt-%lb?%L/%L.:'
MANLESS+='byte %bB?s/%s.. '
MANLESS+='?e(END):?pB%pB\%..%t$'
export MANLESS
