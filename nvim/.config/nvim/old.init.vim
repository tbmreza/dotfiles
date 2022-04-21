lua << END
local o = vim.o
local wo = vim.wo
local bo = vim.bo

o.hidden = true
o.updatetime = 200
wo.cursorline = true
wo.wrap = false
wo.nu = true
wo.rnu = true
o.mouse = 'nicr'
o.clipboard = 'unnamedplus'
o.ignorecase = true
o.smartcase = true
bo.formatoptions = 'jcql'
o.list = true
o.listchars = 'eol:¬,tab:▸\\'

local def = vim.api.nvim_create_user_command
def('Vimrc'    , 'tabe $HOME/.dotfiles/nvim/.config/nvim/init.vim', { nargs = 0 })
def('Up'       , 'cd ..', { nargs = 0 })
def('Back'     , 'cd -', { nargs = 0 })
def('Scroll'   , 'windo set scrollbind', { nargs = 0 })
def('ScrollOff', 'windo set scrollbind!', { nargs = 0 })

-- remaps in separate file?
vim.g.mapleader = ' '

local map = vim.api.nvim_set_keymap

-- Plugin: mundo
vim.g.mundo_help = 1
o.undofile = true
o.undodir = os.getenv('HOME') .. '/.vim/undo'
map('n', '<F5>', ':MundoToggle<cr>', { noremap = true })

-- Plugin: vista
vim.g['vista#renderer#enable_icon'] = 0
vim.cmd [[
  function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
  endfunction
  autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
]]

-- Plugin: emmet
vim.g.user_emmet_expandabbr_key = '<C-e>'
vim.g.user_emmet_mode = 'i'
vim.g.user_emmet_settings = {
  racket = {
    snippets = {
      def = '(define |)',
      dis = '(displayln |)'
    }
  },
  rust = {
    snippets = {
      prin = 'println!("|");',
      fn = 'fn |() { }',
      test = '#[test] fn test_sanity() { assert_eq!(12, 12); }',
      modtests = '#[cfg(test)] mod tests { use super::*;  #[test] fn test_sanity() { assert_eq!(12, 12); } }'
    }
  },
  php = {
    snippets = {
      dd = 'dd( | );'
    }
  },
  javascript = {
    snippets = {
      cl = 'console.log({ | });'
    }
  }
}

-- Closing pair
map('i', '"', '""<left>', { noremap = true })
map('i', '<', '<><left>', { noremap = true })
map('i', '(', '()<left>', { noremap = true })
map('i', '[', '[]<left>', { noremap = true })
map('i', '{', '{}<left>', { noremap = true })
map('i', '{<cr>', '{<CR>}<ESC>O', { noremap = true })

-- Window
map('n', 'ç', '<c-w>c', { noremap = true })
map('n', 'ˇ', '<c-w><s-t>', { noremap = true })
map('n', '≠', '<c-w>=', { noremap = true })
map('n', '˙', '<c-w>h', { noremap = false })
map('n', '∆', '<c-w>j', { noremap = false })
map('n', '˚', '<c-w>k', { noremap = false })
map('n', '¬', '<c-w>l', { noremap = false })
map('n', '¯', '4<c-w><', { noremap = true })
map('n', '˘', '4<c-w>>', { noremap = true })
map('n', '±', '4<c-w>+', { noremap = true })
map('n', '–', '4<c-w>-', { noremap = true })

vim.g.tmux_navigator_no_mappings = 1
map('n', '˙', ':TmuxNavigateLeft<cr>', { noremap = true, silent = true })
map('n', '∆', ':TmuxNavigateDown<cr>', { noremap = true, silent = true })
map('n', '˚', ':TmuxNavigateUp<cr>', { noremap = true, silent = true })
map('n', '¬', ':TmuxNavigateRight<cr>', { noremap = true, silent = true })

-- Day to day text editing
map('v', '//', "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>", { noremap = true })
map('n', 'mm', 'yygccp', { noremap = false })
map('v', 'm', 'ygvgcP', { noremap = false })
map('n', 'Y', 'y$', { noremap = true })
map('n', '<leader>e', ':e!<cr>', { noremap = true })
map('n', '<leader>s', ':w<cr>', { noremap = true })
map('n', '<leader>;', '<s-a>;<esc>', { noremap = true })
map('n', '<leader>.', '<s-a>.<esc>', { noremap = true })
map('n', '<leader>,', '<s-a>,<esc>', { noremap = true })
map('n', '<leader>>', 'a=>', { noremap = true })
map('n', '<leader>:', 'a->', { noremap = true })
map('n', '<esc><esc>', ':nohlsearch<cr>', { noremap = true, silent = true })

-- Theme
vim.cmd [[
  function! SetColorscheme()
    colorscheme melange
    hi! Normal guibg=NONE ctermbg=NONE " transparent window if terminal supports it
  endfunction
  autocmd vimenter * ++nested call SetColorscheme()
]]

END
" SPACE is leader {{
" nnoremap <space> <nop>
" let mapleader = "\<space>"
" }}
" Closing pair {{
" inoremap " ""<left>
" inoremap < <><left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap {<CR> {<CR>}<ESC>O
" }}
" Window {{
" let g:tmux_navigator_no_mappings = 1
" nnoremap <silent> ˙ :TmuxNavigateLeft<cr>
" nnoremap <silent> ∆ :TmuxNavigateDown<cr>
" nnoremap <silent> ˚ :TmuxNavigateUp<cr>
" nnoremap <silent> ¬ :TmuxNavigateRight<cr>

" }}
" Day to day text editing {{
" vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
" nmap mm yygccp
" vmap m ygvgcP
" nnoremap Y y$
" nnoremap <leader>e :e!<cr>
" nnoremap <leader>s :w<cr>
" nnoremap <leader>; <s-a>;<esc>
" nnoremap <leader>. <s-a>.<esc>
" nnoremap <leader>, <s-a>,<esc>
" nnoremap <leader>> <s-a> =>
" nnoremap <leader>: <s-a> ->
" nnoremap <silent> <esc><esc> :nohlsearch<cr>
" Merge conflicts
nmap <leader>gj :diffget //3<cr>
nmap <leader>gf :diffget //2<cr>
" Abort sandwich
nnoremap <silent> s<esc> <nop>
" Must have typed this by mistake
nnoremap ZZ <nop>
nnoremap - <nop>
" Move lines
nnoremap <c-j> :m .+1<CR>==
nnoremap <c-k> :m .-2<CR>==
vnoremap <c-j> :m '>+1<CR>gv=gv
vnoremap <c-k> :m '<-2<CR>gv=gv
" }}
" IDE {{
" inoremap <c-j> <Plug>JiraComplete  " needs python provider
nnoremap <leader>x :sp<cr>:SQHExecuteFile<cr>
nnoremap <leader>b :Vexplore<cr>
" nnoremap <silent> <c-p> :Files<cr>
" nnoremap <silent> <c-f> :Rg<cr>
nnoremap <leader>t :Telescope<space>
" nnoremap <silent> <c-p> :Telescope find_files<cr>
nnoremap <silent> <c-p> :Files<cr>
" nnoremap <silent> <c-f> :Telescope live_grep<cr>
nnoremap <silent> <c-f> :Rg<cr>
nnoremap <silent> <c-h> :History<cr>
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
let g:netrw_list_hide= '.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\.\=/\=$'
let g:netrw_keepdir=0
" let g:netrw_winsize = 20
" }}

" leafOfTree/vim-svelte-plugin
let g:vim_svelte_plugin_load_full_syntax = 1
let g:vim_svelte_plugin_use_typescript = 1

" Theme {{
set termguicolors
let g:colorscheme_switcher_exclude_builtins = 1

" unused? and LightMode too
" function! DarkMode()
"   set background=dark
"   let g:gruvbox_contrast_dark = 'soft'
" endfunction
" command! DarkMode call DarkMode()

function! LightMode()
  set background=light
  let g:gruvbox_contrast_light = 'soft'
endfunction
command! LightMode call LightMode()

" function! SetColorscheme()
"   colorscheme melange
"   hi! Normal guibg=NONE ctermbg=NONE " transparent window if terminal supports it
" endfunction
" autocmd vimenter * ++nested call SetColorscheme()
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
" autocmd BufRead,BufNewFile *.abs setfiletype abs
" syntax/synload.vim doesn't load?
" au Syntax abs    runtime! syntax/abs.vim

let g:neoformat_javascript_prettier = {
            \ 'exe': 'prettier',
            \ 'args': ['--write'],
            \ 'replace': 1,
            \ }

let g:neoformat_json5_prettier = {
            \ 'exe': 'prettier',
            \ 'args': ['--write'],
            \ 'replace': 1,
            \ }

let g:neoformat_racket_fmt = {
            \ 'exe': 'raco',
            \ 'args': ['fmt', '-i'],
            \ 'replace': 1,
            \ }

let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_json5 = ['prettier']
let g:neoformat_enabled_racket = ['fmt']

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

" function! FiletypeRust()
"   nmap <leader>f :RustFmt<cr>
"   nnoremap <leader>dd yeoprintln!("{:?}", <c-r>0);<esc>
"   inoremap # #[]<left>
" endfunction

function! FiletypePHP()
  vnoremap <leader>dd yodd(<c-r>0);<esc>
  nnoremap <leader>dd yeodd(<c-r>0);<esc>
endfunction

autocmd filetype coq call FiletypeCoq()
" autocmd filetype rust call FiletypeRust()
lua require('tbmreza.rust')
" autocmd filetype svelte,javascript,javascriptreact,typescript,typescriptreact,json,graphql,css,markdown call FiletypePrettier()
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
" nnoremap <F5> :MundoToggle<CR>
" let g:mundo_help = 1
" set undofile
" set undodir=~/.vim/undo
" vista
" let g:vista#renderer#enable_icon = 0
" function! NearestMethodOrFunction() abort
"   return get(b:, 'vista_nearest_method_or_function', '')
" endfunction
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
" emmet
" let g:user_emmet_expandabbr_key = '<C-e>'
" let g:user_emmet_mode='i'
" let g:user_emmet_settings = {
" \  'racket' : {
" \    'snippets': {
" \      'def': '(define |)',
" \      'l': ' λ',
" \      'lamb': ' λ',
" \      'lambda': ' λ'
" \    }
" \  },
" \  'rust' : {
" \    'snippets': {
" \      'prin': 'println!("|");',
" \      'println': 'println!("|");',
" \      'println!': 'println!("|");',
" \      'fn': 'fn |() { }',
" \      'test': '#[test] fn test_sanity() { assert_eq!(12, 12); }',
" \      'modtests': '#[cfg(test)] mod tests { use super::*;  #[test] fn test_sanity() { assert_eq!(12, 12); } }',
" \    }
" \  },
" \  'php' : {
" \    'snippets': {
" \      'dd': 'dd( | );'
" \    }
" \  },
" \  'typescriptreact' : {
" \    'snippets': {
" \      'cc': '{/* | */}'
" \    }
" \  },
" \  'javascriptreact' : {
" \    'snippets': {
" \      'cc': '{/* | */}'
" \    }
" \  },
" \  'javascript' : {
" \    'snippets': {
" \      'cl': 'console.log({ | });',
" \      'cd': 'console.dir( | );',
" \      'ci': 'console.info( | );',
" \      'cde': 'console.debug( | )'
" \    }
" \  }
" \}
" }}

silent! call repeat#set("zfi{")
silent! call repeat#set("zfib")
silent! call repeat#set("zfip")

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
" Appearence
Plug 'nvim-lualine/lualine.nvim'
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
Plug 'junegunn/gv.vim' " commit history
Plug 'junegunn/vim-peekaboo' " peek registers
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
Plug 'simnalamburt/vim-mundo' " undo history
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
" Plugins that don't
Plug 'APZelos/blamer.nvim'
Plug 'Shougo/context_filetype.vim'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'luochen1990/rainbow'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sbdchd/neoformat'
" Plug 'tbmreza/coc-jira-complete', {'branch': 'fix-deprecation-warning', 'do': 'yarn install --frozen-lockfile'}
Plug 'tbmreza/vim-context-commentstring'
Plug 'tbmreza/vim-sandwich'
Plug 'tomtom/tcomment_vim'
Plug 'tyru/open-browser.vim'
Plug 'yardnsm/vim-import-cost', { 'do': 'npm install --production' }
Plug 'wesQ3/vim-windowswap'
" Languages support
Plug 'benknoble/vim-racket'
Plug 'joereynolds/SQHell.vim'
Plug 'pechorin/any-jump.vim'
" Plug 'non25/vim-svelte'
Plug 'leafOfTree/vim-svelte-plugin'
Plug 'rhysd/reply.vim', { 'on': ['Repl', 'ReplAuto'] }
Plug 'rust-lang/rust.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tbmreza/Coqtail'
Plug 'yuezk/vim-js'
" Neovim 'bug' patches
Plug 'gioele/vim-autoswap'
Plug 'tpope/vim-repeat'
Plug 'dbakker/vim-paragraph-motion'
call plug#end()
