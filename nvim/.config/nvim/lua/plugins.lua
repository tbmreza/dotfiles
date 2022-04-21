local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
-- Appearence
Plug 'nvim-lualine/lualine.nvim'
Plug 'itchyny/vim-gitbranch' -- lightline component
Plug 'josa42/vim-lightline-coc'
Plug 'tbmreza/lightline.vim'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc' -- xolox dependency
-- Switch using `:NextColorScheme`.
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'rhysd/vim-color-spring-night'
Plug 'savq/melange'
-- Plugins that use dedicated split/modal
Plug 'junegunn/gv.vim' -- commit history
Plug 'junegunn/vim-peekaboo' -- peek registers
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = 'TSUpdate' })
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
Plug 'simnalamburt/vim-mundo' -- undo history
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
-- Plugins that don't
Plug 'APZelos/blamer.nvim'
Plug 'Shougo/context_filetype.vim'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'luochen1990/rainbow'
Plug 'mattn/emmet-vim'
Plug('neoclide/coc.nvim', { branch = 'release' })
Plug 'sbdchd/neoformat'
-- Plug 'tbmreza/coc-jira-complete', {'branch': 'fix-deprecation-warning', 'do': 'yarn install --frozen-lockfile'}
Plug 'tbmreza/vim-context-commentstring'
Plug 'tbmreza/vim-sandwich'
Plug 'tomtom/tcomment_vim'
Plug 'tyru/open-browser.vim'
Plug('yardnsm/vim-import-cost', { ['do'] = 'npm install --production' })
Plug 'wesQ3/vim-windowswap'
-- Languages support
Plug 'benknoble/vim-racket'
Plug 'joereynolds/SQHell.vim'
Plug 'pechorin/any-jump.vim'
-- Plug 'non25/vim-svelte'
Plug 'leafOfTree/vim-svelte-plugin'
Plug 'rust-lang/rust.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tbmreza/Coqtail'
Plug 'yuezk/vim-js'
-- Neovim 'bug' patches
Plug 'gioele/vim-autoswap'
Plug 'tpope/vim-repeat'
Plug 'dbakker/vim-paragraph-motion'
vim.call('plug#end')
