#!/bin/bash
# Fix for unknown terminals
if [[ -n "${SSH_CONNECTION}" ]]; then
	export TERM='xterm'
fi

# SSH agent settings
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
