local buffer = 0 -- current buffer
local opts = { noremap = true, silent = true }

vim.api.nvim_buf_set_keymap(
	buffer,
	"v", -- mode
	"<leader>dd", -- shorthand
	[[yoIO.inspect(<c-r>0)<esc>]],
	opts
)

vim.api.nvim_buf_set_keymap(
	buffer,
	"n", -- mode
	"<leader>dd", -- shorthand
	[[yiwoIO.inspect(<c-r>0)<esc>]],
	opts
)
