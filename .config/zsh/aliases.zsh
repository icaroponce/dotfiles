# convenient aliases for editing configs
alias \
	cfv="nvim ~/.config/nvim/init.lua" \
	cfz="nvim ~/.config/zsh/.zshrc" \
	soz="source ~/.config/zsh/.zshrc"

alias \
	vim="nvim" \
	vi="nvim" \
	v="nvim" \
	c="calcurse"

# j: zoxide picker (fzf); jumps directly when only one directory matches (--select-1).
# _ZO_FZF_OPTS replaces zoxide's defaults, so they are repeated here (zoxide 0.10).
function j {  # `function` keyword: no clash with an old `j` alias on re-source
    _ZO_FZF_OPTS="--exact --no-sort --bind=ctrl-z:ignore,btab:up,tab:down --cycle --keep-right \
--border=sharp --height=45% --info=inline --layout=reverse --tabstop=1 --exit-0 --select-1 \
--preview='\command -p ls -Cp --color=always --group-directories-first {2..}' \
--preview-window=down,30%,sharp" zi "$@"
}

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

# exa was renamed to eza
alias exa="eza"

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
