# convenient aliases for editing configs
alias \
	cfv="nvim ~/.config/nvim/init.lua" \
	cfz="nvim ~/.config/zsh/.zshrc" \
	soz="source ~/.config/zsh/.zshrc"

alias \
	vim="nvim" \
	vi="nvim" \
	v="nvim" \
	j="zi" \
	n="newsboat" \
	b="buku --suggest" \
	c="calcurse"

# clipboard
if [ "$(uname)" = "Darwin" ]; then
    alias cs="pbcopy"
else
    alias cs="xclip -selection clipboard"
fi
# docker remove exited containers
alias docrme='docker rm -v $(docker ps -qa -f status=exited)'
# docker pause and remove
alias docsr='docker rm $(docker stop $(docker ps -q))'

# Verbosity and settings that you pretty much just always are going to want.
alias \
    cp="cp -iv" \
    mv="mv -iv" \
    rm="rm -vI" \
    bc="bc -ql" \
    mkd="mkdir -pv" \
    history="history -10000000"

# Colorize commands when possible.
alias \
    grep="grep --color=auto" \
    diff="diff --color=auto"

if [ "$(uname)" = "Darwin" ]; then
    alias ls="ls -h --color=auto"
else
    alias ls="ls -h --color=auto --group-directories-first"
fi

# Git aliases
alias \
    g="git" \
    ga="git add" \
    gaa="git add --all" \
    gb="git branch" \
    gbd="git branch -d" \
    gbD="git branch -D" \
    gbl="git blame -b -w" \
    gc="git commit -v" \
    gca="git commit -v -a" \
    gcb="git checkout -b" \
    gcf="git config --list" \
    gcd="git checkout develop" \
    gcmsg="git commit -m" \
    gco="git checkout" \
    gd="git diff" \
    gl="git pull" \
    glg="git log --stat" \
    gm="git merge" \
    gp="git push" \
    gsb="git status -sb" \
    gst="git status" \
    gsta="git stash push" \
    gstaa="git stash apply" \
    gstc="git stash clear" \
    gstd="git stash drop" \
    gstl="git stash list" \
    gstp="git stash pop"
