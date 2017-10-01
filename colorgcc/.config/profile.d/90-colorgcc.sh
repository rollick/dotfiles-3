#!/bin/bash
# Add colorgcc directory to PATH
if [[ -d "/usr/lib/colorgcc/bin" ]]; then
	export PATH="/usr/lib/colorgcc/bin:${PATH}"
fi
