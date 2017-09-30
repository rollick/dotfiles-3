#!/bin/bash
# Set path for startup
export PYTHONSTARTUP="${XDG_CONFIG_HOME:-${HOME}/.config}/python.py"

# Set path for virtualenvwrapper
export WORKON_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/virtualenvs"

# Set path to Python documentation
if [[ -z ${PYTHONDOCS} ]]; then
	if [[ -d "${XDG_PUBLICSHARE_DIR:-${HOME}/Public/python-docs}" ]]; then
		export PYTHONDOCS="${XDG_PUBLICSHARE_DIR:-${HOME}/Public/python-docs}"
	fi
fi
