local Plug = vim.fn["plug#"]

vim.call("plug#begin", "~/.config/nvim/plugged")
-- Appearence
Plug("nvim-lualine/lualine.nvim")
Plug("itchyny/vim-gitbranch") -- lightline component
Plug("josa42/vim-lightline-coc")
Plug("tbmreza/lightline.vim")
Plug("xolox/vim-colorscheme-switcher")
Plug("xolox/vim-misc") -- xolox dependency. move to packer?
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
Plug("nvim-treesitter/nvim-treesitter-textobjects")
Plug("nvim-lua/plenary.nvim") -- telescope dependency
-- Plug("nvim-telescope/telescope.nvim", { tag = "0.1.0" })
Plug("nvim-telescope/telescope-fzf-native.nvim", { ["do"] = "make" })
-- frecency
Plug("kkharji/sqlite.lua")
Plug("nvim-telescope/telescope-frecency.nvim")
Plug("liuchengxu/vista.vim")
Plug("simnalamburt/vim-mundo") -- undo history
Plug("tpope/vim-fugitive")
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
Plug("elixir-editors/vim-elixir")
Plug("benknoble/vim-racket")
Plug("iamcco/markdown-preview.nvim", { ["do"] = "cd app && yarn install" })
-- Plug("joereynolds/SQHell.vim")
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
-- Dev
Plug("tbmreza/tethys", { branch = "nvim-plugin", rtp = "support/vim-tethys" })
-- Plug("~/work/pltd-contrib/tethys/support/vim-tethys")
vim.call("plug#end")

return require("packer").startup(function(use)
	-- packer manages itself as a package.
	-- ~/.local/share/nvim/site/pack/packer/start/packer.nvim
	use("wbthomason/packer.nvim")

	use("tpope/vim-dadbod")

	-- adding telescope-live-grep-args:
	-- use({
	-- 	"nvim-telescope/telescope.nvim",
	-- 	tag = "0.1.1",
	-- 	requires = { { "nvim-lua/plenary.nvim" } },
	-- })

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
		},
		config = function()
			require("telescope").load_extension("live_grep_args")
		end,
	})

	use("arjunmahishi/flow.nvim")

	use("mizlan/iswap.nvim")

	use({
		"rest-nvim/rest.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		-- import just the function? move the whole packer statement?
		config = function()
			require("rest-nvim").setup({
				-- Open request results in a horizontal split
				result_split_horizontal = false,
				-- Keep the http file buffer above|left when split horizontal|vertical
				result_split_in_place = false,
				-- Skip SSL verification, useful for unknown certificates
				skip_ssl_verification = false,
				-- Encode URL before making request
				encode_url = true,
				-- Highlight request on run
				highlight = {
					enabled = true,
					timeout = 150,
				},
				result = {
					-- toggle showing URL, HTTP info, headers at top the of result window
					show_url = true,
					show_http_info = true,
					show_headers = true,
					-- executables or functions for formatting response body [optional]
					-- set them to false if you want to disable them
					formatters = {
						json = "jq",
						html = function(body)
							return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
						end,
					},
				},
				-- Jump to request line on run
				jump_to_request = false,
				env_file = ".env",
				custom_dynamic_variables = {},
				yank_dry_run = true,
			})
		end,
	})
end)
