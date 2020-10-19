" Include '/usr/share/vim/vimfiles' and '/usr/share/vim/vim81' in vim's
" runtime path.
"
" This will allow NeoVim to load plugins installed by 'emerge', because
" the app-vim/* ebuilds are not 'NeoVim aware' yet.
set rtp=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after
set rtp+=/usr/share/vim/vimfiles,/usr/share/vim/vim81

"" Install Plugins via 'vim-plug' into the '.config/nvim/autoload/plugged' directory.
call plug#begin('~/.config/nvim/autoload/plugged')

"" List of plugins installed by 'emerge'.

" Installed by 'app-vim/gitgutter' from 'gentoo' overlay.
"Plug 'airblade/vim-gitgutter'    " Show diff symbols from version control

" Installed by 'app-vim/nerdtree' from 'gentoo' overlay.
"Plug 'scrooloose/nerdtree'       " File browser

" Installed by 'app-vim/airline' from 'gentoo' overlay.
"Plug 'vim-airline/vim-airline'   " Status bar

" Installed by 'app-vim/fugitive' from 'gentoo' overlay.
"Plug 'tpope/vim-fugitive'        " Git integration

" Installed by 'app-vim/ctrlp' from 'gentoo' overlay.
"Plug 'ctrlpvim/ctrlp.vim'        " Fuzzy file finder

" Installed by 'app-vim/tagbar' from 'gentoo' overlay.
"Plug 'majutsushi/tagbar'         " Displays function names using ctags

"" Plugins managed by vim-plug.
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " VSCode like extensions for NeoVim
Plug 'jackguo380/vim-lsp-cxx-highlight'                 " clangd based syntax highlighting for c-family languages
Plug 'igankevich/mesonic'                               " meson buildsystem integration
Plug 'Raimondi/delimitMate'                             " Auto close quotes
Plug 'alvan/vim-closetag'                               " Auto close tags in xml, html, etc.
Plug 'Yggdroot/indentLine'                              " Visualize indents
Plug 'turbio/bracey.vim'                                " Live preview of your website while you edit it
Plug 'morhetz/gruvbox'                                  " Theme for Vim

"" Plugin's go before this line
call plug#end()           " Stop vim-plug
