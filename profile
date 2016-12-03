
# locale settings 
export LANG=en_US.UTF-8
export LC_COLLATE=POSIX
if [[ $(uname) == "Darwin" ]]; then
   export LC_ALL=en_US.UTF-8
   export LC_CTYPE=en_US.UTF-8
fi

# update path
export PATH=$HOME/Library/Android/sdk/platform-tools:$HOME/bin:$HOME/lib/dotfiles/bin:/usr/local/bin:/usr/local/sbin:$PATH

# Go stuff
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=$HOME/lib/Go

export EDITOR=vim

# python stuff
export PYTHONDONTWRITEBYTECODE=1
