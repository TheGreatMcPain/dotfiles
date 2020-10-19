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
set shiftwidth=2               " Number of spaces between each tab.
set softtabstop=2              " Simulate real tabs with spaces.
set autoindent                 " Copy previous intend when creating a newline.
set smartindent                " Make indenting smart
set smarttab                   " Basically helps remove whitespace.

" Search Settings
set ignorecase                 " Ignore case when searching
set smartcase                  " Ignore 'ignorecase' if search has an uppercase.

" Misc Settings
set updatetime=100             " Set time that vim writes to swap (effects gitgutter)
"set autochdir                 " Auto change working directory to current
set tags=./tags,tags;$HOME

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
