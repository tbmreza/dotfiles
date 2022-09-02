local Plug = vim.fn["plug#"]

vim.call("plug#begin", "~/.config/nvim/plugged")
-- Appearence
Plug("nvim-lualine/lualine.nvim")
Plug("itchyny/vim-gitbranch") -- lightline component
Plug("josa42/vim-lightline-coc")
Plug("tbmreza/lightline.vim")
Plug("xolox/vim-colorscheme-switcher")
Plug("xolox/vim-misc") -- xolox dependency
-- Switch using `:NextColorScheme`.
Plug("arcticicestudio/nord-vim")
Plug("morhetz/gruvbox")
Plug("rhysd/vim-color-spring-night")
Plug("savq/melange")
-- Plugins that use dedicated split/modal
Plug("AndrewRadev/linediff.vim")
Plug("junegunn/gv.vim") -- commit history
Plug("junegunn/vim-peekaboo") -- peek registers
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = "TSUpdate" })
Plug("nvim-lua/plenary.nvim") -- telescope dependency
Plug("nvim-telescope/telescope.nvim", { tag = "0.1.0" })
Plug("nvim-telescope/telescope-fzf-native.nvim", { ["do"] = "make" })
Plug("nvim-telescope/telescope-live-grep-args.nvim")
Plug("liuchengxu/vista.vim")
Plug("simnalamburt/vim-mundo") -- undo history
Plug("tpope/vim-fugitive")
Plug("vim-denops/denops.vim")
-- Plug("lambdalisue/gin.vim")  -- unusable wip
Plug("lambdalisue/gina.vim")
Plug("tpope/vim-vinegar")
-- Plugins that don't
Plug("APZelos/blamer.nvim")
Plug("Shougo/context_filetype.vim")
Plug("Yggdroot/indentLine")
Plug("airblade/vim-gitgutter")
Plug("christoomey/vim-tmux-navigator")
Plug("luochen1990/rainbow")
Plug("mattn/emmet-vim")
Plug("neoclide/coc.nvim", { branch = "release" })
-- Plug("nvim-treesitter/nvim-treesitter-context")
Plug("wellle/context.vim")
Plug("sbdchd/neoformat")
Plug("tbmreza/vim-context-commentstring")
Plug("tbmreza/vim-sandwich")
Plug("tomtom/tcomment_vim")
Plug("tyru/open-browser.vim")
Plug("yardnsm/vim-import-cost", { ["do"] = "npm install --production" })
Plug("wesQ3/vim-windowswap")
-- Languages support
Plug("benknoble/vim-racket")
Plug("iamcco/markdown-preview.nvim", { ["do"] = "cd app && yarn install" })
Plug("joereynolds/SQHell.vim")
Plug("pechorin/any-jump.vim")
-- Plug 'non25/vim-svelte'
Plug("leafOfTree/vim-svelte-plugin")
Plug("rust-lang/rust.vim")
Plug("sheerun/vim-polyglot")
Plug("tbmreza/Coqtail")
Plug("yuezk/vim-js")
-- Neovim 'bug' patches
Plug("gioele/vim-autoswap")
Plug("tpope/vim-repeat")
Plug("dbakker/vim-paragraph-motion")
Plug("tbmreza/tethys", { branch = "nvim-plugin", rtp = "support/vim-tethys" })
-- Plug("~/work/pltd-contrib/tethys/support/vim-tethys")
vim.call("plug#end")
