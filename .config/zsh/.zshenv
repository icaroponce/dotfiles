# . "$HOME/.cargo/env"

export NVM_DIR="$HOME/.config/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# opencode
export PATH=/home/icaro/.opencode/bin:$PATH

export PATH=~/.local/bin:~/.cargo/bin:~/.cabal/bin:~/.ghcup/bin:/opt/i3-lock-fancy-rapid/:$PATH
[ -x "$(command -v yarn)" ] && export PATH=$(yarn global bin):$PATH

eval "$(pyenv init -)"
