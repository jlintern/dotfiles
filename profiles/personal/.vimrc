set nocompatible
set backspace=2

set shiftwidth=2
set tabstop=2
set expandtab
set smarttab
set autoindent

set ignorecase

set shortmess=filnxtToOI
syntax on

nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv
