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

CODE=$HOME/Code
DROPBOX=$HOME/Dropbox
DOTFILES=$HOME/Code/dotfiles

mkdir -p $CODE

echo "Installing homebrew..."
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
export PATH=/usr/local/bin:$PATH

echo "Installing necessary homebrew components..."
brew install git openssl autoconf automake ssh-copy-id zsh ffmpeg

echo "Installing Python..."
brew install python

echo "Installing pip and virtualenv..."
easy_install pip
pip install virtualenv virtualenvwrapper fabric pep8 flake8

# Clone dotfiles repo
git clone https://github.com/altvec/dotfiles.git $DOTFILES
cd $DOTFILES

# Updating submodules
git submodule init
git submodule update

# Link shell files and change default bash to ZSH
ln -s $DOTFILES/zshrc $HOME/.zshrc
ln -s $DOTFILES/zshaliases $HOME/.zshaliases
ln -s $DOTFILES/zshfunc $HOME/.zshfunc
echo "To change default shell to ZSH you should do the following:"
echo "sudo echo 'Installed via homebrew' >> /etc/shells"
echo "sudo echo '/usr/loca/bin/zsh' >> /etc/shells"
echo "chsh -s /usr/local/bin/zsh"

# SSH configs
mkdir -p $HOME/.ssh
ln -s $DROPBOX/Private/ssh/config $HOME/.ssh/config
cp $DROPBOX/Private/ssh/keys/srg $HOME/.ssh/srg
cp $DROPBOX/Private/ssh/keys/srg.pub $HOME/.ssh/srg.pub

# Git configs
ln -s $DROPBOX/Private/gitconfig $HOME/.gitconfig
ln -s $DOTFILES/.gitignore $HOME/.gitignore

# AppleScripts
ln -s $DROPBOX/Private/applescripts/*.applescript $HOME/Library/Scripts/

# VIM
mkdir -p $DOTFILES/vim/tmp/swap
mkdir -p $DOTFILES/vim/tmp/backup
mkdir -p $DOTFILES/vim/tmp/undo
ln -s $DOTFILES/vimrc $HOME/.vimrc
ln -s $DOTFILES/vim $HOME/.vim
