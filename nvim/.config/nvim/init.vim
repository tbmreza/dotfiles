command! Vimrc :vs $HOME/.dotfiles/nvim/.config/nvim/init.vim

set updatetime=200
set cursorline
set nowrap
set nu rnu
set mouse=nicr
set clipboard+=unnamedplus
set ignorecase smartcase

" SPACE is leader {{
nnoremap <space> <nop>
let mapleader = "\<space>"
" }}
" Day to day text editing {{
nmap <leader>m yygclp
vmap <leader>m ygvgcP
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
  let g:airline_theme='google_dark'
  let g:gruvbox_contrast_dark = 'soft'
endfunction
command! DarkMode call DarkMode()

function! LightMode()
  set background=light
  let g:airline_theme='cobalt2'
  let g:gruvbox_contrast_light = 'soft'
endfunction
command! LightMode call LightMode()

function! AirlineInit()
  call DarkMode()
  call airline#parts#define('modified', {
        \ 'raw': '%m',
        \ 'accent': 'red',
        \ })
  let g:airline_section_c = airline#section#create(['%<', '%f', 'modified', ' ', 'readonly'])
endfunction

autocmd vimenter * call AirlineInit()
autocmd vimenter * ++nested colorscheme gruvbox
" autocmd vimenter * ++nested colorscheme ayu
" autocmd vimenter * ++nested colorscheme spring-night
" autocmd vimenter * ++nested colorscheme nord
" }}

" Filetype by filetype {{
filetype plugin on
autocmd BufRead,BufNewFile *.volt setfiletype html

function! OtherFiletypes()
  nmap <leader>f :Autoformat<cr>
  vmap <leader>f :Autoformat<cr>
endfunction

function! FiletypePrettier()
  nmap <leader>f :Prettier<cr>
  vmap <leader>f <Plug>(coc-format-selected)
endfunction

" autocmd filetype * call OtherFiletypes()
autocmd BufRead,BufNewFile * call OtherFiletypes()
autocmd BufRead,BufNewFile javascript,javascriptreact,typescript,typescriptreact,json,graphql,css,markdown call FiletypePrettier()
autocmd BufRead,BufNewFile coq call LightMode()
" }}

" Plugin configs {{
" NERDTree
let g:NERDTreeWinPos = "right"
" indentLine
let g:indentLine_char = '·'
" winresizer
let g:winresizer_start_key = '<leader>e'
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
" mundo
set undofile
set undodir=~/.vim/undo
" }}

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
" Theme
Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rhysd/vim-color-spring-night'
" IDE
Plug 'APZelos/blamer.nvim'
Plug 'amadeus/vim-jsx'
Plug 'joereynolds/SQHell.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
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
Plug 'preservim/tagbar'
Plug 'simeji/winresizer'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'wesQ3/vim-windowswap'
call plug#end()

