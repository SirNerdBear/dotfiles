source ~/.config/nvim/plugins.vim

" Section General {{{

set nocompatible            " not compatible with vi
set autoread                " detect when a file is changed

set history=1000            " change history to 1000
set textwidth=120

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" }}}

" ESC key on keyboard is disabled (remapped to capslock) training wheels to stop myself from old habbits
:map! <F19> <Nop> 

" Section User Interface {{{

" switch cursor to line when in insert mode, and block when not
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

if &term =~ '256color'
   " disable background color erase
   set t_ut=
   set t_Co=256
endif



if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

let g:onedark_terminal_italics=1 " Requires support in terminal emulator: 

set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'Dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ],
      \  'right': [ [ 'syntastic', 'lineinfo' ],
      \             [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'inactive': {
      \    'right': [ ['lineinfo'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \  },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \   'lineinfo': 'LightlineLineinfo'
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag', 
      \ }, 
      \ 'component_type': { 
      \   'syntastic': 'error', 
      \ }, 
      \ 'component_visible_condition': {
      \   'lineinfo': 'LightlineLineinfoShow', 
      \ }, 
      \ 'separator': { 'left': '', 'right': '' }, 
      \ 'subseparator': { 'left': '', 'right': '' } 
      \ }

function! LightlineModified() 
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? '⭤' : '' 
endfunction

function! LightlineLineinfo()
  return LightlineLineinfoShow() ? (line('.').':'.col('.')) : '' 
endfunction

function! LightlineLineinfoShow()
  let fname = expand('%:t') 
  let _ = fname =~ '__Tagbar__' || fname == 'CtrlP' || fname =~ 'NERD_tree'
  return !_
endfunction

function! LightlineFilename() 
  let fname = expand('%:t') 
  return fname == 'CtrlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item : 
    \ fname =~ '__Tagbar__' ? g:lightline.fname :
    \ fname =~ '__Gundo\|NERD_tree' ? '' :
    \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
    \ ('' != fname ? fname : '[No Name]') .
    \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname =~ '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END

function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:vimshell_force_overwrite_statusline = 0

syntax on
color dracula       " For some reason both color and colorscheme need to be set to work???
colorscheme dracula " Set the colorscheme
highlight Comment cterm=italic

" make the highlighting of tabs and other non-text less annoying
highlight SpecialKey ctermbg=none ctermfg=8
highlight NonText ctermbg=none ctermfg=8

" make comments and HTML attributes italic
highlight htmlArg cterm=italic

set number                  " show line numbers
set relativenumber          " make it easier to do motions (combined with above current line always shows the real linenumber)

" easy split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" better spliting
set splitbelow
set splitright

" open NERDTree if starting with directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" toggle NERDTree keybind
map <C-n> :NERDTreeToggle<CR>

" close vim if only NERDTree is open and we're quiting
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let NERDTreeShowExecutableFlag = 0

" makes the entire file name colored
" let g:NERDTreeFileExtensionHighlightFullName = 0
" let g:NERDTreeExactMatchHighlightFullName = 0
" let g:NERDTreePatternMatchHighlightFullName = 0

let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
" let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.coffee.*\.erb$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.haml$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.applescript$'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.sh$'] = ''



let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = 'F54D27'

let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*\.coffee.*\.erb$'] = "905532"
let g:NERDTreePatternMatchHighlightColor['.*\.haml$'] = "31B53E"
let g:NERDTreePatternMatchHighlightColor['.*\.applescript$'] = "FFFFFF"
let g:NERDTreePatternMatchHighlightColor['.*\.sh$'] = "FFFF00"
let g:NERDTreePatternMatchHighlightColor['\*$'] = "FF0000"

let g:NERDTreeExactMatchHighlightColor = {}

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif



let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " *nix
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

let g:tagbar_compact = 1

let mapleader = ' ' " spacebar as map leader for more shortcuts

nmap <leader><space> :set hlsearch! hlsearch?<cr>

nmap <silent> <leader>rc :Econtroller<cr>

if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg " hide ~ on empty lines

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" Prevent NerdTree from blocking tmux pane navigation on J and K
let g:NERDTreeMapJumpPrevSibling=""
let g:NERDTreeMapJumpNextSibling=""
