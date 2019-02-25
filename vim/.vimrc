" Personal vim configuration file
" Created by Andrew Roberts, 2017
" Last updated: December 29, 2018


" Pathogen ------------------------------------------{{{
set nocompatible
filetype off
execute pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on
" }}}

" UI Settings ------------------------------------------{{{
set number						    " show line numbers
set relativenumber				    " show line numbers relative to cursor
set showcmd                         " show command in bottom bar
set cursorline                      " highlight current line
set scrolloff=999
set wildmenu                        " visual autocomplete for command menu
set numberwidth=8				    " width of line number column
set shiftround
set shiftwidth=4
set tabstop=4					    " number of visual spaces per tab
set softtabstop=4				    " number of spaces in tab when editing
set expandtab					    " tabs are spaces
set showmatch                       " show matching brackets
set matchtime=3					    " matching bracket display time
set autoindent					    " autoindent
set lazyredraw					    " redraw only when necessary
syntax enable					    " turn on syntax highlighting
set background=dark                 " background setting
set tabpagemax=100                  " maximum open tabs
let g:solarized_termcolors=256	    " termcolors for solarized 
let g:tex_flavor='latex'            " prefer LaTeX as default tex file
colorscheme gruvbox                 " flavor of the month
set colorcolumn=81                  " prefer 80 character line limit
highlight ColorColumn ctermbg=5

" set termcolors to 256
" See vim.wikia.com/wiki/256_colors_in_vim for more info
set t_Co=256
" }}}

" Status Line -----------------------------------------------------{{{
set encoding=utf-8
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
" }}}

" Control settings --------------------------------------{{{
set backspace=2					        " backspace works as normal
set viminfo+=n~/dotfiles/vim/.viminfo   " put .viminfo file in dotfiles directory
" }}}

" Key mappings --------------------------------------{{{
:let mapleader = "-"
:let maplocalleader = "\\"
:noremap <leader>- ddp
:noremap <leader>_ ddkkp
:inoremap <c-u> <esc>bvwU<esc>i
:nnoremap <c-u> bvwU<esc>
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>
:inoremap jk <esc>
:inoremap JK <esc>
:inoremap <esc> <nop>
:nnoremap <Up> <nop>
:nnoremap <Down> <nop>
:nnoremap <Left> <nop>
:nnoremap <Right> <nop>
:inoremap <Up> <nop>
:inoremap <Down> <nop>
:inoremap <Left> <nop>
:inoremap <Right> <nop>
:nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
:nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
:nnoremap <leader>[ :tabprevious<cr>
:nnoremap <leader>] :tabnext<cr>
:nnoremap <leader>{ :tabfirst<cr>
:nnoremap <leader>} :tablast<cr>
:nnoremap <leader><Tab> :normal gg=G<cr>
:nnoremap <C-j> <C-W>j
:nnoremap <C-k> <C-W>k
:nnoremap <C-h> <C-W>h
:nnoremap <C-l> <C-W>l
" }}}

" Autocommands --------------------------------------{{{
" Allow code folding in this vim file
augroup filetype_vim
    autocmd!
    autocmd Filetype vim setlocal foldmethod=marker
augroup END

" Quick comment commands based on programming language of file
augroup comments
    autocmd!
    autocmd FileType c          nnoremap <buffer> <localleader>c I/* <esc>A */<esc>
    autocmd FileType cpp        nnoremap <buffer> <localleader>c I// <esc>
    autocmd FileType javascript nnoremap <buffer> <localleader>c I// <esc>
    autocmd FileType python     nnoremap <buffer> <localleader>c I# <esc>
augroup END

" Set specific file types to not wrap their text
augroup wrappers
    autocmd!
    autocmd BufNewFile,BufRead *.html setlocal nowrap
    autocmd BufNewFile,BufRead *.tex setlocal nowrap
    autocmd BufNewFile,BufRead *.vim setlocal nowrap
augroup END

" Change tab/indent sizes based on filetype
augroup indentation
    autocmd!
    autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd Filetype ruby setlocal ts=2 sts=2 sw=2 expandtab
    autocmd Filetype cpp setlocal ts=2 sts=2 sw=2 expandtab
    autocmd Filetype make setlocal noexpandtab
augroup END

" Set color column ruler on file type
augroup limits
    autocmd!
    autocmd Filetype python setlocal colorcolumn=80
    autocmd Filetype html,tex,latex,markdown,text setlocal colorcolumn=101
augroup END

augroup widths
    autocmd!
    autocmd Filetype text setlocal textwidth=100
augroup END
" }}}

" Functions -----------------------------{{{
" Show highlighting groups for current word
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 
                \       'synIDattr(v:val, "name")')
endfunc
" }}}

" Backups -------------------------------------------------------{{{
if has ("vms")
    set nobackup        " do not keep a backup file, use versions instead
else
    set backup          " keep a backup file (restore to previous version)
    if has ('persistent_undo')
        set undofile    " keep an undo file (undo changes after closing)
    endif
endif
" }}}

" Fix paste bug triggered by the above inoremaps
set t_BE=
