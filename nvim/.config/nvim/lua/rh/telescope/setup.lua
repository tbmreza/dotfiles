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

-- remaps in separate file?
vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap

map("n", "<leader>t", ":Telescope<space>", { noremap = true })
map("n", "<c-p>", ":Telescope find_files<cr>", { noremap = true })
map("n", "<c-f>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", { noremap = true })
