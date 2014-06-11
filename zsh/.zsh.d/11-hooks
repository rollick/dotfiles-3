_rehash_pacman () {
	local lastcmd="${history[$[ HISTCMD -1 ]]}"

	if [[ "${lastcmd}" == *(cower|makepkg|pacman)* ]]; then
		rehash
	fi
}

add-zsh-hook precmd _rehash_pacman
