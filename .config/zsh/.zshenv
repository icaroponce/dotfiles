# . "$HOME/.cargo/env"

export NVM_DIR="$HOME/.config/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# opencode
export PATH=/home/icaro/.opencode/bin:$PATH

export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:~/.cabal/bin
export PATH=$PATH:~/.ghcup/bin
export PATH=$PATH:/opt/i3-lock-fancy-rapid/
[ -x "$(command -v yarn)" ] && export PATH=$PATH:$(yarn global bin)

eval "$(pyenv init -)"
