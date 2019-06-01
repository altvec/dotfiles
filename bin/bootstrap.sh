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
brew install git \
             cmake \
             ctags \
             go \
             dep \
             node \
             fish \
             ssh-copy-id \
             heroku \
             python \
             python@2 \
             ipython \
             ansible \
             pandoc \
             pipenv \
             httpie \
             leiningen \
             ffind \
             fzf \
             vim \
             tmux \
             reattach-to-user-namespace \
             the_silver_searcher \
             pandoc

brew cask install emacs \
                  java \
                  karabiner-elements \
                  racket \
                  slack \
                  slate \
                  wireshark \
                  transmission \
                  iina \
                  keepingyouawake
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

echo "Updating submodules..."
git submodule init
git submodule update
echo "... done."

echo "Linking configs..."
link $DOTFILES/profile $HOME/.profile
link $DOTFILES/bash_profile $HOME/.bash_profile
link $DOTFILES/fish $HOME/.config/fish
link $DOTFILES/vimrc $HOME/.vimrc
link $DOTFILES/vim $HOME/.vim
link $DOTFILES/emacs.d/init.el $HOME/.emacs.d/init.el
link $DOTFILES/emacs.d/init.org $HOME/.emacs.d/init.org
link $DOTFILES/tmux.conf $HOME/.tmux.conf
link $DOTFILES/slate $HOME/.slate
link $DOTFILES/agignore $HOME/.agignore
echo "... done."

echo "==========================================================="
echo "To change default shell to Fish you should do the following:"
echo "sudo echo '/usr/loca/bin/fish' >> /etc/shells"
echo "chsh -s /usr/local/bin/fish"
echo "==========================================================="

echo Completed.
