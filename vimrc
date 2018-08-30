" Modeline
" vim: set sw=4 sts=4 et tw=7 foldmarker={,} foldlevel=0 foldmarker=marker

" --- Basics --- {
set nocompatible
set shell=/bin/bash\ --login
filetype off
" }

" --- Pathogen exec --- {
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
" }

" --- Basic settings --- {
set nobackup
set nowritebackup
set noswapfile
set noerrorbells
set autoread
set textwidth=79
set mouse=a
set ruler
set showmode
set showcmd

let mapleader = ","
let maplocalleader = "\\"

" File behaviour
set expandtab
set smarttab
set linebreak

set backspace=indent,eol,start
set showbreak=↪

" Better completion
set complete=.,w,b,u,t
set completeopt=longest,menuone

" Folding (use Space to toggle folds)
set foldlevelstart=0
nnoremap <Space> za
vnoremap <Space> za
nnoremap z0 zcz0 " Make z0 recursively open whatever fold we're in
" }


" ========== Custom mappings ========== {
" Quick buffer switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Moving between buffers
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" Moving between tabs
nnoremap <leader>( :tabprev<CR>
nnoremap <leader>) :tabnext<CR>

" Windows resizing
nnoremap <m-right> :vertical resize +3<CR>
nnoremap <m-left> :vertical resize -3<CR>
nnoremap <m-up> :resize +3<CR>
nnoremap <m-down> :resize -3<CR>

" Split management
nnoremap <leader>w <C-w>v<C-w>l         " vertical split
nnoremap <leader>W <C-w>s               " horizontal split
nnoremap <leader>s :new<CR>             " horizontal split to new file 

nnoremap <leader>q :q<CR>               " quit window on leader
nnoremap K :q<CR>                       " quit window on K(ill)
nnoremap s :w<CR>                       " save on s

" Set working dir
nnoremap <leader>. :lcd %p:h<CR>

" Toggle line numbers
nnoremap <leader>n :setlocal number!<CR>

" Unmap arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" ------------------------------------------------------------------ }

" ----- Plugins -----
"
" Lightline

let g:lightline = {
  \  'active': {
  \    'left': [['mode', 'paste'], ['readonly', 'filename', 'modified']],
  \    'right': [['lineinfo'], ['percent'], ['gitbranch', 'fileformat', 'fileencoding']]
  \  },
  \  'component_function': {
  \    'gitbranch': 'gitbranch#name'
  \  }
  \ }

" NERDTree

map <C-o> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
