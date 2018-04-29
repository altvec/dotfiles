" Modeline and notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmarker=marker

" Basics {
    set nocompatible                    " disable compatibility with old VI
    set shell=/bin/bash\ --login        " set shell
    filetype off
" }

" Pathongen exec {
    call pathogen#infect()
    call pathogen#helptags()
    filetype plugin indent on
" }

" =============================================================================
" Basic settings
" =============================================================================

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
set background=light
colorscheme Papercolor

" ==============================================================================
" Lightline
" ==============================================================================
let g:lightline = {
\ 'colorscheme': 'PaperColor',
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

" --- Markdown ---
autocmd FileType markdown setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
" Markdown could be more fruit salady
highlight link markdownH1 PreProc
highlight link markdownH2 PreProc
highlight link markdownLink Character
highlight link markdownBold String
highlight link markdownItalic Statement
highlight link markdownCode Delimiter
highlight link markdownCodeBlock Delimiter
highlight link markdownListMarker Todo

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
autocmd FileType go setlocal shiftwidth=4 tabstop=4 noexpandtab
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
    let g:deoplete#sources#jedi#python_path = '/usr/local/bin/python3'
endif

" ==============================================================================
" Plugins
" ==============================================================================

" Plugins: NERDTree
function! NERDTreeInitAsNeeded()
    redir => bufoutput
    buffers!
    redir END
    let idx = stridx(bufoutput, "NERD_tree")
    if idx > -1
        NERDTreeMirror
        NERDTreeFind
        wincmd l
    endif
endfunction

if isdirectory(expand("~/.vim/bundle/nerdtree"))
    let g:NERDShutUp=1
    let NERDTreeShowBookmarks=1
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0
    let NERDTreeIgnore = ['^\.git$', '\~$', '\.py[cdo]$', '^\.DS_Store$']
    
    nnoremap <leader>e :NERDTree<CR>
    nnoremap <leader>f :NERDTreeFind<CR>
endif

" Plugins: vim-go
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_options = {
    \ 'goimports': '-local do/',
    \ }
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 0
let g:go_auto_sameids = 0
let g:go_def_mode = "guru"
let g:go_echo_command_info = 1
let g:go_autodetect_gopath = 1

" Plugins: Ctrl-P
let g:ctrlp_map = '<leader>o'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window = 'bottom,order:top,min:1,max:20'
let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git$\|\.hg$',
    \ 'file': '\.so$\|\.pyc$\|\.DS_Store$'
    \ }

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
let g:python3_host_prog = '/usr/local/bin/python3'
"let g:python2_host_prog = '/usr/loca/bin/python'
let g:jedi#force_py_version = 3

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
