" Include '/usr/share/vim/vimfiles' and '/usr/share/vim/vim81' in vim's
" runtime path.
"
" This will allow NeoVim to load plugins installed by 'emerge', because
" the app-vim/* ebuilds are not 'NeoVim aware' yet.
set rtp=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after
set rtp+=/usr/share/vim/vimfiles,/usr/share/vim/vim81

"" Install Plugins via 'vim-plug' into the '.config/nvim/autoload/plugged' directory.
call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}         " VSCode like extensions for NeoVim
Plug 'sheerun/vim-polyglot'                             " Better syntax highlighting
Plug 'igankevich/mesonic'                               " meson buildsystem integration
Plug 'tpope/vim-sleuth'                                 " auto set indent settings
Plug 'jiangmiao/auto-pairs'                             " Auto close quotes and brackets
Plug 'alvan/vim-closetag'                               " Auto close tags in xml, html, etc.
Plug 'turbio/bracey.vim'                                " Live preview of your website while you edit it
Plug 'morhetz/gruvbox'                                  " Theme for Vim
Plug 'airblade/vim-gitgutter'                           " Show diff symbols from version control
Plug 'tpope/vim-fugitive'                               " Git integration
Plug 'vim-airline/vim-airline'                          " Status bar
Plug 'ctrlpvim/ctrlp.vim'                               " Fuzzy file finder
Plug 'majutsushi/tagbar'                                " Displays function names using ctags

"" Plugin's go before this line
call plug#end()           " Stop vim-plug
