local buffer = 0 -- current buffer
local opts = { noremap = true, silent = true }

vim.api.nvim_buf_set_keymap(
	buffer,
	"n", -- mode
	"<leader>f", -- shorthand
	[[<cmd>RustFmt<cr>]],
	opts
)

vim.api.nvim_buf_set_keymap(
	buffer,
	"n", -- mode
	"<leader>dd", -- shorthand
	[[yiwoprintlnpp!("{:?}", <c-r>0);<esc>]],
	opts
)
