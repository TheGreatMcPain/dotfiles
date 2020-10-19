let g:delimitMate_expand_cr = 1
" Prevent collision with CloseTag
au FileType html,xhtml,phtml,jsx,xml let b:delimitMate_matchpairs = "(:),[:],{:}"
