call plug#begin('~/.config/nvim/plugged')

" colorschemes
" Plug 'dracula/vim'
Plug 'joshdick/onedark.vim'                    "sexy color scheme
Plug 'itchyny/lightline.vim'                   "status line
Plug 'scrooloose/nerdtree'                     "file browser al la de facto standard
Plug 'ryanoasis/vim-devicons'                  "add unicode nerdfront icons to NERDTree, Lightline, etc.
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' "color code the dev icons and files for NERDTree
Plug 'ap/vim-css-color'                        "shows colors like #FF0000 as-is
Plug 'ctrlpvim/ctrlp.vim'                      "fuzzy finder simular to command-T in textmate
Plug 'majutsushi/tagbar' " TODO setup keybinds, etc.
Plug 'tpope/vim-rails' "TODO custom keybinds and learn this inside and out
Plug 'tpope/vim-fugitive' " Git awesomeness

call plug#end()

