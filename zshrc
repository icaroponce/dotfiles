export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

export ZSH=$HOME/.oh-my-zsh
export EDITOR="nvim"
export MYVIMRC="~/.vimrc"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

ZSH_THEME="my"

setopt RM_STAR_WAIT
setopt interactivecomments
setopt CORRECT

source ~/.alias.sh # private-aliases
source ~/alias.sh

DISABLE_AUTO_TITLE="true"

plugins=(git dotenv tmux node zshmarks vi-mode zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

eval $(thefuck --alias)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin:~/protoc/bin

eval "$(direnv hook zsh)"

# Fuzzy matching vim pluging junegunn/fzf with ripgrep for listing
export PATH=$PATH:~/.vim/pack/minpac/start/fzf/bin
export FZF_DEFAULT_COMMAND='rg --files'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=$PATH:~/.local/bin
export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PATH:$(yarn global bin)
export PATH=$PATH:$PYENV_ROOT/bin
export PATH=$PATH:/opt/i3-lock-fancy-rapid/

eval "$(pyenv init -)"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/icaro/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/icaro/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
#[[ -f /home/icaro/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /home/icaro/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
#[[ -f /home/icaro/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /home/icaro/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh
