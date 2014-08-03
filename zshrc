# Path to your oh-my-zsh configuration.
ZSH=$HOME/Code/dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="kennethreitz"
ZSH_THEME="minimal"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew python django pip osx colorize)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export TERM="xterm-256color"
export EDITOR="vim"
export PATH=./bin:$PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$PATH:/sbin

# Postgres.app
export PATH=/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH

# History
SAVEHIST=10000
HISTSIZE=10000

# ZSH performance tweak
# ... use a cache file
zstyle ':completion:*' use-cache on
# ... and then specify the cache file to use
zstyle ':completion:*' cache-path $HOME/.zshcache

# Aliases
source $HOME/.zshaliases

# Custom functions
source $HOME/.zshfunc

# Python stuff
#export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE="$HOME/.pip/cache"
export VIRTUALENV_DISTRIBUTE=true
export PYTHONUNBUFFERED=true
export PYTHONDONTWRITEBYTECODE=1
export WORKON_HOME=$HOME/.python-venvs
source /usr/local/bin/virtualenvwrapper.sh

# Node and NPM
export PATH=$PATH:/usr/local/share/npm/bin
export NODE_PATH=/usr/local/lib/node_modules

# Ruby stuff
eval "$(rbenv init -)"
