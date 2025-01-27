call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-rails'                         " Ruby on Rails development
Plug 'sheerun/vim-polyglot'                    " Syntax support many languages
" TODO vim-ruby is patched, need to pull my own version and disable polyglots?

Plug 'scrooloose/nerdtree'                     " file browser (not used much)
\Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " color code the dev icons
P\lug 'ctrlpvim/ctrlp.vim'                      " fuzzy finder (C-p replacement)
Plug 'majutsushi/tagbar'                       " TODO setup keybinds, etc.
Plug 'airblade/vim-gitgutter'                  " Git notations in the gutter
Plug 'christoomey/vim-tmux-navigator'          " Navigte tmux and vim together
Plug 'editorconfig/editorconfig-vim'           " https://editorconfig.org/


call plug#end()

