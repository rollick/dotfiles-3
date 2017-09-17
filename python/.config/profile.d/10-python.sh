#!/bin/bash
# Set path for startup
export PYTHONSTARTUP="${XDG_CONFIG_HOME:-${HOME}/.config}/python_startup.py"

# Set path for virtualenvwrapper
export WORKON_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/virtualenvs"
