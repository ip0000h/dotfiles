set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/

call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'mattn/emmet-vim'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'walm/jshint.vim'
Plugin 'moll/vim-node'
Plugin 'airblade/vim-gitgutter'
Plugin 'Yggdroot/indentLine'
Plugin 'nvie/vim-flake8'
Plugin 'davidhalter/jedi-vim'
Plugin 'axiaoxin/favorite-vim-colorscheme'
Plugin 'mhinz/vim-startify'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'suan/vim-instant-markdown'
Plugin 'tpope/vim-surround'
Plugin 'honza/vim-snippets'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'

call vundle#end()

filetype on
filetype plugin on
filetype plugin indent on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set nobackup
set noswapfile

set encoding=utf-8

syntax enable
syntax on

set autoread

set ignorecase

set smartcase

colorscheme Tomorrow-Night-Bright

set showcmd

set showmatch

set autowrite

set smarttab

set autoindent
set smartindent

set expandtab
set tabstop=4
set shiftwidth=4
set shiftround

" F2
nnoremap <F2> :set nonu!<CR>:set foldcolumn=0<CR>

" F3
nmap <silent> <F3> :NERDTreeToggle<CR>

" F4 TagList
nmap <silent> <F4> :TagbarToggle<CR>

" F5
if exists("$VIRTUAL_ENV")
    autocmd FileType python map <buffer> <F5> :!$VIRTUAL_ENV'/bin/python' %<CR>
else
    autocmd FileType python map <buffer> <F5> :!python %<CR>
endif

" <F6>
map <F6> <Esc>:tabnew<CR>

" <F7>
set pastetoggle=<F7>

" <F8> sort import and auto pep8
autocmd FileType python map <buffer> <F8> :!autopep8 -i -a --ignore=W690,E501 %;isort %;<CR><CR>

" <F9> pep8 by yapf
autocmd FileType python map <buffer> <F9> :!yapf -i % --style=pep8;isort %;<CR><CR>

" NerdCommenter
let g:NERDSpaceDelims=1

let NERDTreeIgnore=['\.pyc$', '\~$']

" CtrlP
let g:ctrlp_show_hidden = 1
let g:ctrlp_cmd = 'CtrlPMixed'

" instant-markdown
let g:instant_markdown_slow = 1

" airline
let g:airline_section_y = '%{strftime("%H:%M")}'
" tabline
let g:airline#extensions#tabline#enabled = 1
" tabline buffer
let g:airline#extensions#tabline#left_sep = ' '
" tabline buffer
let g:airline#extensions#tabline#left_alt_sep = '|'
" tabline buffer
let g:airline#extensions#tabline#buffer_nr_show = 1

" jedi
autocmd FileType python setlocal completeopt-=preview
let g:jedi#completions_command = "<C-n>"

" flake8
let g:flake8_show_in_file = 1
let g:flake8_show_in_gutter = 1
autocmd! BufRead,BufWritePost *.py call Flake8()

" gitgutter
let g:gitgutter_sign_modified = '*'
let g:gitgutter_sign_removed = '-'

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" jshint
autocmd! BufRead,BufWritePost *.js :JSHint

" vim-table-mode: markdown
let g:table_mode_corner="|"
