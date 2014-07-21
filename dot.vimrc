syntax on
set autoindent 
"set number 
set incsearch 
set ignorecase 
set nohlsearch 
set showmatch 
set showmode 
set backspace=2 
set title 
set ruler 
set tabstop=2
set shiftwidth=2
set expandtab 
set hidden
set smartcase
"set ambiwidth=double
set encoding=utf-8

" mouse control
set mouse=a
" for screen
set ttymouse=xterm2
" change directory when opens files
"set autochdir

" for autocmd FileType ...
filetype plugin on

noremap ; :
noremap : ;
inoremap ; :
inoremap : ;

nnoremap <C-N>   :bnext<CR>
nnoremap <C-P>   :bprevious<CR>
nnoremap <C-T>   :TSelectBuffer<CR>
"nnoremap <C-N>   :tabnext<CR>
"nnoremap <C-P>   :tabprevious<CR>
"nnoremap <C-T>   :tabnew<Space>

"autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
"autocmd BufRead *.py set softtabstop=2
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl softtabstop=2
set smarttab


autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType python setlocal omnifunc=pysmell#Complete
"autocmd FileType python imap <silent> <buffer> <C-i> <C-X><C-O>

noremap  <BS>
noremap!  <BS>
