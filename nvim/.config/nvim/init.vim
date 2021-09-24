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
nmap mm yygclp
vmap m ygvgcP
nnoremap Y y$
nnoremap <leader>s :w<cr>
nnoremap <leader>; <s-a>;<esc>
nnoremap <silent> <esc><esc> :nohlsearch<cr>
" }}
" IDE {{
nnoremap <leader>x :sp<cr>:SQHExecuteFile<cr>
nnoremap <leader>b :NERDTreeMirror<cr>
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
" {{
" Exit terminal mode {{
tnoremap <f4> <c-\><c-n>
" {{

" Theme {{
set termguicolors
" let g:airline_theme='spring_night'
" let ayucolor="mirage"

function! DarkMode()
  set background=dark
  " let g:airline_theme='google_dark'
  let g:gruvbox_contrast_dark = 'soft'
endfunction
command! DarkMode call DarkMode()

function! LightMode()
  set background=light
  " let g:airline_theme='cobalt2'
  let g:gruvbox_contrast_light = 'soft'
endfunction
command! LightMode call LightMode()

autocmd vimenter * ++nested colorscheme gruvbox
" autocmd vimenter * ++nested colorscheme ayu
" autocmd vimenter * ++nested colorscheme spring-night
" autocmd vimenter * ++nested colorscheme nord
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

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
" }}

" Filetype by filetype {{
filetype plugin on
autocmd BufRead,BufNewFile *.volt setfiletype html

nmap <leader>f :Autoformat<cr>
vmap <leader>f :Autoformat<cr>

function! FiletypePrettier()
  nmap <leader>f :Prettier<cr>
  vmap <leader>f <Plug>(coc-format-selected)
endfunction

autocmd filetype coq call LightMode()
" autocmd filetype rust nmap <leader>f :RustFmt<cr>
autocmd filetype javascript,javascriptreact,typescript,typescriptreact,json,graphql,css,markdown call FiletypePrettier()
" }}

" Plugin configs {{
" NERDTree
let g:NERDTreeWinPos = "right"
" indentLine
let g:indentLine_char = '·'
" Coqtail
let g:coqtail_noimap = 1
let g:coqtail_map_prefix = '<leader>q'
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
command! -nargs=0 Prettier :CocCommand prettier.formatFile
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
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1
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
" mundo {{
set undofile
set undodir=~/.vim/undo
" }}
" vista
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
" }}

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
" Theme
Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'itchyny/vim-gitbranch'
Plug 'morhetz/gruvbox'
Plug 'rhysd/vim-color-spring-night'
Plug 'tbmreza/lightline.vim'
" IDE
Plug 'APZelos/blamer.nvim'
Plug 'amadeus/vim-jsx'
Plug 'joereynolds/SQHell.vim'
Plug 'josa42/vim-lightline-coc'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'sbdchd/neoformat'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'vim-autoformat/vim-autoformat'
Plug 'whonore/Coqtail'
Plug 'yuezk/vim-js'
" Text Editor
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'gioele/vim-autoswap'
Plug 'luochen1990/rainbow'
Plug 'tbmreza/vim-sandwich'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'wesQ3/vim-windowswap'
" Plug 'ryanoasis/vim-devicons'
call plug#end()
