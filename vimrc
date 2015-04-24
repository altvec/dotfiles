" Pathogen exec
execute pathogen#infect()
syntax on
filetype plugin indent on

" ============================================================================== 
" Basic settings
" ============================================================================== 
set nocompatible                        " disable compatibility with old VI

set ruler
set showmode
set showcmd
set nobackup                            " no backup files
set nowritebackup                       " no backup while editing file
set noswapfile                          " no swap files (it's almost 2015!)
set t_Co=256                            " 256 colors
set cursorline                          " highlight cursor line

set smarttab
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap

let mapleader = ","                     " change leader from \ to ,
let maplocalleader = "\\"

set textwidth=80                        " old standart :)
set autoread                            " reload files if they changed on disk

set backspace=indent,eol,start

" Habit breaking, habit making
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" ==============================================================================
" GUI settings
" ==============================================================================
set ls=2                                " always show statusbar
set enc=utf-8                           " UTF-8 as default encoding
set colorcolumn=+1

if has("mac")
    set guifont=Ubuntu\ Mono\ derivative\ Powerline:h14
else
    set guifont=Ubuntu\ Mono\ derivative\ Powerline:h14
endif

set background=dark
colorscheme solarized

" --- Molokai colorscheme --- {
"colorscheme molokai
"let g:molokai_original = 1
"let g:rehash256 = 1
" }

" --- Badwolf colorscheme --- {
"colorscheme badwolf
"let g:badwolf_darkgutter = 1
"let g:badwolf_tabline = 2
" Turn off HTML link underlining
"let g:badwolf_html_link_underline = 0
" }

" ==============================================================================
" Airline settings
" ==============================================================================
let g:airline_theme = 'solarized'
let g:airline_powerline_fonts =1
if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif
let g:airline_symbols.space = "\ua0"

" ==============================================================================
" Search settings
" ==============================================================================
set ignorecase
set smartcase
set incsearch                           " incremental search
set hlsearch                            " highlight results
set showmatch
set gdefault

" ==============================================================================
" Languages support
" ==============================================================================

" --- Python ---
autocmd FileType python setlocal expandtab 
	\ shiftwidth=4 tabstop=8 softtabstop=4 
	\ formatoptions+=croq smartindent 
	\ cinwords=if,elif,else,for,while,try,exce,pt,finally,def,class,with

" --- Ruby ---
autocmd BufNewFile,BufRead {Gemfile,Rakefile,Vagrantfile,config.ru} set ft=ruby
autocmd FileType ruby setlocal expandtab
	\ shiftwidth=2 softtabstop=2 tabstop=2

" --- Rust ---
autocmd BufNewFile,BufRead *.rs setlocal ft=rust

" --- HTML ---
autocmd FileType html set omnifunc=htmlComplete#CompleteTags

" --- Template Languages ---
autocmd FileType html,xhtml,xml,htmldjando,htmljinja,eruby,mako 
	\ setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufNewFile,BufRead *.rthml setlocal ft=eruby
autocmd BufNewFile,BufRead *.tmpl setlocal ft=htmljinja
autocmd BufNewFile,BufRead *.py_tmpl setlocal ft=python

" --- CSS ---
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" --- Puppet ---
autocmd BufRead,BufNewFile *.pp set ft=puppet

" ==============================================================================
" Plugins: NERDTree
" ==============================================================================
noremap <F2> :NERDTreeToggle<CR>
inoremap <F2> <ESC>:NERDTreeToggle<CR>
let NERDTreeHighLightCursorline = 1
let NERDTreeIgnore = ['.vim$', '\~$', '.*\.pyc$',
			\ '.*.pid', 'db.db', '.*\.o$']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
let NERDTreeChDirMode = 2
let NERDTreeMapJumpFirstChild = 'gK'

" Plugins: Syntastic
" let g:syntastic_enable_signs = 1
" let g:syntastic_python_checkers=["flake8"]
" 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" Plugins: Ctrl-P
let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git$\|\.hg$',
    \ 'file': '\.so$\|\.pyc$\|\.DS_Store$'
    \ }

" ==============================================================================
" Disable annoyances
" ==============================================================================
set visualbell t_vb=                    " no visual bell
set novisualbell                        " no sound
