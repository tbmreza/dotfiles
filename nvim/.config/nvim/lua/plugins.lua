return require("packer").startup(function(use)
	-- packer manages itself as a package.
	-- ~/.local/share/nvim/site/pack/packer/start/packer.nvim
	use("wbthomason/packer.nvim")

	use({
		"itchyny/vim-gitbranch",
		requires = { "tbmreza/lightline.vim" },
	})

	use("tpope/vim-dadbod")

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

	use({
		"ThePrimeagen/harpoon",
		requires = { "nvim-lua/plenary.nvim" },
	})

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}

	use({
		"mizlan/iswap.nvim",
		requires = { 'nvim-treesitter/nvim-treesitter' },
	})
	use("savq/melange")
	use("tomtom/tcomment_vim")
	use({
		"aserowy/tmux.nvim",
		config = function()
			local config = require("tmux").setup()
			config.navigation.enable_default_keybindings = false
			return config
		end
	})
	use("tbmreza/vim-sandwich")

	use("~/gh/telescope-thesaurus.nvim")

	use("tpope/vim-fugitive")

	use("airblade/vim-gitgutter")

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

	-- 'bug' patches
	use("dbakker/vim-paragraph-motion")

	-- Dev
	-- Plug("tbmreza/tethys", { branch = "nvim-plugin", rtp = "support/vim-tethys" })
	-- Plug("~/work/pltd-contrib/tethys/support/vim-tethys")
end)
