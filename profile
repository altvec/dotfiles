# locale settings 
export LANG=en_US.UTF-8
export LC_COLLATE=POSIX
if [[ $(uname) == "Darwin" ]]; then
    export LC_ALL=
    export LC_CTYPE=en_US.UTF-8
fi

# update path
export PATH=$HOME/bin:$HOME/lib/dotfiles/bin:/usr/local/bin:/usr/local/sbin:$PATH

# Go stuff
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=$HOME/lib/Go

export EDITOR=vim
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
export CLICOLOR=1

# Python stuff
export PYTHONDONTWRITEBYTECODE=1
export IGNOREEOF=1

# Pretty man
function man {
    env \
    LESS_TERMCAP_md=$'\e[1;36m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[1;40;92m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[1;32m' \
    man "$@"
}

export PATH="$HOME/.cargo/bin:$PATH"
