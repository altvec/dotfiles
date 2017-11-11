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

echo "Installing software..."
brew install git fish ssh-copy-id httpie python3 sbcl leiningen ffind
brew install emacs neovim fzf tmux reattach-to-user-namespace the_silver_searcher pipenv
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
link $DOTFILES/emacs.d $HOME/.emacs.d
link $DOTFILES/tmux.conf $HOME/.tmux.conf
link $DOTFILES/slate $HOME/.slate
echo "... done."

echo "==========================================================="
echo "To change default shell to Fish you should do the following:"
echo "sudo echo '/usr/loca/bin/fish' >> /etc/shells"
echo "chsh -s /usr/local/bin/fish"
echo "==========================================================="

echo Completed.
