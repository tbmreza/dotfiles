command! Vimrc :vs $HOME/.dotfiles/nvim/.config/nvim/init.vim

nnoremap <space> <nop>
let mapleader = "\<space>"
" Cycle through tabs {{
noremap <tab> gt
noremap <s-tab> gT
nnoremap <c-d> <c-y>
nmap <c-y> <s-tab>
" }}
noremap <leader>f :Neoformat<cr>
tnoremap <f4> <c-\><c-n>
nnoremap Y y$
nnoremap <leader>s :w<cr>
nmap <leader>m yygclp
vmap <leader>m ygvgcP
nnoremap <leader>q :sp<cr>:SQHExecuteFile<cr>
nnoremap <leader>g :Git<space>
nnoremap <leader>c :Cargo<space>
nnoremap <leader>; <s-a>;<esc>
nnoremap <silent> <esc><esc> :nohlsearch<cr>
nnoremap <silent> <c-p> :Files<cr>
nnoremap <silent> <c-f> :Rg<cr>
nnoremap <silent> <c-b> :NERDTreeToggle<cr>
" Horizontal scrolling {{
set sidescroll=1
set sidescrolloff=10
noremap <silent><C-ScrollWheelDown> 10zl
noremap <silent><C-2-ScrollWheelDown> 10zl
noremap <silent><C-3-ScrollWheelDown> 10zl
noremap <silent><C-4-ScrollWheelDown> 10zl
noremap <silent><C-ScrollWheelUp> 10zh
noremap <silent><C-2-ScrollWheelUp> 10zh
noremap <silent><C-3-ScrollWheelUp> 10zh
noremap <silent><C-4-ScrollWheelUp> 10zh
" }}

set updatetime=200
set cursorline
set nowrap
set nu rnu
set mouse=nicr
set clipboard+=unnamedplus
set ignorecase
set smartcase
if (has("termguicolors"))
  set termguicolors
endif
" Associate file extensions
au BufRead,BufNewFile *.volt setfiletype html

" Theme
function! AirlineInit()
  call airline#parts#define('modified', {
        \ 'raw': '%m',
        \ 'accent': 'red',
        \ })
  let g:airline_section_c = airline#section#create(['%<', '%f', 'modified', ' ', 'readonly'])
endfunction

autocmd vimenter * call AirlineInit()
let g:airline_theme='google_dark'
" let g:airline_theme='spring_night'
let g:gruvbox_contrast_dark = 'soft'
" let ayucolor="mirage"
" let ayucolor="dark"

" LIGHT MODE
set termguicolors
set background=light
let g:airline_theme='cobalt2'
let g:gruvbox_contrast_light = 'soft'

autocmd vimenter * ++nested colorscheme gruvbox
" autocmd vimenter * ++nested colorscheme ayu
" autocmd vimenter * ++nested colorscheme spring-night
" autocmd vimenter * ++nested colorscheme nord

" autocmd WinEnter,FileType python,javascript colorscheme desert256
" autocmd WinEnter,FileType *,html,css        colorscheme jellybeans  " This includes default filetype colorscheme.

" NERDTree
let g:NERDTreeWinPos = "right"
" indentLine
let g:indentLine_char = '·'
" winresizer
let g:winresizer_start_key = '<leader>e'
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
" blamer
let g:blamer_enabled = 1
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
" rainbow
let g:rainbow_active = 0
" SQHell
let g:sqh_provider = 'sqlite'
let g:sqh_connections = {
      \ 'course': {
        \   'database': '/Users/reza.handzalah/work/cmu-db-course/homework_sql/musicbrainz-cmudb2020.db'
        \},
        \ 'default': {
          \   'database': '/Users/reza.handzalah/work/cmu-db-course/homework_sql/musicbrainz-cmudb2020.db'
          \}
          \}

let g:formatterpath = ['/Users/reza.handzalah/.nvm/versions/node/v14.16.0/bin']
" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" coqtail
filetype plugin on
" neoformat
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1

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
Plug 'joereynolds/SQHell.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'sbdchd/neoformat'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'whonore/Coqtail'
" Text Editor
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'gioele/vim-autoswap'
Plug 'luochen1990/rainbow'
Plug 'preservim/tagbar'
Plug 'simeji/winresizer'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'wesQ3/vim-windowswap'
call plug#end()

