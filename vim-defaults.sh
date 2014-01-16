#!/usr/bin/env sh

# Vim sanity
# ----------
#
# This is meant to bootstrap a sane vim environment on a new machine for
# editing Python files and other configuration files.  It is intended to be a
# minimalistic version of my full vimrc.
#
# This file will end up living at http://bluehat.me/vim.sh.
# The idea is to ssh into a remote machine that I log into often and run:
#
# $ curl http://bluehat.me/vim.sh | sh
#
# And get same sane default for vim.

VIMRC="set nocompatible
set hidden
set nowrap
set tabstop=2
set backspace=indent,eol,start
set autoindent
set copyindent
set shiftwidth=2
set shiftround
set showmatch
set ignorecase
set smartcase

set smarttab

set hlsearch
set incsearch
set textwidth=79
set nocursorline
set nojoinspaces
set cpoptions+=J
set noswapfile

filetype on
filetype plugin on
filetype indent on
filetype plugin indent on
set expandtab

nnoremap ; :
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

set ruler
nnoremap K <nop>

nnoremap <Space> za
vnoremap <Space> za
syntax enable"

echo "$VIMRC" > $HOME/.vimrc
