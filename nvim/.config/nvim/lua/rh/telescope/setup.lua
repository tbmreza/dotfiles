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
		find_files = {
			no_ignore = true,
			hidden = true,
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

local telescope = require('telescope')
-- telescope.setup {
--   -- opts...
-- }
telescope.load_extension('hoogle')

local map = vim.api.nvim_set_keymap

map("n", "<c-p>", ":Telescope find_files<cr>", { noremap = true })
-- map("n", "<c-f>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", { noremap = true })
map("n", "<c-f>", ":Telescope live_grep<cr>", { noremap = true })
