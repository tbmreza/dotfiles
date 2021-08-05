" TODO
" git status highlighting (modified red, added green)
" folding
command! Vimrc :vs $HOME/.dotfiles/nvim/.config/nvim/init.vim

nnoremap <space> <nop>
let mapleader = "\<space>"
noremap <tab> gt
noremap <s-tab> gT
noremap <leader>f :Autoformat<CR>
tnoremap <f4> <c-\><c-n>
nnoremap Y y$
nnoremap <leader>s :w<cr>
nmap <leader>m yygclp
vmap <leader>m ygvgcP
nnoremap <leader>g :Git<space>
nnoremap <leader>; <s-a>;<esc>
nnoremap <silent> <esc><esc> :nohlsearch<cr>
nnoremap <silent> <c-p> :Files<cr>
nnoremap <silent> <c-f> :Rg<cr>

set updatetime=200
set colorcolumn=80,120
set cursorline
set nowrap
set nu rnu
set mouse=nicr
set clipboard+=unnamedplus
set ignorecase
set smartcase

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
let g:gruvbox_contrast_dark = 'soft'
autocmd vimenter * ++nested colorscheme gruvbox

" " LIGHT MODE
" set termguicolors
" set background=light
" let g:airline_theme='cobalt2'
" let g:gruvbox_contrast_light = 'hard'

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
" vim-autoformat
let g:python3_host_prog="/usr/local/bin/python3"
let g:formatter_yapf_style = 'yapf'
" blamer
let g:blamer_enabled = 1
" rainbow
let g:rainbow_active = 0

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
" Theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
" IDE
Plug 'tpope/vim-fugitive'
Plug 'APZelos/blamer.nvim'
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-autoformat/vim-autoformat'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'shawncplus/phpcomplete.vim'
" Text Editor
Plug 'simeji/winresizer'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'Yggdroot/indentLine'
Plug 'luochen1990/rainbow'
Plug 'airblade/vim-gitgutter'
call plug#end()

