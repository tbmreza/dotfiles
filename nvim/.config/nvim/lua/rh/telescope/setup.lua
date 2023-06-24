-- telescope switch picker while keeping query. watch: issues such as https://github.com/nvim-telescope/telescope.nvim/issues/2467
-- telescope ripgrep syntax. aka live_grep_args
vim.cmd([[
	autocmd User TelescopePreviewerLoaded setlocal wrap
]])

local my_opts = {
	-- defaults = {
	-- 	-- As a more permanent way of passing arguments to rg (used by live_grep and
	-- 	-- grep_string), define this option.
	-- 	vimgrep_arguments = {
	-- 		"rg",
	-- 		"--color=never",
	-- 		"--no-heading",
	-- 		"--with-filename",
	-- 		"--line-number",
	-- 		"--column",
	-- 		"--smart-case",
	-- 		-- Search ignored files, but not hidden and binary files.
	-- 		"-u"
	-- 	}
	-- },
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false
			}
		}
	},
	pickers = {
		spell_suggest = {
			layout_config = {
				width = 0.3,
			},
		},
		live_grep = {
			disable_coordinates = true,
		},
		grep_string = {
			disable_coordinates = true,
		},
	},
	extensions = {
		live_grep_args = {
			disable_coordinates = true,
		},
	},
}

require("telescope").setup(my_opts)
-- c-f fuzzy by default?
require("telescope").load_extension("fzf")
require("telescope").load_extension("frecency")

-- remaps in separate file?
vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap

map("n", "<leader>t", ":Telescope<space>", { noremap = true })
map("n", "<c-p>", ":Telescope find_files<cr>", { noremap = true })
-- <<<<<<< HEAD
-- map("n", "<c-f>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", { noremap = true })
-- =======
-- map("n", "<c-p>", ":Telescope frecency<cr>", { noremap = true })
-- map("n", "<c-f>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", { noremap = true })
-- PICKUP solve a real <c-f> hassle
map("n", "<leader>8", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", { noremap = true })
-- map("n", "<c-f>", ":Telescope grep_string<cr>", { noremap = true })
map("n", "<c-f>", ":Telescope live_grep<cr>", { noremap = true })

-- -- verifying that iswap doesn't need this:
-- require'nvim-treesitter.configs'.setup {
--   textobjects = {
--     swap = {
--       enable = true,
--       swap_next = {
--         ["<leader>a"] = "@parameter.inner",
--       },
--       swap_previous = {
--         ["<leader>A"] = "@parameter.inner",
--       },
--     },
--   },
-- }

require("rest-nvim").setup({
  -- Open request results in a horizontal split
  result_split_horizontal = false,
  -- Keep the http file buffer above|left when split horizontal|vertical
  result_split_in_place = false,
  -- Skip SSL verification, useful for unknown certificates
  skip_ssl_verification = false,
  -- Highlight request on run
  highlight = {
      enabled = true,
      timeout = 150,
  },
  -- Jump to request line on run
  jump_to_request = false,
  env_file = '.env',
  yank_dry_run = true,
})
