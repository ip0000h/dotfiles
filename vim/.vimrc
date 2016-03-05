set nocompatible
filetype off
set backupdir=~/tmp

" Vundle Options
let g:vundle_default_git_proto = 'git'

" NedTree Options
let g:nerdtree_tabs_open_on_console_startup = 1

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'vim-scripts/ragtag.vim'

" Color and theme plugins
" original repo
Bundle 'altercation/vim-colors-solarized'
" with extension
Bundle 'nelstrom/vim-mac-classic-theme.git'
" theme
Plugin 'molokai'

" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'

" NerdTree plugin
Plugin 'https://github.com/scrooloose/nerdtree.git'

" Panels(Tabs) for NerdTree
Bundle 'jistr/vim-nerdtree-tabs'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

call vundle#end()
filetype plugin indent on
call s:LoadPlugin()
