# Personal config files
Scripts to set up my preferable terminal shell and vim editor configuration.

## Pre-requisites
To use this scripts, you must have properly running/installed in your machine:
  - [Vim](http://www.vim.org/)  - Text Editor;
  - [Bundle](https://github.com/VundleVim/Vundle.vim) - Plug-in Manager for Vim;
  - [Zsh and Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh) - Powerful Shell and its most popular framework;
  - [tmux](https://tmux.github.io/) - terminal multiplexer;
  - [Nerd-fonts](https://github.com/ryanoasis/nerd-fonts) - Complete fonts and icons collection;

## Getting started
Download or clone this repository into your machine.
To get the same result as mine, you probably should install other packages, as nvm or git-flow. But all the files are highly customizable, feel free to check their respective documentations on the Internet and adjust it regarding your style and needs. 

## Running the code

Place the .tmux.conf, .vimrc and .zshrc files into the user directory root: ~/ .
The .editorconfig into the ~/.vim directory. And the alias.zsh, you can place into ~/.oh-my-zsh/lib, as I'm doing.
But once again, you can do it differently, only remember to change the filepath on .zshrc. 

Soon I'm going to attach some screenshots of my terminal. Yes, I know it's important (:

Every time you update some file (.vimrc doesn't fit here, for more information about how to update it, read Vundle docs), "reload" it running the following command:

```
source $file_path
```
or just close and open the terminal again;
