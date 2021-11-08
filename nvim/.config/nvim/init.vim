command! Vimrc :vs $HOME/.dotfiles/nvim/.config/nvim/init.vim

set hidden
set updatetime=200
set cursorline
set nowrap
set nu rnu
set mouse=nicr
set clipboard+=unnamedplus
set ignorecase smartcase
set formatoptions=jcql

" SPACE is leader {{
nnoremap <space> <nop>
let mapleader = "\<space>"
" }}
" Closing pair {{
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
" }}
" Window {{
nmap ç <c-w>c
nnoremap ˇ <c-w><s-t>
nnoremap — <c-w>_
nmap ≠ <c-w>=
nmap ˙ <c-w>h
nmap ∆ <c-w>j
nmap ˚ <c-w>k
nmap ¬ <c-w>l
nmap ¯ 4<c-w><
nmap ˘ 4<c-w>>
nmap ± 4<c-w>+
nmap – 4<c-w>-
" }}
" Day to day text editing {{
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
nmap mm yygccp
vmap m ygvgcP
nnoremap Y y$
nnoremap <leader>s :w<cr>
nnoremap <leader>; <s-a>;<esc>
nnoremap <silent> <esc><esc> :nohlsearch<cr>
" }}
" IDE {{
nnoremap <leader>x :sp<cr>:SQHExecuteFile<cr>
nnoremap <leader>b :Vexplore<cr>
nnoremap <silent> <c-p> :Files<cr>
nnoremap <silent> <c-f> :Rg<cr>
" }}
" Terminal command integration {{
nnoremap <leader>g :Git<space>
nnoremap <leader>c :Cargo<space>
" }}
" Cycle through tabs {{
noremap <tab> gt
noremap <s-tab> gT
nnoremap <c-d> <c-y>
nmap <c-y> <s-tab>
nmap [b :bprev<cr>
nmap ]b :bnext<cr>
" }}
" Horizontal scrolling (ugly but here we are) {{
set sidescroll=1
set sidescrolloff=10
noremap <silent><C-ScrollWheelDown>   10zl
noremap <silent><C-2-ScrollWheelDown> 10zl
noremap <silent><C-3-ScrollWheelDown> 10zl
noremap <silent><C-4-ScrollWheelDown> 10zl
noremap <silent><C-ScrollWheelUp>     10zh
noremap <silent><C-2-ScrollWheelUp>   10zh
noremap <silent><C-3-ScrollWheelUp>   10zh
noremap <silent><C-4-ScrollWheelUp>   10zh
" }}
" Copy buffer file path {{
noremap <f1> :let @+ = expand("%")<cr>
" Exit terminal mode
tnoremap <f4> <c-\><c-n>
" }}
" netrw {{
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 2
let g:netrw_winsize = 20
" }}

" Theme {{
set termguicolors
let g:colorscheme_switcher_exclude_builtins = 1

function! DarkMode()
  set background=dark
  let g:gruvbox_contrast_dark = 'soft'
endfunction
command! DarkMode call DarkMode()

function! LightMode()
  set background=light
  let g:gruvbox_contrast_light = 'soft'
endfunction
command! LightMode call LightMode()

autocmd vimenter * ++nested colorscheme melange
" }}

" lightline {{
set showtabline=2
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'powerlineish',
      \ 'my': {}
      \ }
let g:lightline.active = {
      \ 'left': [['mode', 'paste'], ['gitbranch'], ['readonly', 'absolutepath', 'modified'], ['method']],
      \ 'right': [['lineinfo'], ['percent'], ['filetype']]
      \ }
let g:lightline.tabline = {
      \ 'right': [['cocstatus']]
      \ }
let g:lightline.mode_map = {
      \ 'n': 'NOR',
      \ 'i': 'INS',
      \ 'R': 'REP',
      \ 'v': 'VIS',
      \ 'V': 'V-L',
      \ "C-v>": 'V-B',
      \ 'c': 'COM',
      \ 's': 'SEL',
      \ 'S': 'S-L',
      \ "C-s>": 'S-B',
      \ 't': 'TER',
      \ }
let g:lightline.component_function = {
      \ 'gitbranch': 'FugitiveHead',
      \ 'cocstatus': 'coc#status',
      \ 'method': 'NearestMethodOrFunction'
      \ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update() " freezes in tabline
" }}

" Filetype by filetype {{
filetype plugin on
autocmd BufRead,BufNewFile *.volt setfiletype html

let g:neoformat_javascript_prettier = {
            \ 'exe': 'prettier',
            \ 'args': ['--write'],
            \ 'replace': 1,
            \ }

let g:neoformat_enabled_javascript = ['prettier']

nmap <leader>f :Neoformat<cr>
vmap <leader>f :Neoformat!<space>

function! FiletypeCoq()
  nmap <leader>j :CoqNext<cr>
  nmap <leader>k :CoqUndo<cr>
  nmap <leader>l :CoqToLine<cr>
  " silent! call repeat#set("<leader>j")
  " silent! call repeat#set("<leader>k")
  " silent! call repeat#set("<leader>l")
endfunction

function! FiletypeRust()
  nmap <leader>f :RustFmt<cr>
endfunction
"
" function! FiletypePrettier()
"   nmap <leader>f :Prettier<cr>
"   vmap <leader>f <Plug>(coc-format-selected)
" endfunction

function! FiletypePHP()
  vnoremap <leader>dd yodd(<c-r>0);<esc>
  nnoremap <leader>dd yeodd(<c-r>0);<esc>
endfunction

autocmd filetype coq call FiletypeCoq()
autocmd filetype rust call FiletypeRust()
" autocmd filetype svelte,javascript,javascriptreact,typescript,typescriptreact,json,graphql,css,markdown call FiletypePrettier()
" autocmd filetype javascript,javascriptreact,typescript,typescriptreact,json,graphql,css,markdown call FiletypePrettier()
autocmd filetype php call FiletypePHP()
" }}

" Plugin configs {{
" indentLine
let g:indentLine_char = '·'
" Coqtail
let g:coqtail_noimap = 1
" let g:coqtail_map_prefix = '<leader>q'
" rust.vim
syntax enable
filetype plugin indent on
let g:rustfmt_autosave = 0
" coc.nvim
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)
nmap <f2> <Plug>(coc-rename)
" command! -nargs=0 Prettier :CocCommand prettier.formatFile
" blamer
let g:blamer_enabled = 1
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
" rainbow
let g:rainbow_active = 0
" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" neoformat
let g:neoformat_try_formatprg = 1
" let g:neoformat_enabled_javascript = ['prettier']
" augroup NeoformatAutoFormat
"     autocmd!
"     autocmd FileType javascript setlocal formatprg=prettier\
"                                              \--stdin\
"                                              \--print-width\ 80\
"                                              \--single-quote\
"                                              \--trailing-comma\ es5
"     autocmd BufWritePre *.js Neoformat
" augroup END
" let g:neoformat_basic_format_align = 1
" let g:neoformat_basic_format_retab = 1
" let g:neoformat_basic_format_trim = 1
" SQHell
let g:sqh_provider = 'sqlite'
let g:sqh_connections = {
      \ 'course': {
        \ 'database': '/Users/reza.handzalah/work/cmu-db-course/homework_sql/musicbrainz-cmudb2020.db'
        \ },
        \ 'default': {
          \ 'database': '/Users/reza.handzalah/work/cmu-db-course/homework_sql/musicbrainz-cmudb2020.db'
          \ }
          \ }
" mundo
nnoremap <F5> :MundoToggle<CR>
set undofile
set undodir=~/.vim/undo
" vista
let g:vista#renderer#enable_icon = 0
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
" " prettier
" let g:prettier#quickfix_enabled = 0
" let g:prettier#autoformat_require_pragma = 0
" " au BufWritePre *.css,*.svelte,*.pcss,*.html,*.ts,*.js,*.json PrettierAsync
" au BufWritePre *.svelte PrettierAsync
" emmet
let g:user_emmet_expandabbr_key = '<C-e>'
let g:user_emmet_mode='i'
let g:user_emmet_settings = {
\  'rust' : {
\    'snippets': {
\      'fn': 'fn |() {\n}\n'
\    }
\  },
\  'php' : {
\    'snippets': {
\      'dd': 'dd( | );'
\    }
\  },
\  'javascript' : {
\    'snippets': {
\      'cl': 'console.log({ | });',
\      'cd': 'console.dir( | );',
\      'ci': 'console.info( | );',
\      'cde': 'console.debug( | )'
\    }
\  }
\}
" }}

silent! call repeat#set("zfi{")
silent! call repeat#set("zfib")
silent! call repeat#set("zfip")

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
" Appearence
Plug 'itchyny/vim-gitbranch' " lightline component
Plug 'josa42/vim-lightline-coc'
Plug 'tbmreza/lightline.vim'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc' " xolox dependency
" Switch using `:NextColorScheme`.
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'rhysd/vim-color-spring-night'
Plug 'savq/melange'
" Plugins that use dedicated split/modal
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim' " commit history
Plug 'junegunn/vim-peekaboo' " peek registers
Plug 'liuchengxu/vista.vim'
Plug 'simnalamburt/vim-mundo' " undo history
Plug 'tpope/vim-fugitive'
" Plugins that don't
Plug 'APZelos/blamer.nvim'
Plug 'Shougo/context_filetype.vim'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'luochen1990/rainbow'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'sbdchd/neoformat'
Plug 'tbmreza/vim-context-commentstring'
Plug 'tbmreza/vim-sandwich'
Plug 'tomtom/tcomment_vim'
Plug 'tyru/open-browser.vim'
" Plug 'vim-autoformat/vim-autoformat'
Plug 'wesQ3/vim-windowswap'
" Languages support
Plug 'joereynolds/SQHell.vim'
Plug 'non25/vim-svelte'
Plug 'rust-lang/rust.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tbmreza/Coqtail'
Plug 'yuezk/vim-js'
" Neovim 'bug' patches
Plug 'gioele/vim-autoswap'
Plug 'tpope/vim-repeat'
call plug#end()
