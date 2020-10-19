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

""" INITIALIZATION
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/settings.vim

""" THEME
source $HOME/.config/nvim/plug-config/gruvbox.vim

""" PLUGIN CONFIGURATION SECTION
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/nerdtree.vim
source $HOME/.config/nvim/plug-config/closetag.vim
source $HOME/.config/nvim/plug-config/bracey.vim
source $HOME/.config/nvim/plug-config/delimitMate.vim
source $HOME/.config/nvim/plug-config/ctrlp.vim
source $HOME/.config/nvim/plug-config/tagbar.vim
source $HOME/.config/nvim/plug-config/indentLine.vim
