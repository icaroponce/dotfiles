## Enable colors
autoload -U colors && colors
PROMPT=" %F{032}%1~ %F{105}λ%f "

setopt AUTOCD		# Automatically cd into typed directory 
setopt INTERACTIVE_COMMENTS # Allow comments even in interactive shells.
setopt CORRECT
setopt DVORAK
setopt RM_STAR_WAIT

## Load aliases and other stuff if existent:
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# Completion:
autoload -Uz compinit
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Edit line in vim with ctrl-v:
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# Enable searching through history
bindkey '^R' history-incremental-pattern-search-backward

# Accept command suggestion with ctrl+space
bindkey '^ ' autosuggest-accept

eval "$(thefuck --alias)"
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"

# Fuzzy matching vim pluging junegunn/fzf with ripgrep for listing
export PATH=$PATH:~/.vim/pack/minpac/start/fzf/bin
export FZF_DEFAULT_COMMAND='rg --files'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:~/.cabal/bin
export PATH=$PATH:~/.ghcup/bin
export PATH=$PATH:/opt/i3-lock-fancy-rapid/
[ -x "$(command -v yarn)" ] && export PATH=$PATH:$(yarn global bin)

eval "$(pyenv init -)"

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/p" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/p"

source "${ZDOTDIR}/plugins/zsh-autosuggestions.zsh"
source "${ZDOTDIR}/plugins/zsh-syntax-highlighting.zsh"
source "${ZDOTDIR}/plugins/zsh-history-substring-search.zsh"
# nix
source "${ZDOTDIR}/plugins/zsh-nix-shell/nix-shell.plugin.zsh"
source "${ZDOTDIR}/plugins/nix-zsh-completions/nix-zsh-completions.plugin.zsh"
fpath=($ZDOTDIR/plugins/nix-zsh-completions $fpath)
prompt_nix_shell_setup
#

# Search history
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
