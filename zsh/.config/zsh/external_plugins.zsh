export ZPLUG_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zplug"

if [[ ! -d "${ZPLUG_HOME}" ]]; then
	curl -fLo "${ZPLUG_HOME}/zplug" --create-dirs "https://git.io/zplug"

	source "${ZPLUG_HOME}/zplug"

	zplug update --self
fi

if [[ -d "${ZPLUG_HOME}" ]]; then
	source "${ZPLUG_HOME}/zplug"

	zplug "b4b4r07/zplug" # Let zplug handle itself correctly

	zplug "hlissner/zsh-autopair"
	zplug "zsh-users/zsh-completions"
	zplug "zsh-users/zsh-syntax-highlighting"

	if ! zplug check; then
		zplug install
	fi

	zplug load
fi

# Include external additions provided by packages
source "/usr/share/doc/pkgfile/command-not-found.zsh" &>|/dev/null
source "/etc/zsh_command_not_found" &>|/dev/null
source "/usr/bin/virtualenvwrapper.sh" &>|/dev/null
