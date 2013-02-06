set ts=4
set sw=4
syntax on
set nocompatible
set backspace=2
set number
autocmd BufRead *.f90 set expandtab
autocmd BufRead *.py  set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class 
autocmd BufRead *.py  set ai
autocmd BufRead *.tex set tw=80
autocmd BufRead,BufNewFile *.pyt set filetype=html
set backup " make backup files
set backupdir=~/.vim/backup " where to put backup files
set background=dark
