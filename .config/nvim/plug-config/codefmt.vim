augroup autoformat_settings
  autocmd FileType c,cpp,proto,java,javascript AutoFormatBuffer clang-format
  autocmd FileType python AutoFormatBuffer yapf
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
augroup END
" Use style specified by '.clang-format' file
Glaive codefmt clang_format_style='file'
