" Set leader key
let mapleader=","

" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Editor configs 
syntax on
set ruler
set number
set backspace=indent,eol,start
set visualbell
set encoding=utf-8
set clipboard=unnamed
set history=1000
set textwidth=120
set ttyfast

" TODO: Review below
set noexpandtab " insert tabs rather than spaces for <Tab>
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4 " the visible width of tabs
set softtabstop=4 " edit as if the tabs are 4 characters wide
set shiftwidth=4 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth'
set completeopt+=longest

" Colours
set t_Co=256
set background=dark

" Enable mouse support
if has('mouse')
    set mouse=a
    set ttymouse=xterm2
endif

" Plugins using vim-plug
call plug#begin('~/.vim/plugged')

Plug '907th/vim-auto-save'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf'
Plug 'tpope/vim-fugitive'
Plug 'tmsvg/pear-tree'

" Initialize plugin system
call plug#end()

" Airline
let g:airline_theme="minimalist"

" Autosave
let g:auto_save=1 

" NerdTree
nmap <silent> <leader>k :NERDTreeToggle<cr>
nmap <leader>f :NERDTreeFind<cr>

" Automatically close NerdTree if it's the last available window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Go syntax highlighting
set omnifunc=syntaxcomplete#Complete

let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

" Trigger intellisense on .
au filetype go inoremap <buffer> . .<C-x><C-o>
