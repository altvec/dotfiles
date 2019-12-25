" Modeline
" Author: Sergey Kalistratov <altvec@gmail.com>
" This file is a constant experiment. Be careful.

" Preamble ---------------------------------------------------------------- {{{
"

setglobal nocompatible
setglobal pastetoggle=<F2>

let g:python_host_skip_check=1
let g:loaded_python3_provider=1

set shell=/bin/bash\ --login

" Install plugins manager
"
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Install plugins
"

Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'terryma/vim-multiple-cursors'
Plug 'honza/vim-snippets'
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim'
Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }

call plug#end()
" ------------------------------------------------------------------------- }}}

" Basic options ----------------------------------------------------------- {{{
"
set modelines=0
set autoindent
set showmode
set showcmd
set hidden
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set nonumber
set norelativenumber
set laststatus=2
set history=1000
set undofile
set undoreload=10000
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set lazyredraw
set matchtime=3
set showbreak=↪
set splitbelow
set splitright
set autowrite
set autoread
set shiftround
set title
set linebreak

set noerrorbells
set mouse=a


" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

" Time out on key codes but not mappings.
" Basically this makes terminal VIM work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" Make VIM able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"

" Better completion
set complete=.,w,b,u,t
set completeopt=longest,menuone

" Save when losing focus
au FocusLost * :silent! wall

" Leader
let mapleader = ","
let maplocalleader = "\\"

" Cursorline
" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

"Trailing whitespace
" Only show when not in insert mode.
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

" Wildmenu completion
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files
" Clojure/Leiningen
set wildignore+=classes
set wildignore+=lib

" Line Return
" Make sure VIM returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
                \ if line ("'\"") > 0 && line("'\"") <= line("$") |
                \       execute 'normal! g`"zvzz' |
                \ endif
augroup END

" Tabs, spaces, wrapping
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set textwidth=80
set formatoptions=qrn1j
set colorcolumn=+1

" Backups
set backup
set noswapfile
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exists.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Color scheme
"
syntax on
color dracula
let g:dracula_colorterm = 0
highlight Normal ctermbg=NONE
" ------------------------------------------------------------------------- }}}

" Convenience mappings ---------------------------------------------------- {{{
"
" Kill window
nnoremap K :q<CR>

" Save
nnoremap s :w<CR>

" Toggle line numbers
nnoremap <leader>n :setlocal number!<CR>

" Moving between tabs
nnoremap <leader>( :tabprev<CR>
nnoremap <leader>) :tabnext<CR>

" Windows resizing
nnoremap <m-right> :vertical resize +3<CR>
nnoremap <m-left> :vertical resize -3<CR>
nnoremap <m-up> :resize +3<CR>
nnoremap <m-down> :resize -3<CR>

" Directional Keys
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Easy buffer navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Moving between buffers
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" Split management
nnoremap <leader>w <C-w>v<C-w>l         " vertical split
nnoremap <leader>W <C-w>s               " horizontal split
nnoremap <leader>s :new<CR>             " horizontal split to new file

nnoremap <leader>q :q<CR>               " quit window on leader

" Set working dir
nnoremap <leader>. :lcd %p:h<CR>

" Unmap arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Moving lines (https://vim.fandom.com/wiki/Moving_lines_up_or_down)
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-j> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" ------------------------------------------------------------------------- }}}

" Folding ----------------------------------------------------------------- {{{
"
set foldlevelstart=0

" Space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

" Make z0 recursively open whatever fold we're in, even it's partially open.
nnoremap z0 zcz0

" "Focus" the current line. Basically:
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a bit (25 lines) down from the top of the screen.
" 4. Pulse the cursor line.
"
" This mapping wipes out the z mark, which I never use.
" I use :sus for the rare times I want to actually background VIM.
function! FocusLine()
    let oldscrolloff = &scrolloff
    set scrolloff=0
    execute "keepjumps normal! mzzMzvzt25\<c-y>`z:Pulse\<cr>"
    let &scrolloff = oldscrolloff
endfunction
nnoremap <c-z> :call FocusLine()<CR>

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()
" }}}

" Plugins ----------------------------------------------------------------- {{{
"
" FZF {{{
set rtp+=/usr/local/opt/fzf
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>a :Ag<CR>
" }}}

" Lightline {{{
set background=light
let g:lightline = {
  \  'active': {
  \    'left': [['mode', 'paste'], ['readonly', 'filename', 'modified']],
  \    'right': [['lineinfo'], ['percent'], ['gitbranch', 'fileformat', 'fileencoding']]
  \  },
  \  'component_function': {
  \    'gitbranch': 'gitbranch#name'
  \  },
  \  'colorscheme': 'dracula'
  \ }
" }}}

" NERD Tree {{{
map <C-o> :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
let NERDTreeChDirMode = 2
let NERDTreeShowHidden = 1
" }}}

" ------------------------------------------------------------------------- }}}
