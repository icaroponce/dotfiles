## Enable colors
autoload -U colors && colors

# Git branch + dirty state in prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '%F{red}*%f'
zstyle ':vcs_info:git:*' stagedstr '%F{222}+%f'
zstyle ':vcs_info:git:*' formats '%F{216}(%b)%f%u%c '

# Vi mode indicator: blank in insert, [N] in normal
VI_MODE=""
function zle-keymap-select {
  [[ $KEYMAP == vicmd ]] && VI_MODE="%F{red}[N]%f " || VI_MODE=""
  zle reset-prompt
}
function zle-line-init { VI_MODE=""; zle reset-prompt }
zle -N zle-keymap-select
zle -N zle-line-init

setopt PROMPT_SUBST
PROMPT=' %F{032}%1~ ${vcs_info_msg_0_}${VI_MODE}%F{105}λ%f '

# Show exit code in right prompt on failure
RPROMPT='%(?..%F{red}%? ↵%f)'

setopt AUTOCD		# Automatically cd into typed directory 
setopt INTERACTIVE_COMMENTS # Allow comments even in interactive shells.
setopt CORRECT
setopt DVORAK
setopt RM_STAR_WAIT

## Load aliases and other stuff if existent:
[ -f "${ZDOTDIR}/aliases.zsh" ] && source "${ZDOTDIR}/aliases.zsh"

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

# Don't record noise into zoxide — redefines the hook set by the eval above
function __zoxide_hook() {
    local pwd="$(__zoxide_pwd)"
    case "$pwd" in
        */.cache|*/.cache/*) return ;;
        */node_modules|*/node_modules/*) return ;;
        */.npm|*/.npm/*) return ;;
    esac
    \command zoxide add -- "$pwd"
}

# fzf shell integration
if [[ "$OSTYPE" == darwin* ]]; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
else
  [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
  [ -f /usr/share/fzf/completion.zsh ]   && source /usr/share/fzf/completion.zsh
fi
export FZF_DEFAULT_COMMAND='rg --files'
# Ctrl-L: pick a subdir with fzf (bypasses fzf's --walker which ignores FZF_DEFAULT_COMMAND on TTY)
function _fzf_cd() {
    local dir
    dir=$(fd --type d --max-depth 4 --exclude node_modules 2>/dev/null | fzf +m) \
        && cd "$dir"
    zle reset-prompt
}
zle -N _fzf_cd
bindkey '^L' _fzf_cd


eval "$(pyenv init -)"

[ -f "${ZDOTDIR}/private.zsh" ] && source "${ZDOTDIR}/private.zsh"

source "${ZDOTDIR}/plugins/zsh-autosuggestions.zsh"
source "${ZDOTDIR}/plugins/zsh-syntax-highlighting.zsh"
source "${ZDOTDIR}/plugins/zsh-history-substring-search.zsh"
# nix
# source "${ZDOTDIR}/plugins/zsh-nix-shell/nix-shell.plugin.zsh"
# source "${ZDOTDIR}/plugins/nix-zsh-completions/nix-zsh-completions.plugin.zsh"
# fpath=($ZDOTDIR/plugins/nix-zsh-completions $fpath)
# prompt_nix_shell_setup
#

# Search history
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export NVM_DIR="$HOME/.config/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Auto-switch node version when entering a directory with .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc ]]; then
    nvm use
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc  # also run on shell init

# opencode
export PATH=/home/icaro/.opencode/bin:$PATH

# ── Haskell ───────────────────────────────────────────────────────────────────
new-hs() {
  local name=$1
  if [[ -z "$name" ]]; then echo "Usage: new-hs <project-name>"; return 1; fi
  stack new "$name" simple --resolver "ghc-$(ghc --numeric-version)"
  cp ~/.config/haskell/fourmolu.yaml "$name/"
  cp ~/.config/haskell/justfile "$name/"
  cd "$name" && stack build
}
