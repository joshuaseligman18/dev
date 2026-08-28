fpath=(
    "$(brew --prefix)/share/zsh/site-functions"
    $fpath
)
autoload -Uz compinit
compinit

eval "$(mise activate zsh)"
eval "$(starship init zsh)"

alias vim="nvim"

export GIT_EDITOR="nvim"
export VISUAL="nvim"
export EDITOR="nvim"
