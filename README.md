# Personal config files

## Pre-requisites
To use this scripts, you must have properly running/installed in your machine:
  - [Vim 8.0](http://www.vim.org/)
  - [Neovim](https://neovim.io/)
  - [Zsh and Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh)
  - [tmux](https://tmux.github.io/)
  - [Nerd-fonts](https://github.com/ryanoasis/nerd-fonts)

## Getting started
Download or clone this repository into your machine.
To get the same result as mine, you probably should install other packages, as nvm or git-flow. But all the files are highly customizable, feel free to check their respective documentations and adjust it based on your style and needs. 

## Get it working

Basically, dowload the repo and create symbolic links for all the files:

```sh
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/alias.sh ~/alias.sh
```
