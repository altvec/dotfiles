" Pathogen On
source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim

filetype off
execute pathogen#incubate()

filetype plugin indent on
set nocompatible

" Backups
set backup
set noswapfile
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Basic stuff
set encoding=utf-8
set hidden
set nowrap
set tabstop=4
set backspace=indent,eol,start
set autoindent
set copyindent
set shiftwidth=4
set shiftround
set showmatch
set ignorecase
set smartcase
set number

set smarttab

set hlsearch
set incsearch
set textwidth=79
set nocursorline
set nojoinspaces
set cpoptions+=J
set noswapfile

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

" Color scheme
syntax on
set background=dark
let g:badwolf_tabline=2
let g:badwolf_html_link_underline=0
colorscheme badwolf

" Gui settings
set guifont=Menlo:h12

" Auto reload .vimrc
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,.gvimrc,_gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
