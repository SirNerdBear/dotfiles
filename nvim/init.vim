let mapleader="\<SPACE>" " spacebar as map leader for more shortcuts
nnoremap <Space> <Nop>


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

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" }}}

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
" let g:onedark_terminal_italics = 1
let g:dracula_colorterm = 0
let g:dracula_italic = 1
" default background
highlight Normal ctermbg=None

set cursorline


set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'dracula',
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

" easy split navigation (incase not running in tmux)
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

nmap <leader><space> :set hlsearch! hlsearch?<cr>

nmap <silent> <leader>rc :Econtroller<cr>

" S = write


if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" Quickly edit/reload this configuration file
nnoremap gev :e $MYVIMRC<CR>
nnoremap gsv :so $MYVIMRC<CR>

if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd


" set a near zero delay on <ESC> while still allowing special keys
" set timeoutlen=10 ttimeoutlen=0
set notimeout
set ttimeout

set fcs=eob:\ " a blank space instead of a ~

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" Prevent NerdTree from blocking tmux pane navigation on J and K
let g:NERDTreeMapJumpPrevSibling=""
let g:NERDTreeMapJumpNextSibling=""


set number                  " show line numbers
set relativenumber          " make it easier to do motions (combined with above current line always shows the real linenumber)

" Show relative lines only when a buffer is focused and not in insert mode
augroup numbertoggle
      autocmd!
      autocmd BufEnter,FocusGained,InsertLeave * if &ft!="nerdtree"|set relativenumber|endif
      autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

let g:ruby_operators = 1

syntax on
color dracula       " For some reason both color and colorscheme need to be set to work???
colorscheme dracula " Set the colorscheme
hi Comment cterm=italic gui=italic
hi FoldColumn ctermfg=61 ctermbg=235 guifg=#6272a4 guibg=#282a36
hi CursorLine term=bold cterm=bold guibg=Gray15
autocmd Syntax ruby syn match rubyOperator "=[^begin|end]" " assignment
autocmd Syntax ruby syn match rubyOperator "\S\@<=\." " dot
autocmd Syntax ruby syn match rubyOperator "&\." " safe-access
autocmd Syntax ruby syn match rubyOperator "\.equal?" " object id equality
autocmd Syntax ruby syn match rubyOperator "\.eql?" " true equals
autocmd Syntax ruby syn match rubyOperator "\s\@<=[?:]\s" " tur-op (needs spaces)
autocmd Syntax ruby syn match rubyOperator "\S\@<=:\ze[[:space:],]\@="
" Ruby syntax file also being changed:
" Should submit patch and/or fork repo
" -  syn match  rubyOperator "[~!^|*/%+-]\|&\.\@!\|\%(class\s*\)\@<!<<\|<=>\|<=\|\%(<\|\<class\s\+\u\w*\s*\)\@<!<[^<]\@=\|===\|==\|=\~\|>>\|>=\|=\@1<!>\|\*\*\|\.\.\.\|\.\.\|::"
" +  syn match  rubyOperator "[~!^|*/%+-]\|&\.\@!\|\%(class\s*\)\@<!<<\|<=>\|<=\|\%(<\|\<\s\+\u\w*\s*\)\@<!<[^<]\@=\|===\|==\|=\~\|>>\|>=\|=\@1<!>\|\*\*\|\.\.\.\|\.\.\|::"
" -syn match  rubySymbol          "[]})\"':]\@1<!\<\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*[!?]\=:[[:space:],]\@="he=e-1
" +syn match  rubySymbol          "[]})\"':]\@1<!\<\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*[!?]\=\ze:[[:space:],]\@="
" -syn match  rubySymbol          "[[:space:],{(]\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*[!?]\=:[[:space:],]\@="hs=s+1,he=e-1
" +syn match  rubySymbol          "[[:space:],{(]\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*[!?]\ze:[[:space:],]\@="


autocmd Syntax ruby syn match rubyStringEscape "\\u" contained display

command! ToggleCC :let &cc = &cc == '' ? '+0' : ''
command! ToggleCF :let &foldcolumn = &foldcolumn == '0' ? '1' : '0'
command! ToggleCV :let &signcolumn = &signcolumn == 'no' ? 'yes' : 'no'
nnoremap <leader>cc :ToggleCC<CR>
nnoremap <leader>cf :ToggleCF<CR>
nnoremap <leader>cv :ToggleCV<CR>

nnoremap S :write<cr>
function! NeatFoldText()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*["#]\s*\|--\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '┫ ' . printf("%10s", lines_count . ' lines') . ' ┣'
    let foldchar = "━" " matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+ ━━┫░' . line . '░┣', 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

"set foldtext=NeatFoldText()

"set foldmethod=syntax
