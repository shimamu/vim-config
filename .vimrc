" vim:set ts=8 sts=2 sw=2 tw=0:
" vim:set foldmethod=marker:

" Encoding {{{1
scriptencoding utf-8
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
" }}}
" Plugins {{{1
" ==============================================================================
" + Pre-process {{{2
" ------------------------------------------------------------------------------
" Using vim-plug as the plugin manager.
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Keep Plugin commands between plug#begin/end.
call plug#begin()

" + Plugins {{{2
" ------------------------------------------------------------------------------
" ++ Plugins for markdown {{{3
" ------------------------------------------------------------------------------
Plug 'godlygeek/tabular'
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'
Plug 'shimamu/vim-markdown-assist'
if has('win32')
  let g:previm_disable_default_css = 1
  let g:previm_custom_css_path = '~/.vim/css/markdown.css'
endif

" ++ Plugin for configurable status line {{{3
" ------------------------------------------------------------------------------
Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \    'left': [['mode', 'paste'], ['readonly', 'filename', 'modified', 'fixMode']]
      \ },
      \ 'component_function': {
      \   'fixMode': 'FixModeStatus'
      \ }
      \ }
function! FixModeStatus()
  return IMStatus('Jpfix')
endfunction

" ++ Plugin for controling Input Method {{{3
" ------------------------------------------------------------------------------
Plug 'fuenor/im_control.vim'
if has('win32')
  " Action mode for 'Japanese input fixed mode'
  let IM_CtrlMode = 4
  " Key mapping for 'Japanese input fixed mode'
  inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>
elseif has('unix')
  " Action mode for 'Japanese input fixed mode'
  let IM_CtrlMode = 1
  " Key mapping for 'Japanese input fixed mode'
  inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
  " after IBus 1.5
  function! IMCtrl(cmd)
    let cmd = a:cmd
    if cmd == 'On'
      let res = system('ibus engine "mozc-jp"')
    elseif cmd == 'Off'
      let res = system('ibus engine "xkb:jp::jpn"')
    endif
    return ''
  endfunction
endif

" ++ Plugin for file system explorer {{{3
" ------------------------------------------------------------------------------
Plug 'scrooloose/nerdtree'
" Customize <CR> to remain in tree window after opening.
let NERDTreeCustomOpenArgs={'file': {'where': 'p', 'stay': 1}, 'dir': {}}

" ++ Plugin for tagbar {{{3
" ------------------------------------------------------------------------------
Plug 'majutsushi/tagbar'

" ++ Plugin for an interface to WEB APIs. {{{3
" ------------------------------------------------------------------------------
Plug 'mattn/webapi-vim'

" ++ Plugin for extended f, F, t and T key mappings. {{{3
" ------------------------------------------------------------------------------
Plug 'rhysd/clever-f.vim'
let g:clever_f_across_no_line=1
let g:clever_f_smart_case=1
let g:clever_f_use_migemo=1
let g:clever_f_fix_key_direction=1
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

" ++ Plugin for automatically close parenthese (), {}, "",... {{{3
" ------------------------------------------------------------------------------
Plug 'cohama/lexima.vim'

" ++ Plugin for colorscheme {{{3
" ------------------------------------------------------------------------------
Plug 'crusoexia/vim-monokai'

" ++ Plugin for autoformat {{{3
" ------------------------------------------------------------------------------
Plug 'vim-autoformat/vim-autoformat'

" ++ Plugin for ESLint {{{3
" ------------------------------------------------------------------------------
Plug 'dense-analysis/ale'
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\}
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\}
let g:ale_fix_on_save = 1
let g:ale_set_quickfix = 1

" ++ Plugin for toggle comments on and off {{{3
" ------------------------------------------------------------------------------
Plug 'tpope/vim-commentary'

" }}}
" + Post-process {{{2
" ------------------------------------------------------------------------------
" All of your Plugins must be added before the following line
call plug#end()


" General {{{1
" ==============================================================================
" + Cursor {{{2
" ------------------------------------------------------------------------------
set showmatch
set cursorline

" cursor shape.
if has('vim_starting')
    " insert mode (bar cursor shape)
    let &t_SI .= "\e[6 q"
    " normal mode (block cursor shape)
    let &t_EI .= "\e[2 q"
    " replace mode (underline cursor shape)
    let &t_SR .= "\e[4 q"
endif

" + Backup {{{2
" ------------------------------------------------------------------------------
set nobackup

" + History {{{2
" ------------------------------------------------------------------------------
set noundofile

" + Swap file {{{2
" ------------------------------------------------------------------------------
if !isdirectory($HOME . "/.vim/swap")
  call mkdir($HOME . "/.vim/swap", "p")
endif

set directory^=$HOME/.vim/swap//

" + Runtime path {{{2
" ------------------------------------------------------------------------------
" Add .vim directories to runtimepath.
if has('win32')
  set runtimepath+=$HOME/.vim,$HOME/.vim/after
endif

" + Abbreviate {{{2
" ------------------------------------------------------------------------------
"source ~/.vim/abbreviate.vim
:ab cooklecurry@ cooklecurry@gmail.com

" + Backspace {{{2
" ------------------------------------------------------------------------------
set backspace=indent,eol,start


" Screen {{{1
" ==============================================================================
" + Layout {{{2
" ------------------------------------------------------------------------------
" ++ Window wrapping {{{3
" ------------------------------------------------------------------------------
set wrap

" ++ Text wrapping {{{3
" ------------------------------------------------------------------------------
"set textwidth=80
"set formatoptions+=mM

" ++ Tab {{{3
" ------------------------------------------------------------------------------
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab

" ++ Non-display characters {{{3
" ------------------------------------------------------------------------------
set list
set listchars=tab:\|\ ,extends:<,trail:-,eol:$

" ++ Characters with East Asian Width Class Ambiguous {{{3
" ------------------------------------------------------------------------------
set ambiwidth=double

" + Indentng {{{2
" ------------------------------------------------------------------------------
set autoindent


" Color {{{1
" ==============================================================================
syntax on
"colorscheme ithd
colorscheme monokai

" Make background transparent in terminal(rxvt).
if &term =~ 'rxvt'
  colorscheme monokai
  highlight Normal ctermbg=NONE guibg=NONE
  highlight NonText ctermbg=NONE guibg=NONE
  highlight SpecialKey ctermbg=NONE guibg=NONE
  highlight EndOfBuffer ctermbg=NONE guibg=NONE
endif


" Window {{{1
" ==============================================================================
" + Title {{{2
" ------------------------------------------------------------------------------
set title
set titleold=

" + Line number {{{2
" ------------------------------------------------------------------------------
set number
"set relativenumber

" + Status line {{{2
" ------------------------------------------------------------------------------
" ++ Basic {{{3
" ------------------------------------------------------------------------------
set laststatus=2

" ++ Ruler {{{3
" ------------------------------------------------------------------------------
set ruler

" + Command line {{{2
" ------------------------------------------------------------------------------
set cmdheight=1
set showcmd
set wildmenu


" Search {{{1
" ==============================================================================
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan


" Key mapping {{{1
" ==============================================================================
" Toggle Tagbar.
nmap <F8> :TagbarToggle<CR>

" Stop the highlighting for the 'hlsearch' option.
nnoremap <silent> <C-l> :noh<CR><C-l>

" Begin a new line below the cursor.
nnoremap <silent> <SPACE> o<ESC>


" Filetypes {{{1
" ==============================================================================
autocmd FileType * noremap <buffer> <silent> = :Autoformat<CR>
" + HTML {{{2
" ------------------------------------------------------------------------------
au BufNewFile,BufRead *.html  set nowrap tabstop=2 shiftwidth=2

" + CSS {{{2
" ------------------------------------------------------------------------------
au BufNewFile,BufRead *.css,*.scss  set nowrap tabstop=2 shiftwidth=2

" + Javascript {{{2
" ------------------------------------------------------------------------------
augroup javascript_settings
  autocmd!
  autocmd FileType javascript set nowrap tabstop=2 shiftwidth=2
  autocmd FileType javascript noremap <buffer> <silent> = :ALEFix<CR>
augroup END

" + Markdown {{{2
" ------------------------------------------------------------------------------
" Open current buffer in browser.
au BufNewFile,BufRead *.md nnoremap <silent> <C-p> :PrevimOpen<CR>

" No text wrapping.
au Filetype markdown setl textwidth=0

let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/build/markdown2ctags/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

" + Ruby {{{2
" ------------------------------------------------------------------------------
au BufNewFile,BufRead *.rb  set nowrap tabstop=2 shiftwidth=2

