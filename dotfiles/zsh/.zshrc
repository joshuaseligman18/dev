fpath=(
    "$(brew --prefix)/share/zsh/site-functions"
    $fpath
)
autoload -Uz compinit
compinit

eval "$(mise activate zsh)"
eval "$(starship init zsh)"

alias vim="nvim"
alias ls="ls --color"
alias ll="ls -lh"
alias la="ls -a"
alias lla="ls -lha"

export GIT_EDITOR="nvim"
export VISUAL="nvim"
export EDITOR="nvim"
