# . "$HOME/.cargo/env"

export NVM_DIR="$HOME/.config/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Homebrew (macOS arm64) — must come before /usr/local to avoid picking up Intel binaries
[[ "$(uname)" == "Darwin" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

path=(
    $HOME/.opencode/bin
    $HOME/.local/bin
    $HOME/.cargo/bin
    $HOME/.cabal/bin
    $HOME/.ghcup/bin
    /opt/i3-lock-fancy-rapid
    $path
)
export PATH

[ -x "$(command -v yarn)" ] && export PATH=$(yarn global bin):$PATH
[ -x "$(command -v pyenv)" ] && eval "$(pyenv init -)"
