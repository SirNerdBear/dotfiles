call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-rails'                         " Ruby on Rails development
Plug 'sheerun/vim-polyglot'                    " Syntax support many languages
" TODO vim-ruby is patched, need to pull my own version and disable polyglots?


Plug 'itchyny/lightline.vim'                   " status line
Plug 'scrooloose/nerdtree'                     " file browser (not used much)
Plug 'ryanoasis/vim-devicons'                  " add nerdfront icons
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " color code the dev icons
Plug 'ap/vim-css-color'                        " shows colors like #FF0000
Plug 'ctrlpvim/ctrlp.vim'                      " fuzzy finder (C-p replacement)
Plug 'majutsushi/tagbar'                       " TODO setup keybinds, etc.
Plug 'tpope/vim-fugitive'                      " Git awesomeness
Plug 'airblade/vim-gitgutter'                  " Git notations in the gutter
Plug 'christoomey/vim-tmux-navigator'          " Navigte tmux and vim together
Plug 'editorconfig/editorconfig-vim'           " https://editorconfig.org/
Plug 'dracula/vim', {'as': 'dracula'}          " Sexy color scheme
" Plug 'Raimondi/delimitMate'
" https://github.com/tpope/vim-unimpaired/blob/master/plugin/unimpaired.vim


call plug#end()

