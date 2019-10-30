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

mkdir -p $CODE
mkdir -p $HOME/.emacs.d

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

echo "Installing Xcode command line tools..."
xcode-select --install

echo "Installing homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing software..."
brew install bash \
     bash-completion@2 \
     coreutils \
     git \
     pyenv \
     node \
     leiningen \
     ripgrep \
     tree \
     ssh-copy-id \
     heroku \
     ansible \
     pandoc \
     fzf \
     tmux \
     the_silver_searcher

brew cask install java \
     karabiner-elements \
     racket \
     wireshark \
     transmission \
     iina \
echo "... done."

echo "Copying SSH keys and configs..."
mkdir -p $HOME/.ssh
link $DROPBOX/Private/ssh/config $HOME/.ssh/config
cp $DROPBOX/Private/ssh/keys/* $HOME/.ssh/
chmod 700 $HOME/.ssh/
chmod 600 $HOME/.ssh/*
echo "... done."

echo "Cloning dotfiles repo..."
git clone https://github.com/altvec/dotfiles.git $DOTFILES
cd $DOTFILES
link $DOTFILES/gitconfig $HOME/.gitconfig
link $DOTFILES/gitignore $HOME/.gitignore
echo "... done."

echo "Linking configs..."
link $DOTFILES/.bash_profile $HOME/.bash_profile
link $DOTFILES/.bashrc $HOME/.bashrc
link $DOTFILES/.bash $HOME/.bash
link $DOTFILES/vimrc $HOME/.vimrc
link $DOTFILES/emacs.d/init.el $HOME/.emacs.d/init.el
link $DOTFILES/tmux.conf $HOME/.tmux.conf
echo "... done."

echo "Switch to using brew installed bash as default shell..."
if ! grep -q "$BREW_PREFIX}/bin/bash" /etc/shells; then
    echo "$BREW_PREFIX/bin/bash" | sudo tee -a /etc/shells
    chsh -s "$BREW_PREFIX/bin/bash"
fi

echo "Completed."
