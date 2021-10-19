" This file is for scmindent which is not a vim plugin,
" but it is used to help with indentation for lisp

autocmd filetype lisp,scheme,racket setlocal equalprg=scmindent.rkt
