#!/usr/bin/env sh

# THIS IS WORK IN PROGRESS! BE VERY VERY CAREFUL!
#
# You should download this file first, when do chmod +x and run
#
# Requirements:
#   - Dropbox
#   - should be run from the default login shell

# Causes the shell to exit if any subcommand or pipeline return a
# non-zero status (see man 1 bash)
set -e

CODE=$HOME/lib
DROPBOX=$HOME/Dropbox
DOTFILES=$HOME/lib/dotfiles

function link() {
    from="$1"
    to="$2"
    echo "Linking '$from' to '$to'"
    rm -f "$to"
    ln -s "$from" "$to"
}

if [[ ! -d "$DROPBOX" ]]; then
    echo "Looks like dropbox does not installed. Please install it first."
    exit 1
fi

mkdir -p $CODE

echo "Installing homebrew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing necessary homebrew components..."
brew install git openssl autoconf automake ssh-copy-id zsh pwgen
brew install fortune cowsay

echo "Installing Python..."
brew install python python3

echo "Installing pip and virtualenv..."
echo "THIS MAY FAIL MANY TIMES, SO RUN BY HANDS:"
echo "pip install virtualenv fabric pep8 flake8 lolcat"

# SSH configs
echo "Copying SSH keys and configs..."
mkdir -p $HOME/.ssh
link $DROPBOX/Private/ssh/config $HOME/.ssh/config
cp $DROPBOX/Private/ssh/keys/* $HOME/.ssh/
chmod 700 $HOME/.ssh/
chmod 600 $HOME/.ssh/*

# Clone dotfiles repo
echo "Cloning dotfiles repo..."
git clone https://github.com/altvec/dotfiles.git $DOTFILES
cd $DOTFILES

# Profile
link $DOTFILES/profile $HOME/.profile

# Git configs
echo "Linking git config files..."
link $DOTFILES/gitconfig $HOME/.gitconfig
link $DOTFILES/gitignore $HOME/.gitignore

# Updating submodules
echo "Updating submodules..."
git submodule init
git submodule update

# Link shell files and change default bash to ZSH
link $DOTFILES/.zshrc $HOME/.zshrc
link $DOTFILES/.zlogin $HOME/.zlogin
link $DOTFILES/.zsh $HOME/
echo "==========================================================="
echo "To change default shell to ZSH you should do the following:"
echo "sudo echo '# Installed via homebrew' >> /etc/shells"
echo "sudo echo '/usr/loca/bin/zsh' >> /etc/shells"
echo "chsh -s /usr/local/bin/zsh"
echo "==========================================================="

# AppleScripts
echo "Linking AppleScripts..."
link $DROPBOX/Private/applescripts/*.applescript $HOME/Library/Scripts/

# VIM
brew install vim
echo "Linking VIM configs..."
link $DOTFILES/vimrc $HOME/.vimrc
link $DOTFILES/vim $HOME/.vim

# Tmux
brew install tmux reattach-to-user-namespace
link $DOTFILES/tmux.conf $HOME/.tmux.conf

# Ruby
brew install rbenv ruby-build rbenv-default-gems rbenv-gem-rehash
echo "Linking Ruby configs..."
link $DOTFILES/.gemrc $HOME/.gemrc
mkdir -p $HOME/.rbenv
link $DOTFILES/rbenv/default-gems $HOME/.rbenv/default-gems

# Go
brew install go
mkdir -p $HOME/Projects/Go
