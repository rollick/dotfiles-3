#!/bin/bash
# Executed by startx (run your window manager from here)

if [[ -d /etc/X11/xinit/xinitrc.d ]]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [[ -x "$f" ]] && . "$f"
  done
  unset f
fi

# Load xprofile
if [[ -f  "${HOME}/.xprofile" ]]; then
	source "${HOME}/.xprofile"
fi

# Load session specific commands
if [[ -f "${HOME}/.xsession" ]]; then
	source "${HOME}/.xsession"
fi

# Start WM/DE
exec openbox-session
