#!/usr/bin/env bash

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
brew install git autoconf automake ssh-copy-id pwgen fish vim httpie go ack

echo "Installing Python..."
brew install python python3

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
link $DOTFILES/bash_profile $HOME/.bash_profile

# Git configs
echo "Linking git config files..."
link $DOTFILES/gitconfig $HOME/.gitconfig
link $DOTFILES/gitignore $HOME/.gitignore

# Updating submodules
echo "Updating submodules..."
git submodule init
git submodule update

# Link shell files and change default bash to ZSH
link $DOTFILES/fish $HOME/.config/fish
#link $DOTFILES/zshrc $HOME/.zshrc
#link $DOTFILES/zlogin $HOME/.zlogin
#link $DOTFILES/zsh $HOME/.zsh
echo "==========================================================="
echo "To change default shell to Fish you should do the following:"
echo "sudo echo '# Installed via homebrew' >> /etc/shells"
echo "sudo echo '/usr/loca/bin/fish' >> /etc/shells"
echo "chsh -s /usr/local/bin/fish"
echo "==========================================================="


# VIM
echo "Linking VIM configs..."
link $DOTFILES/vimrc $HOME/.vimrc
link $DOTFILES/vim $HOME/.vim

# Tmux
brew install tmux reattach-to-user-namespace
link $DOTFILES/tmux.conf $HOME/.tmux.conf

# Go
brew install go
mkdir -p $HOME/lib/Go

echo Completed.
