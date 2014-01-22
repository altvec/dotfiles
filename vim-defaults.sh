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

VIMRC='
set t_Co=256                                " use 256 colors by default
set background=dark                         " set dark background
set tabstop=4                               " number of visual spaces per TAB
set softtabstop=4                           " number of spaces in tab when editing
set expandtab                               " tabs are spaces

set number                                  " show line numbers
set showcmd                                 " show command in bottom bar
set cursorline                              " highlight current line

filetype indent on                          " load filetype-specific indent file

set wildmenu                                " visual autocomplete for command menu
set lazyredraw                              " redraw only when we need to
set showmatch                               " highlight matching [{()}]

set incsearch                               " search as characters are entered
set hlsearch                                " highlight matches

nnoremap <leader><space> :nohlsearch<CR>    " turn off search hightlight: press ,<space>
nnoremap <space> za                         " space open/closes folds

set foldenable                              " enable folding
set foldlevelstart=10                       " open most folds by default
set foldnestmax=10                          " 10 nested folds max
set foldmethod=indent                       " fold based on indent level

let mapleader=","                           " leader is comma

set nocompatible                            " default to vim
set nowrap                                  " disable line wrap
set autoindent
set copyindent

set textwidth=79                            " line width set to 79 symbols
set noswapfile                              " its 2014, disable swap file

filetype on
filetype plugin on
filetype plugin indent on

syntax enable                               " enable syntax processing
'
echo "$VIMRC" > $HOME/.vimrc
