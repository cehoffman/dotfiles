if (( $+commands[direnv] )) && [[ -o interactive ]]; then
	eval "$(direnv hook zsh)"
fi

# vim: ft=zsh
