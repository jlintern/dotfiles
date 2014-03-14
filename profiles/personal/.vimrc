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

" removes "(A) " and inserts "x <current date>" at start of line -- for todo.txt
let @f = ':s/^(A) //eIx =strftime("%Y-%m-%d") '
" duplicates line, removes "(A) " and inserts "x <current date>" at start of line -- for todo.txt
let @d = 'yyP:s/^(A) //eIx =strftime("%Y-%m-%d") j'
" removes "x <current date>" and inserts "(A) " at start of line -- for todo.txt
let @a = ':s/^x ....-..-.. //eI(A) '
" removes "x <current date>" and "(A) " at start of line -- for todo.txt
let @r = ':s/^x ....-..-.. //e:s/^(A) //e'
" moves lines matching "x <date>" to top of file
let @s = ':v/^x ....-..-.. /normal ddGp'
