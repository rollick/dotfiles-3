#!/bin/bash

# Set path of GTK2+ configuration
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-${HOME}/.config}/gtk-2.0/gtkrc-2.0"

# Disable GTK3+ overlay scrollbars
export GTK_OVERLAY_SCROLLING=0
