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

# o: open files with the default app, detached and quiet; no args: pick files with fzf (Tab marks several).
function o {
    local opener=xdg-open f
    [ "$(uname)" = "Darwin" ] && opener=open
    if [ $# -eq 0 ]; then
        set -- "${(@f)$(fd --type f --hidden --exclude .git | fzf --multi --height=45% --layout=reverse)}"
        [ -n "$1" ] || return
    fi
    for f in "$@"; do
        "$opener" "$f" >/dev/null 2>&1 &!
    done
}

# y: yazi; on quit (q) the shell cds to the directory yazi was in (Q quits without cd).
function y {
    local tmp="$(mktemp -t yazi-cwd.XXXXXX)" cwd
    yazi "$@" --cwd-file="$tmp"
    cwd="$(command cat -- "$tmp")"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
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
