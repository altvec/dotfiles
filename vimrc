set shell=/bin/bash\ --login

filetype off

" Pathongen exec
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

" =============================================================================
" Basic settings
" =============================================================================
set nocompatible                        " disable compatibility with old VI

set modelines=0
set autoindent
set ruler
set showmode
set showcmd
set nobackup                            " no backup files
set nowritebackup                       " no backup while editing file
set noswapfile                          " no swap files (it's almost 2015!)
set t_Co=256                            " 256 colors
set cursorline                          " highlight cursor line
set hidden
set ttyfast
set relativenumber
"set undofile
set title
set lazyredraw
set matchtime=3
set laststatus=2
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set linebreak

" Better completion
set complete=.,w,b,u,t
set completeopt=longest,menuone

let mapleader = ","                     " change leader from \ to ,
let maplocalleader = "\\"

set textwidth=79                        " old standart :)
set autoread                            " reload files if they changed on disk

set backspace=indent,eol,start
set list
set listchars=tab:•\ ,eol:¬,extends:»,precedes:«
set showbreak=↪

" Habit breaking, habit making
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
nmap j gj
nmap k gk

" Quick buffer switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move between the buffers
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" Split management
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>W <C-w>s
nnoremap <leader>s :new<CR>

" Quit window on <leader>q
nnoremap <leader>q :q<CR>
nnoremap K :q<CR>

" Save
nnoremap s :w<CR>

" Toggle line numbers
nnoremap <leader>n :setlocal number!<CR>

" Sort lines
"nnoremap <leader>s vip:!sort -f<CR>
"nnoremap <leader>s :!sort -f<CR>

" Tabs
nnoremap <leader>( :tabprev<CR>
nnoremap <leader>) :tabnext<CR>

" Replace / substitute
nnoremap <c-s> :%s/
vnoremap <c-s> :s/

" Window resizing
nnoremap <m-right> :vertical resize +3<CR>
nnoremap <m-left> :vertical resize -3<CR>
nnoremap <m-up> :resize +3<CR>
nnoremap <m-down> :resize -3<CR>

" set working dir
nnoremap <leader>. :lcd %p:h<CR>

" ==============================================================================
" Folding
" ==============================================================================
set foldlevelstart=0
" space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

" Make z0 recursively open whatever fold we're in, even if it's partially open.
nnoremap z0 zcz0

" ==============================================================================
" GUI settings
" ==============================================================================
set ls=2                                " always show statusbar
set enc=utf-8                           " UTF-8 as default encoding
set colorcolumn=85
set formatoptions=qrn1

if has("mac")
    set guifont=Fira\ Mono\ for\ Powerline:h14
else
    set mouse=a
endif

syntax on
set background=dark
colorscheme goodwolf
let g:badwolf_tabline = 2
let g:badwolf_html_link_underline = 0

" ==============================================================================
" Lightline
" ==============================================================================
" Lightline
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ }
function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction
function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction
function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

" Update and show lightline but only if it's visible (e.g., not in Goyo)
autocmd User ALELint call s:MaybeUpdateLightline()
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" ==============================================================================
" Git stuff
" ==============================================================================
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

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

" --- C ---
augroup ft_c
    au!
    au FileType c setlocal foldmethod=marker foldmarker={,}
    au FileType c setlocal ts=8 sts=8 sw=8 noexpandtab
augroup END

" --- C++ ---
augroup ft_cpp
    au!
    au FileType cpp setlocal foldmethod=marker foldmarker={,}
    au FileType cpp setlocal ts=8 sts=8 sw=8 noexpandtab
augroup END

" --- C# ---
augroup ft_csharp
    au!
    au FileType cs setlocal foldmethod=marker foldmarker={,}
    au FileType cs setlocal ts=4 sts=4 sw=4 expandtab
augroup END

" --- Python ---
autocmd FileType python setlocal expandtab
    \ shiftwidth=4 tabstop=8 softtabstop=4
    \ formatoptions+=croq smartindent
    \ cinwords=if,elif,else,for,while,try,exce,pt,finally,def,class,with

augroup ft_python
    au!
    au FileType python setlocal define=\^s*\\(def\\\\|class\\)
augroup END

" --- Ruby ---
autocmd BufNewFile,BufRead {Gemfile,Rakefile,Vagrantfile,config.ru} set ft=ruby
autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

" --- Rust ---
autocmd BufNewFile,BufRead *.rs setlocal ft=rust

" --- JSON ---
autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" --- YAML ---
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2
autocmd BufNewFile,BufRead *.sls setlocal ft=yaml

" --- Javascript ---
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal commentstring=//\ %s

" --- Template Languages ---
autocmd FileType html,xhtml,xml,htmldjando,htmljinja,eruby,mako
    \ setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufNewFile,BufRead *.rthml setlocal ft=eruby
autocmd BufNewFile,BufRead *.tmpl setlocal ft=htmljinja
autocmd BufNewFile,BufRead *.py_tmpl setlocal ft=python

" --- CSS ---
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType css setlocal commentstring=/*\ %s\ */

" --- Sass ---
autocmd FileType scss setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2

" --- Puppet ---
autocmd BufRead,BufNewFile *.pp set ft=puppet

" --- Go ---
autocmd FileType go setlocal shiftwidth=4 tabstop=8 softtabstop=4 expandtab
autocmd BufNewFile,BufRead *.go setlocal ft=go

" --- Erlang ---
autocmd FileType erlang setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2
autocmd BufNewFile,BufRead rebar.config setlocal ft=erlang

" --- Common Lisp ---
augroup ft_commonlisp
    au!
    au BufNewFile,BufRead *.asd,*.ros set filetype=lisp
    au BufNewFile,BufRead *.paren set filetype=lisp
    au BufNewFile,BufRead .abclrc set filetype=lisp
augroup END

" --- cmake ---
autocmd BufNewFile,BufRead CMakeLists.txt setlocal ft=cmake

" --- VIML ---
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker keywordprg:help
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

" ==============================================================================
" Completion
" ==============================================================================

" use deoplete for Neovim
if has('nvim')
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#ignore_sources = {}
    let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file']
endif

" ==============================================================================
" Plugins
" ==============================================================================

" Plugins: NERDTree
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

let NERDTreeHighLightCursorline = 1
let NERDTreeIgnore = ['.vim$','\~$','.*\.pyc$','.*.pid','db.db','.*\.o$','.DS_Store']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
let NERDTreeChDirMode = 2
let NERDTreeMapJumpFirstChild = 'gK'


" Plugins: Ctrl-P
let g:ctrlp_map = '<leader>o'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window = 'bottom,order:top,min:1,max:20'
let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git$\|\.hg$',
    \ 'file': '\.so$\|\.pyc$\|\.DS_Store$'
    \ }


" Plugins: tslime2
let g:tslime2_ensure_trailing_newlines = 1
let g:tslime_normal_mapping = '<localleader>T'
let g:tslime_visual_mapping = '<localleader>t'
let g:tslime_vars_mapping = '<localleader>t'


" Plugins: pymode
let g:pymode_rope = 0

"let g:pymode_doc = 1
"let g:pymode_doc_key = 'M'
"let g:pydoc = 'pydoc'
let g:pymode_lint = 0
let g:pymode_python = 'python'
"let g:pymode_lint_checker = "pyflakes,pep8"
"let g:pymode_virtualenv = 0
"let g:pymode_syntax = 1
"let g:pymode_syntax_all = 0
"let g:pymode_syntax_builtin_objs = 1
"let g:pymode_syntax_print_as_function = 0
"let g:pymode_syntax_space_errors = 0
"let g:pymode_run = 0
"let g:pymode_breakpoint = 0
"let g:pymode_utils_whitespaces = 0
"let g:pymode_folding = 0


" Plugins: ALE
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSugn Title


" Plugins: fzf
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>a :Ag<CR>

" Tell ack.vim to use ag (The Silver Searcher) instead
let g:ackprg = 'ag --vimgrep'

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \       execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Comments

nmap <leader>c <Plug>CommentaryLine
xmap <leader>c <Plug>Commentary

augroup plugin_commentary
    au!
    au FileType htmldjango setlocal commentstring={#\ %s\ #}
    au FileType clojurescript setlocal commentstring=;\ %s
    au FileType lisp setlocal commentstring=;\ %s
    au FileType puppet setlocal commentstring=#\ %s
    au FileType fish setlocal commentstring=#\ %s
    au FileType gnuplot setlocal commentstring=#\ %s
    au FileType cs setlocal commentstring=//\ %s
augroup END

" ==============================================================================
" NEOVIM
" ==============================================================================
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" ==============================================================================
" Disable annoyances
" ==============================================================================
set visualbell t_vb=                    " no visual bell
set novisualbell                        " no sound

" Quick editing
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>et :vsplit ~/.tmux.conf<CR>
nnoremap <leader>ez :vsplit ~/.zshrc<CR>
nnoremap <leader>ef :vsplit ~/.config/fish/config.fish<CR>


" ALE load all plugins
packloadall
silent! helptags ALL
