" set leader key
let g:mapleader = "\<Space>"

syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler          			            " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set softtabstop=2                       " Simulate real tabs with spaces.
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=0                        " Always display the status line
set number                              " Line numbers
set relativenumber                      " Display line numbers relative to the cursor.
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
"set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set noswapfile                          " Don't use a swapfile for the buffer.
set undofile                            " Enable undo cache.
set undodir=$XDG_CONFIG_HOME/vim/undo-dir
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
set showcmd                             " Show keypresses in normal-mode.
set backspace=indent,eol,start          " (:help 'backspace') for info.
set scrolloff=3                         " Show extra lines while scrolling.
set linebreak                           " When displaying long lines wrap at words.
set wrap                                " Display long lines on multiple lines.
set textwidth=0 wrapmargin=0            " Don't create newlines when typing long lines.
set ignorecase                          " Ignore case when searching
set smartcase                           " Ignore 'ignorecase' if search has an uppercase.
"set autochdir                           " Your working directory will always be the same as your working directory

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC

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
