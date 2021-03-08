#alias for neovim
alias vim='nvim'

# convenient aliases for editing configs
alias cfa='vim ~/.config/alacritty/alacritty.yml'
alias cfv='vim ~/.config/nvim/init.vim'
alias cfi='vim ~/.config/i3/config'
alias cfz='vim ~/.zshrc'
alias soz='source ~/.zshrc'

# xclip alias
alias cs='xclip -selection clipboard'

# docker remove exited containers
alias docrme='docker rm -v $(docker ps -qa -f status=exited)'
# docker pause and remove 
alias docsr='docker rm $(docker stop $(docker ps -q))'

# zshmarks (zsh's bookmark plugin)
alias j='jump'
alias s='bookmark'
alias n='newsboat'
alias b='buku --suggest'
alias c='calcurse'
