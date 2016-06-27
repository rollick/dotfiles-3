autoload -Uz add-zsh-hook

[[ -n  ${functions[chpwd-git]} ]] && add-zsh-hook chpwd chpwd-git
[[ -n  ${functions[chpwd-venv]} ]] && add-zsh-hook chpwd chpwd-venv
[[ -n  ${functions[precmd-hash_directories]} ]] && add-zsh-hook precmd precmd-hash_directories
[[ -n  ${functions[precmd-rehash]} ]] && add-zsh-hook precmd precmd-rehash
