" Important plugins and their usage
"
" Youcompleteme: use autocomplete directly
" NerdTree: For browsing directory structure: Use F5 for nerd tree to appear/disappear
" tagbar: For browsing variables/functions within current file: Use F8 to tagbar to appear disappear
" Ctrl+P: Use this for file search
"
" Use ctrl+w w for moving the control between nerdtree, current file and tagbar

set nocompatible              " be iMproved, required
filetype off                  " required

set ignorecase                " Ignore case when searching
set smartcase                 " Ignore 'ignorecase' if search has an uppercase.
" set the runtime path to include app-vim/* install directory, 
" and initualize vundle. Also add vim's directory for documentation in nvim.
set rtp=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after
set rtp+=/usr/share/vim/vimfiles,/usr/share/vim/vim81
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
call vundle#begin('$XDG_CONFIG_HOME/vim/bundle')

" Load Plugins
" (Commented plugins are already installed via package manager)
" For Gentoo I've also marked where certain ebuilds come from.

" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'    " in emerge (localrepo)

"" auto/tab complete for Vim
"Plugin 'Valloric/YouCompleteMe'  " in emerge (localrepo)
"" Syntax checker
"Plugin 'vim-syntastic/syntastic' " in emerge

"" Opens a web server in browser that auto refeshes as
"" you work on website files like html, javascript, and css.
Plugin 'turbio/bracey.vim'
"" codefmt needs maktaba, and glaive is needed
"" to configure codefmt.
Plugin 'google/vim-maktaba'
"" Code formater
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'

"Plugin 'airblade/vim-gitgutter'  " in emerge
"" File browser.
"Plugin 'scrooloose/nerdtree'     " in emerge
"" Statusbar theme
"Plugin 'vim-airline/vim-airline' " in emerge
"" Git integration.
"Plugin 'tpope/vim-fugitive'      " in emerge

"" Creates a powerline-style prompt using
"" airline's theme.
Plugin 'edkolev/promptline.vim'

"" Plugin that auto closes quotes, and others.
Plugin 'Raimondi/delimitMate'
Plugin 'alvan/vim-closetag'

"" Fuzzy file finder.
"Plugin 'ctrlpvim/ctrlp.vim'      " in emerge
"" Displays tags of the currnet file (like functions)
"Plugin 'majutsushi/tagbar'       " in emerge
"" Visualize indents
"Plugin 'Yggdroot/indentLine'     " in emerge (jorgicio)

"" Vim theme
Plugin 'morhetz/gruvbox'

" All of your Plugins must be added before the following line
call vundle#end()            " required
call glaive#Install()        " enable this line after the installation of glaive
filetype plugin indent on    " required

" custom global setting
set mouse=a                    " Mouse on all modes (Hold Shift to temp-disable)
set relativenumber             " Display line numbers relative to the cursor.
set number                     " Display the actual line number on the current line.
set showcmd                    " Show keypresses in normal-mode.
set encoding=utf-8             " Self-explainitory
set backspace=indent,eol,start " (:help 'backspace') for info.
set cursorline                 " Highlight current line.
set guioptions=                " Options for GUI Vim.
set scrolloff=3                " Show extra lines while scrolling.
syntax on                      " Colorize syntax.
" Display long lines on multiple terminal lines,
" but don't create real 'newlines' while typing.
set linebreak                  " When displaying long lines wrap at words.
set wrap                       " Display long lines on multiple lines.
set textwidth=0 wrapmargin=0   " Don't create newlines when typing long lines.
set updatetime=100             " Set time that vim writes to swap (also effects gitgutter)

" indent for global
set expandtab                  " Use spaces when tabbing.
set shiftwidth=4               " Number of spaces between each tab.
set softtabstop=4              " Simulate real tabs with spaces.
set autoindent                 " Copy previous intend when creating a newline.
set smarttab                   " Basically helps remove whitespace. 

""(Junk) management
" Prevent Creation of temp files.
set nobackup                    " Don't create a backup file.
set nowritebackup               " Don't make backup file before writing.
set noswapfile                  " Don't use a swapfile for the buffer.
" Create undo files in one directory.
set undodir=$XDG_CONFIG_HOME/vim/undo-dir " Force all undo cache into a directory.
set undofile                    " Create undofiles.
" Set view and viminnfo
set viewdir=$XDG_CONFIG_HOME/vim/view
if has('nvim')
    set viminfo+='1000,n$XDG_CONFIG_HOME/vim/viminfo
else
    set viminfo+='1000,n$XDG_CONFIG_HOME/vim/nviminfo
endif

" Auto change working directory to current file.
"" Currently disabled to allow be to easily run
"" :make while in a different directory within the same project.
"set autochdir

" Disable scrolloff inside terminal emulator. (Neovim)
if has('nvim')
    au BufEnter term://* startinsert
    au TermEnter * setlocal scrolloff=0
    au TermLeave * setlocal scrolloff=3
    tnoremap <Esc> <C-\><C-n>
    tnoremap <M-[> <Esc>
    tnoremap <C-v><Esc> <Esc>
endif

" When inside project with Makefile that has a run target
" Pressing F9 will build and run the project. (neovim)
if has ('nvim')
    map <F9> :w <CR> :make <CR> :edit term://make run <CR>
endif

" indent for special file
autocmd FileType c,cpp setlocal expandtab shiftwidth=2 softtabstop=2 cindent 
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 autoindent

" setup for ycm
"" Set 'ycm_global_ycm_extra_conf' to the correct location of '.ycm_extra_conf.py'
"" within <youcompleteme>/third_party/ycmd/examples.
let g:ycm_global_ycm_extra_conf = '/usr/share/vim/vimfiles/third_party/ycmd/examples/.ycm_extra_conf.py'
let g:ycm_python_binary_path = 'python'
let g:ycm_complete_in_comments = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_semantic_triggers =  {
  \ 'c' : ['re!\w{2}'],
  \ 'cpp' : ['re!\w{2}'],
  \ }

" setup for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']

" autoformat
augroup autoformat_settings
  autocmd FileType c,cpp,proto,java,javascript AutoFormatBuffer clang-format
  autocmd FileType python AutoFormatBuffer yapf
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
augroup END
" use google style for clang-format
Glaive codefmt clang_format_style='google'

" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

map <silent> <F5> : NERDTreeToggle<CR>

" closetag Setup
let g:closetag_filesnames = '*.html,*.xhtml,*.phtml,*.xml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.xml'
let g:closetag_filetypes = 'html,xhtml,phtml,xml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,xml'
let g:closetag_emptyTags_caseSenitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" setup for Bracey
"" Specify port, because by default there's a change that Bracey will pick
"" a port that will be bigger than 65545 which causes problems.
let g:bracey_server_port = 5454

" setup for delimitMate
let g:delimitMate_expand_cr = 1
" Prevent collision with closetag
au FileType html,xhtml,phtml,jsx,xml let b:delimitMate_matchpairs = "(:),[:],{:}"

" setup for gruvbox
set t_Co=256
set background=dark
colorscheme gruvbox
" let g:gruvbox_contrast_dark = 'soft'
" Disables background to allow for transparency.
hi Normal guibg=NONE ctermbg=NONE

" setup for ctrlp
"" We have a shit-ton of files set limit to unlimited.
let g:ctrlp_max_files = 0
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" setup for tagbar
nmap <F8> :TagbarToggle<CR>

" setup for indent line
let g:indentLine_char = '│'
set tags=./tags,tags;$HOME

" Promptline
let g:promptline_preset = {
  \'a' : [ '$vim_mode', promptline#slices#host() ],
  \'b' : [ promptline#slices#user() ],
  \'c' : [ promptline#slices#cwd() ],
  \'y' : [ promptline#slices#vcs_branch(), promptline#slices#git_status(), promptline#slices#jobs() ],
  \'warn' : [ promptline#slices#last_exit_code() ]}
