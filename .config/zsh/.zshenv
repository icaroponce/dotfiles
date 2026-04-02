# . "$HOME/.cargo/env"

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

export EDITOR="nvim"
export VISUAL=$EDITOR
export USE_EDITOR=$EDITOR
export TERMINAL="kitty"
export FILE="ranger"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export MYVIMRC="${XDG_CONFIG_HOME}/nvim/init.lua"

export MANPAGER='nvim +Man!'
export MANWIDTH=999

if [ "$(uname)" = "Darwin" ]; then
    export BROWSER="open"
else
    export BROWSER="brave"
    export READER="zathura"
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_QPA_PLATFORMTHEME="gtk2"
fi

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
