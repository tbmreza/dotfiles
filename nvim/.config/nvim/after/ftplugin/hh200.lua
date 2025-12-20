vim.lsp.start({
	-- cmd = { "pyright-langserver", "--stdio" },
	-- cmd = { "haskell-language-server-wrapper", "--lsp" },
	cmd = { "hh200d" },
	root_dir = vim.fn.getcwd(), -- Use PWD as project root dir.
})
