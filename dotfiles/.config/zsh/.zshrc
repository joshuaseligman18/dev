FPATH="$(brew --prefix)/share/zsh/site-functions/:${FPATH}"

source $(brew --prefix)/share/antigen/antigen.zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen apply

eval "$(starship init zsh)"

alias ls="ls --color"
alias vim="nvim"

export GIT_EDITOR="nvim"
