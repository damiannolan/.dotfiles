"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath^=~/.vim/bundle/ctrlp.vim

" load plugins from vundle
source ~/.vim/plugins.vim

" Abbreviations
abbr funciton function
abbr teh the
abbr tempalte template

set nocompatible " not compatible with vi
set autoread " detect when a file is changed

" make backspace behave in a sane manner
set backspace=indent,eol,start

"set nobackup
"set nowritebackup
set noswapfile
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" set a map leader for more key combos
let mapleader = ','
let g:mapleader = ','

set history=1000 " change history to 1000
set textwidth=120

" Tab control
set noexpandtab " insert tabs rather than spaces for <Tab>
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4 " the visible width of tabs
set softtabstop=4 " edit as if the tabs are 4 characters wide
set shiftwidth=4 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth'
set completeopt+=longest

if has('mouse')
    set mouse=a
    set ttymouse=xterm2
endif

set clipboard=unnamed

" faster redrawing
set ttyfast

" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" highlight syntax
syntax on
set ruler
set number
let g:jsx_ext_required = 0

" Beautify
"map <leader>b :call JsBeautify()<cr>
map <leader>b :Autoformat<cr>
"noremap <F3> :Autoformat<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" re ap esc
inoremap jk <esc>
" set paste toggle
set pastetoggle=<F6>
" toggle paste moe
map <leader>v :set paste!<cr>

" Utilities
map <F7> mzgg=G`z
" Colour Schemes
set background=dark
"set background=light
set encoding=utf8
"let base16colorspace=256  " Access colors present in 256 colorspace"
set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors"

"let g:solarized_bold = 1
"let g:solarized_underline = 1
"let g:solarized_italic = 1
"let g:solarized_visiblility = "high"
"let g:solarized_contrast = "high"
colorscheme base16-default-dark
"colorscheme base16-default-dark
"colorscheme solarized
colorscheme sierra

"Utilities
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
"let g:auto_save_postsave_hook = 'TagsGenerate'  " this will run :TagsGenerate after each save

"NerdTree
nmap <silent> <leader>k :NERDTreeToggle<cr>
nmap <leader>f :NERDTreeFind<cr>

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" map fuzzyfinder (CtrlP)  plugin
let g:ctrlp_map='<leader>t'
let g:ctrlp_dotfiles=1
let g:ctrlp_working_path_mode = 'ra'

" The Silver Searcher
set grepprg=ag\ --nogroup\ --nocolor

" bind K to grep word under cursor
nnoremap K :grep! '\b<C-R><C-W>\b'<CR>:cw<CR>

" bind ,space  to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap <leader><SPACE> :Ag<SPACE>
