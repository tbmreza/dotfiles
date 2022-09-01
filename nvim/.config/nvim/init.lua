require("plugins")
require("tbmreza.rust")

local o = vim.opt
local wo = vim.wo
local bo = vim.bo

o.hidden = true
o.updatetime = 200
wo.cursorline = true
wo.wrap = false
wo.nu = true
wo.rnu = true
o.mouse = "nicr"
o.clipboard = "unnamedplus"
o.ignorecase = true
o.smartcase = true
bo.formatoptions = "jcql"
o.list = true
o.listchars = "eol:¬,tab:▸\\"
o.termguicolors = true
o.sidescroll = 1
o.sidescrolloff = 10

local def = vim.api.nvim_create_user_command
def("Vimrc", "tabe $HOME/dotfiles/nvim/.config/nvim/init.lua", { nargs = 0 })
def("PlugEdit", "vs $HOME/dotfiles/nvim/.config/nvim/lua/plugins.lua", { nargs = 0 })
def("Up", "cd ..", { nargs = 0 })  -- repeating with @: or @@ doesn't print current dir
def("Back", "cd -", { nargs = 0 })
def("Scroll", "windo set scrollbind", { nargs = 0 })
def("ScrollOff", "windo set scrollbind!", { nargs = 0 })
def("Pwd", 'let @+ = expand("%")', { nargs = 0 })
def("Com", "Git log | Git commit", { nargs = 0 })

-- remaps in separate file?
vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap

map("t", "<f4>", "<c-\\><c-n>", { noremap = true })

-- Merge conflicts by diffing vertically (dv)
map("n", "<leader>gj", ":diffget //3<cr>", { noremap = false })
map("n", "<leader>gf", ":diffget //2<cr>", { noremap = false })

-- Abort sandwich
map("n", "s<esc>", "<nop>", { noremap = true, silent = true })

-- Must have typed this by mistake
map("n", "ZZ", "<nop>", { noremap = true })
map("n", "-", "<nop>", { noremap = true })
map("i", "<c-v>", "<nop>", { noremap = true })

-- Move lines
map("n", "<c-j>", ":m .+1<CR>==", { noremap = true })
map("n", "<c-k>", ":m .-2<CR>==", { noremap = true })
map("v", "<c-j>", ":m '>+1<CR>gv=gv", { noremap = true })
map("v", "<c-k>", ":m '<-2<CR>gv=gv", { noremap = true })

-- IDE
-- map("n", "<leader>x", ":sp<cr>:SQHExecuteFile<cr>", { noremap = true })
map("n", "<leader>b", ":Vexplore<cr>", { noremap = true })
map("n", "<leader>t", ":Telescope<space>", { noremap = true })
map("n", "<c-p>", ":Files<cr>", { noremap = true, silent = true })
map("n", "<c-f>", ":Rg<cr>", { noremap = true, silent = true })
map("n", "<c-h>", ":History<cr>", { noremap = true, silent = true })
-- Terminal command integration
map("n", "<leader>g", ":Git<space>", { noremap = true })
map("n", "<leader>c", ":Cargo<space>", { noremap = true })

-- Cycle through tabs
map("", "<tab>", "gt", { noremap = true })
map("", "<s-tab>", "gT", { noremap = true })
map("n", "<c-d>", "<c-y>", { noremap = true })
map("n", "<c-y>", "<s-tab>", { noremap = false })
map("n", "[b", ":bprev<cr>", { noremap = false })
map("n", "]b", ":bnext<cr>", { noremap = false })

-- Horizontal scrolling
map("", "<C-ScrollWheelDown>", "10zl", { noremap = true, silent = true })
map("", "<C-ScrollWheelUp>", "10zh", { noremap = true, silent = true })

-- Plugin: context
vim.g.context_enabled = 0
vim.g.context_add_mappings = 0

-- Plugin: mundo
vim.g.mundo_help = 1
o.undofile = true
o.undodir = os.getenv("HOME") .. "/.vim/undo"
map("n", "<F5>", ":MundoToggle<cr>", { noremap = true })

-- Plugin: vista
vim.g["vista#renderer#enable_icon"] = 0
vim.cmd([[
  function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
  endfunction
  autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
]])

-- Plugin: emmet
vim.g.user_emmet_expandabbr_key = "<C-e>"
vim.g.user_emmet_mode = "i"
vim.g.user_emmet_settings = {
	racket = {
		snippets = {
			def = "(define |)",
			dis = "(displayln |)",
		},
	},
	rust = {
		snippets = {
			prin = 'println!("|");',
			fn = "fn |() { }",
			test = "#[test] fn test_sanity() { assert_eq!(12, 12); }",
			modtests = "#[cfg(test)] mod tests { use super::*;  #[test] fn test_sanity() { assert_eq!(12, 12); } }",
		},
	},
	php = {
		snippets = {
			dd = "dd( | );",
		},
	},
	javascript = {
		snippets = {
			cl = "console.log(|);",
		},
	},
}

-- Plugin: lightline
o.showtabline = 2
o.showmode = false
vim.g.lightline = {
	colorscheme = "powerlineish",
	my = {}, -- namespace for custom function
	active = {
		left = { { "mode", "paste" }, { "gitbranch" }, { "readonly", "absolutepath", "modified" }, { "method" } },
		right = { { "lineinfo" }, { "percent" }, { "filetype" } },
	},
	tabline = {
		right = { { "cocstatus" } },
	},
	mode_map = {
		n = "NOR",
		i = "INS",
		R = "REP",
		v = "VIS",
		V = "V-L",
		["C-v>"] = "V-B",
		c = "COM",
		s = "SEL",
		S = "S-L",
		["C-s>"] = "S-B",
		t = "TER",
	},
	component_function = {
		gitbranch = "FugitiveHead",
		cocstatus = "coc#status",
		method = "NearestMethodOrFunction",
	},
}

-- TODO FiletypeJavaScript() or however lua does it
vim.cmd([[
	nnoremap <leader>dd yiwoconsole.log(<c-r>0);<esc>

	syntax enable
	filetype plugin indent on

	function! FiletypeCoq()
		nmap <leader>j :CoqNext<cr>
		nmap <leader>k :CoqUndo<cr>
		nmap <leader>l :CoqToLine<cr>
	endfunction

	function! FiletypePHP()
		vnoremap <leader>dd yodd(<c-r>0);<esc>
		nnoremap <leader>dd yeodd(<c-r>0);<esc>
	endfunction

	function! FiletypeElixir()
		vnoremap <leader>dd yoIO.inspect(<c-r>0)<esc>
		nnoremap <leader>dd yeoIO.inspect(<c-r>0)<esc>
	endfunction

	autocmd filetype coq call FiletypeCoq()
	autocmd filetype php call FiletypePHP()
	autocmd filetype elixir call FiletypeElixir()
	autocmd BufRead,BufNewFile *.volt setfiletype html
	autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

	silent! call repeat#set("zfi{")
	silent! call repeat#set("zfib")
	silent! call repeat#set("zfip")
]])

-- Plugin: indentLine
vim.g.indentLine_char = "·"

-- Plugin: Coqtail
vim.g.coqtail_noimap = 1

-- Plugin: rust.vim
vim.g.rustfmt_autosave = 0

-- Plugin: coc
map("n", "gd", "<Plug>(coc-definition)", { noremap = false })
map("n", "gy", "<Plug>(coc-type-definition)", { noremap = false })
map("n", "gi", "<Plug>(coc-implementation)", { noremap = false })
map("n", "gr", "<Plug>(coc-references)", { noremap = false })
map("n", "<f2>", "<Plug>(coc-rename)", { noremap = false })

-- Plugin: blamer
vim.g.blamer_enabled = 1
vim.g.blamer_show_in_visual_modes = 0
vim.g.blamer_show_in_insert_modes = 0

-- Plugin: rainbow
vim.g.rainbow_active = 0

-- Plugin: neoformat
vim.g.neoformat_try_formatprg = 1
map("n", "<leader>f", ":Neoformat<cr>", { noremap = false })
map("v", "<leader>f", ":Neoformat!<space>", { noremap = false })

local prettier_default = {
	exe = "prettier",
	args = { "--write" },
	replace = 1,
}
--    neoformat_javascript_{formatter}
vim.g.neoformat_javascript_prettier = prettier_default
vim.g.neoformat_json5_prettier = prettier_default
vim.g.neoformat_racket_fmt = {
	exe = "raco",
	args = { "fmt", "-i" },
	replace = 1,
}
--    neoformat_enabled_{filetype} = { "{formatter}" }
vim.g.neoformat_enabled_javascript = { "prettier" }
vim.g.neoformat_enabled_json5 = { "prettier" }
vim.g.neoformat_enabled_racket = { "fmt" }

-- Plugin: SQHell
vim.g.sqh_provider = "sqlite"
local default_db = {
	database = "/Users/reza.handzalah/work/cmu-db-course/homework_sql/musicbrainz-cmudb2020.db",
}
vim.g.sqh_connections = {
	-- conn_name = db,
	default = default_db,
}

-- Closing pair
map("i", '"', '""<left>', { noremap = true })
map("i", "<", "<><left>", { noremap = true })
map("i", "(", "()<left>", { noremap = true })
map("i", "[", "[]<left>", { noremap = true })
map("i", "{", "{}<left>", { noremap = true })
map("i", "{<cr>", "{<CR>}<ESC>O", { noremap = true })

-- Window
map("n", "ç", "<c-w>c", { noremap = true })
map("n", "ˇ", "<c-w><s-t>", { noremap = true })
map("n", "≠", "<c-w>=", { noremap = true })
map("n", "˙", "<c-w>h", { noremap = false })
map("n", "∆", "<c-w>j", { noremap = false })
map("n", "˚", "<c-w>k", { noremap = false })
map("n", "¬", "<c-w>l", { noremap = false })
map("n", "¯", "4<c-w><", { noremap = true })
map("n", "˘", "4<c-w>>", { noremap = true })
map("n", "±", "4<c-w>+", { noremap = true })
map("n", "–", "4<c-w>-", { noremap = true })

vim.g.tmux_navigator_no_mappings = 1
map("n", "˙", ":TmuxNavigateLeft<cr>", { noremap = true, silent = true })
map("n", "∆", ":TmuxNavigateDown<cr>", { noremap = true, silent = true })
map("n", "˚", ":TmuxNavigateUp<cr>", { noremap = true, silent = true })
map("n", "¬", ":TmuxNavigateRight<cr>", { noremap = true, silent = true })

-- Day to day text editing
map("c", "<c-e>", ".*", { noremap = true })
map("v", "//", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>", { noremap = true })
map("n", "mm", "yygccp", { noremap = false })
map("v", "m", "ygvgcP", { noremap = false })
map("n", "Y", "y$", { noremap = true })
map("n", "<leader>e", ":e!<cr>", { noremap = true })
map("n", "<leader>s", ":w<cr>", { noremap = true })
map("n", "<leader>S", ":w<cr>", { noremap = true })
map("n", "<leader>;", "<s-a>;<esc>", { noremap = true })
map("n", "<leader>.", "<s-a>.<esc>", { noremap = true })
map("n", "<leader>,", "<s-a>,<esc>", { noremap = true })
map("n", "<leader><leader>", "<s-O>TODO <esc>:TComment<cr><s-A>", { noremap = true })
map("n", "<esc><esc>", ":nohlsearch<cr>", { noremap = true, silent = true })

-- netrw
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 2
vim.g.netrw_list_hide = ".*.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^..=/=$"
vim.g.netrw_keepdir = 0

-- svelte
vim.g.vim_svelte_plugin_load_full_syntax = 1
vim.g.vim_svelte_plugin_use_typescript = 1

-- Theme
vim.g.colorscheme_switcher_exclude_builtins = 1
vim.cmd([[
	function! SetColorscheme()
		colorscheme melange
		hi! Normal guibg=NONE ctermbg=NONE " transparent window if terminal supports it
	endfunction
	autocmd vimenter * ++nested call SetColorscheme()
]])
