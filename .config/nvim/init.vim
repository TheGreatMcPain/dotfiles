" Notable plugins and their usage
"
" YouCompleteMe: use autocomplete directly
"
" NerdTree: For browsing directory structure: Use F5 for nerd tree to appear/disappear
"
" TagBar: For browsing variables/functions within current file: Use F8 to
"         tagbar to appear disappear
"
" CtrlP: Use ctrl+p for fuzzy file search
"
" Use Ctrl+w to move between windows

""" INITALIZATION SECTION

set nocompatible            " be iMproved
filetype off                " Vundle requires that filetype detection be off

" Include '/usr/share/vim/vimfiles' and '/usr/share/vim/vim81' in vim's
" runtime path.
"
" This will allow NeoVim to load plugins installed by 'emerge', because
" the app-vim/* ebuilds are not 'NeoVim aware' yet.
set rtp=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after
set rtp+=/usr/share/vim/vimfiles,/usr/share/vim/vim81

"" Install Plugins via 'Vundle' into the '.config/vim/bundle' directory.
call vundle#begin('$XDG_CONFIG_HOME/vim/bundle')

"" List of plugins installed by 'emerge'.

" Installed by 'app-vim/vundle' from 'thegreatmcpain' overlay.
"Plugin 'VundleVim/Vundle.vim'      " Plugin Manager

" Installed by 'app-vim/youcompleteme' from 'thegreatmcpain' overlay.
"Plugin 'ycm-core/YouCompleteMe'    " auto/tab complete for Vim

" Installed by 'app-vim/syntastic' from 'gentoo' overlay.
"Plugin 'vim-syntastic/syntastic'   " Syntax checker

" Installed by 'app-vim/gitgutter' from 'gentoo' overlay.
"Plugin 'airblade/vim-gitgutter'    " Show diff symbols from version control

" Installed by 'app-vim/nerdtree' from 'gentoo' overlay.
"Plugin 'scrooloose/nerdtree'       " File browser

" Installed by 'app-vim/airline' from 'gentoo' overlay.
"Plugin 'vim-airline/vim-airline'   " Status bar

" Installed by 'app-vim/fugitive' from 'gentoo' overlay.
"Plugin 'tpope/vim-fugitive'        " Git integration

" Installed by 'app-vim/ctrlp' from 'gentoo' overlay.
"Plugin 'ctrlpvim/ctrlp.vim'        " Fuzzy file finder

" Installed by 'app-vim/tagbar' from 'gentoo' overlay.
"Plugin 'majutsushi/tagbar'         " Displays function names using ctags

"" Plugins managed by Vundle.

Plugin 'google/vim-codefmt'         " Code formatter
Plugin 'google/vim-glaive'          " Used to configure Codefmt
Plugin 'google/vim-maktaba'         " Codefmt requires this

Plugin 'Raimondi/delimitMate'       " Auto close quotes
Plugin 'alvan/vim-closetag'         " Auto close tags in xml, html, etc.

Plugin 'Yggdroot/indentLine'        " Visualize indents

Plugin 'turbio/bracey.vim'          " Live preview of your website while you edit it

Plugin 'morhetz/gruvbox'            " Theme for Vim

Plugin 'edkolev/promptline.vim'     " Creates a powerline style prompt using the statusbar

"" Plugin's go before this line
call vundle#end()           " Stop vundle
call glaive#Install()       " Uncomment this line only after 'glaive' is installed
filetype plugin indent on   " Re-enable filetype detection

""" CONFIGURATION SECTION

"" 'Junk' management

" Prevent creation of temp files.
set nobackup                " Don't create a backup file
set nowritebackup           " Don't make a backup file before writing.
set noswapfile              " Don't use a swapfile for the buffer.

" Create 'undo' cache in '.config/vim/undo-dir'
set undodir=$XDG_CONFIG_HOME/vim/undo-dir
set undofile                " Enable undo cache.

" Set view and viminfo locations to '.config/vim'
set viewdir=$XDG_CONFIG_HOME/vim/view
" NeoVim's viminfo and Vim's viminfo are different
if has('nvim')
    set viminfo+='1000,n$XDG_CONFIG_HOME/vim/nviminfo
else
    set viminfo+='1000,n$XDG_CONFIG_HOME/vim/viminfo
endif

"" Custom Global Settings

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

" Global indent settings
set expandtab                  " Use spaces when tabbing.
set shiftwidth=4               " Number of spaces between each tab.
set softtabstop=4              " Simulate real tabs with spaces.
set autoindent                 " Copy previous intend when creating a newline.
set smarttab                   " Basically helps remove whitespace.

" Search Settings
set ignorecase                 " Ignore case when searching
set smartcase                  " Ignore 'ignorecase' if search has an uppercase.

" Misc Settings
set updatetime=100             " Set time that vim writes to swap (effects gitgutter)
"set autochdir                 " Auto change working directory to current

" NeoVim's terminal emulator Settings.
if has('nvim')
    " Disable scrolloff while inside terminal
    au BufEnter term://* startinsert
    au TermEnter * setlocal scrolloff=0
    au TermLeave * setlocal scrolloff=3

    " Custom mappings for terminal
    tnoremap <Esc> <C-\><C-n>
    tnoremap <M-[> <Esc>
    tnoremap <C-v><Esc> <Esc>
endif

" Indent settings for special files.
autocmd FileType c,cpp setlocal expandtab shiftwidth=2 softtabstop=2 cindent
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 autoindent

""" PLUGIN CONFIGURATION SECTION

"" Setup for YouCompleteMe
" Set location of '.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf = '/usr/share/vim/vimfiles/third_party/ycmd/examples/.ycm_extra_conf.py'
let g:ycm_use_clangd = 1
let g:ycm_clangd_binary_path = 'clangd'
let g:ycm_python_binary_path = 'python'
let g:ycm_complete_in_comments = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_semantic_triggers =  {
  \ 'c' : ['re!\w{2}'],
  \ 'cpp' : ['re!\w{2}'],
  \ }

"" Setup for Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']

"" Setup Autoformatter
augroup autoformat_settings
  autocmd FileType c,cpp,proto,java,javascript AutoFormatBuffer clang-format
  autocmd FileType python AutoFormatBuffer yapf
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
augroup END
" Use style specified by '.clang-format' file
Glaive codefmt clang_format_style='file'

"" NerdTree Setup
" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Toggle NerdTree with F5
map <silent> <F5> : NERDTreeToggle<CR>

"" CloseTag Setup
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

"" Setup Bracey
let g:bracey_server_port = 5454

"" Setup delimitMate
let g:delimitMate_expand_cr = 1
" Prevent collision with CloseTag
au FileType html,xhtml,phtml,jsx,xml let b:delimitMate_matchpairs = "(:),[:],{:}"

"" Setup Ctrlp
let g:ctrlp_max_files = 0       " Unlimited files
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

"" TagBar Setup
nmap <F8> :TagbarToggle<CR>

"" IndentLine Setup
let g:indentLine_char = '|'
autocmd FileType json IndentLinesDisable     " indentLine hides quotes on json

set tags=./tags,tags;$HOME

"" Gruvbox Setup
set t_Co=256
set background=dark
colorscheme gruvbox
" let g:gruvbox_contrast_dark = 'soft'
" Disables background to allow for transparency.
hi Normal guibg=NONE ctermbg=NONE

"" PromptLine Setup
let g:promptline_preset = {
  \'a' : [ '$vim_mode', promptline#slices#host() ],
  \'b' : [ promptline#slices#user() ],
  \'c' : [ promptline#slices#cwd() ],
  \'y' : [ promptline#slices#vcs_branch(), promptline#slices#jobs() ],
  \'warn' : [ promptline#slices#last_exit_code() ]}
