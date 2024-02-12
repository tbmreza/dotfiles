-- ??
-- https://github.com/nvim-lualine/lualine.nvim
-- zsh path /home/tbmreza/.cabal/bin/agda-mode
-- cargo t, c. general lang-mode? t for tool
--   <leader>tt run
--   <leader>t? echoes something (MerlinTypeOfSel)

-- agda: comment,  use emacs
-- stack ghci template: doesn't care about exe, just reloading lib in repl  use emacs
-- tame fugitive X  use dedicated clients like gitbutler
-- undo X on untracked files  fugitive
-- buffer maps g; g. g,  done
-- conflict <c-k>, <leader>e  done
-- ocp-indent  no problem so far

-- undo closed pane
-- :{vs,sp,tabe} +Nbuf

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("plugins")
require("rh.pickers")
require("rh.telescope.setup")

vim.cmd.colorscheme 'melange'  -- melange kanagawa

-- overriden by after/ftplugin
vim.opt.shiftwidth=2 -- >> and << read this
vim.opt.tabstop=2

local o = vim.opt
local wo = vim.wo
local bo = vim.bo

is_wsl = vim.loop.os_uname().release:lower():find('wsl')

o.tildeop = true
o.hidden = true
o.updatetime = 200
wo.cursorline = true
wo.wrap = false
wo.nu = true
wo.rnu = true
o.mouse = "nicr"
o.clipboard = "unnamedplus"

if is_wsl then
-- See :h clipboard-wsl
vim.cmd([[
    let g:clipboard = {
                \   'name': 'WslClipboard',
                \   'copy': {
                \      '+': '/mnt/c/Windows/system32/clip.exe',
                \      '*': '/mnt/c/Windows/system32/clip.exe',
                \    },
                \   'paste': {
                \      '+': '/mnt/c/Windows/System32/WindowsPowerShell/v1.0//powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \      '*': '/mnt/c/Windows/System32/WindowsPowerShell/v1.0//powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \   },
                \   'cache_enabled': 0,
                \ }
]])
end

-- lua eof error on setup
-- -- begin
-- local M = {}
--
-- local augroup = vim.api.nvim_create_augroup("deferClip", {})
--
-- local entries = {
--   first = 1,
--   last = 1,
-- }
-- local active_entry = {}
--
-- local function add_entry(entry)
--   entries[entries.last] = entry
--   entries.last = entries.last + 1
-- end
--
-- local function pop_entry()
--   if entries.first < entries.last then
--     local entry = entries[entries.first]
--     entries[entries.first] = nil
--     entries.first = entries.first + 1
--     return entry
--   end
-- end
--
-- local function sync_from()
--   vim.fn.jobstart({ "win32yank.exe", "-o", "--lf" }, {
--     stdout_buffered = true,
--     on_stdout = function(_, data)
--       active_entry = { lines = data, regtype = "v" }
--     end,
--   })
-- end
--
-- local sync_to
-- do
--   local cur_sync_job
--   local function sync_next(entry)
--     local chan = vim.fn.jobstart({ "win32yank.exe", "-i" }, {
--       on_exit = function(_)
--         local next_entry = pop_entry()
--         if next_entry then
--           sync_next(next_entry)
--         else
--           cur_sync_job = nil
--         end
--       end,
--     })
--     cur_sync_job = chan
--     vim.fn.chansend(chan, entry.lines)
--     vim.fn.chanclose(chan, "stdin")
--   end
--
--   sync_to = function()
--     if cur_sync_job then
--       return
--     else
--       local entry = pop_entry()
--       if entry then
--         sync_next(entry)
--       end
--     end
--   end
-- end
--
-- function M.copy(lines, regtype)
--   add_entry({ lines = lines, regtype = regtype })
--   active_entry = { lines = lines, regtype = regtype }
--   sync_to()
-- end
--
-- function M.get_active()
--   return { active_entry.lines, active_entry.regtype }
-- end
--
-- function M.setup()
--   vim.api.nvim_exec(
--     [[
--     function s:copy(lines, regtype)
--       call luaeval('require("core.vim.deferclip").copy(_A[1], _A[2])', [a:lines, a:regtype])
--     endfunction
--     function s:get_active()
--       call luaeval('require("core.vim.deferclip").get_active()')
--     endfunction
--
--     let g:clipboard = {
--           \   'name': 'deferClip',
--           \   'copy': {
--           \      '+': {lines, regtype -> s:copy(lines, regtype)},
--           \      '*': {lines, regtype -> s:copy(lines, regtype)},
--           \    },
--           \   'paste': {
--           \      '+': {-> s:get_active()},
--           \      '*': {-> s:get_active()},
--           \   },
--           \ }
--   ]],
--     false
--   )
--   vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
--     group = augroup,
--     callback = sync_from,
--   })
-- end
--
-- return M
--
-- -- finish

o.ignorecase = true
o.smartcase = true
bo.formatoptions = "jcql"
o.list = true
o.listchars = "eol:¬,tab:▸ "
o.termguicolors = true
o.sidescroll = 1
o.sidescrolloff = 10

local def = vim.api.nvim_create_user_command
def("Vimrc", "tabe $HOME/dotfiles/nvim/.config/nvim/init.lua", { nargs = 0 })
def("PlugEdit", "tabe $HOME/dotfiles/nvim/.config/nvim/lua/plugins.lua", { nargs = 0 })
def("Up", "cd ..", { nargs = 0 })
def("Back", "cd -", { nargs = 0 })
def("Scroll", "windo set scrollbind", { nargs = 0 })
def("ScrollOff", "windo set scrollbind!", { nargs = 0 })
def("PwdYank", 'let @+ = expand("%")', { nargs = 0 })
def("Com", "Git log | Git commit", { nargs = 0 })
def("PersonalCom", 'Git log | Git commit --author="Reza <rezahandzalah@gmail.com>"', { nargs = 0 })
-- testing workflow:
-- def("PersonalEmailCommitAmend", 'Git commit --amend --author="Reza <rezahandzalah@gmail.com>"', { nargs = 0 })
def("PersonalRemoteRepoPush", 'Git push https://@github.com/tbmreza/<f-args>.git', { nargs = 1 })
def("Cmd", "FlowLauncher", { nargs = 0 })
vim.cmd([[
  command! OpenBrowserCurrent execute "OpenBrowser" "file:///" . expand('%:p:gs?\\?/?')
]])

-- remaps in separate file?
vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap

-- Out of the box, gh enters Select-mode.
-- Remap as "global highlight":
--   ghh highlights non ascii.
--   gh? highlights ??. Extra nice because # or * doesn't work.
--
--map("n", "ghh", "/[^\x00-\x7F]", { noremap = true })  -- this lua panics
vim.cmd([[
map ghh /[^\x00-\x7F]<cr>
map gh? /??<cr>
]])

-- :h emacs-keys
map("c", "<c-a>", "<Home>", { noremap = true })
map("c", "<c-b>", "<Left>", { noremap = true })  -- effectively <c-bb> because tmux
map("c", "<c-d>", "<Del>", { noremap = true })
map("c", "<c-e>", "<End>", { noremap = true })
map("c", "<c-f>", "<Right>", { noremap = true })
map("c", "<esc><c-b>", "<s-Left>", { noremap = true })  -- effectively <c-bb> because tmux
map("c", "<esc><c-f>", "<s-Right>", { noremap = true })
-- full emacs-keys in command mode or bash c-w aliases to alt backspace

map("t", "<f4>", "<c-\\><c-n>", { noremap = true })

-- Merge conflicts by diffing vertically (dv)
map("n", "<leader>vj", ":diffget //3<cr>", { noremap = false })
map("n", "<leader>vf", ":diffget //2<cr>", { noremap = false })

-- Abort sandwich
map("n", "s<esc>", "<nop>", { noremap = true, silent = true })
map("n", "s<leader>", "<nop>", { noremap = true, silent = true })

-- Must have typed this by mistake
map("n", "ZZ", "<nop>", { noremap = true })
map("n", "-", "<nop>", { noremap = true })
map("i", "<c-j>", "<nop>", { noremap = true })
map("i", "<c-v>", "<nop>", { noremap = true })
map("n", "<leader>a", "<nop>", { noremap = true })
map("n", "<s-k>", "<nop>", { noremap = true })

-- Move lines, args
map("n", "<c-j>", ":m .+1<CR>==", { noremap = true })
map("n", "<c-k>", ":m .-2<CR>==", { noremap = true })
map("v", "<c-j>", ":m '>+1<CR>gv=gv", { noremap = true })
map("v", "<c-k>", ":m '<-2<CR>gv=gv", { noremap = true })
map("n", "<c-h>", ":ISwapWith<cr>", { noremap = true })

-- IDE
map("n", "<leader>b", ":Vexplore<cr>", { noremap = true })
-- Terminal command integration
map("n", "<leader>r", ":FlowLauncher<cr>", { noremap = true })
map("n", "<leader>g", ":Git<space>", { noremap = true })
-- map("n", "<leader>c", ":Cargo<space>", { noremap = true })
-- if cwd has Cargo.toml:
map("n", "<leader>r", ":! cargo c<cr>", { noremap = true })

map("n", "<leader>hh", ':lua require("harpoon.ui").toggle_quick_menu()<cr>', { noremap = true })
map("n", "<leader>ha", ':lua require("harpoon.mark").add_file()<cr>', { noremap = true })
map("n", "<leader>hn", ':lua require("harpoon.ui").nav_next()<cr>', { noremap = true })
map("n", "<leader>hp", ':lua require("harpoon.ui").nav_prev()<cr>', { noremap = true })

-- gitgutter
map("n", "]]", ":GitGutterStageHunk<cr>", { noremap = true })
map("n", "[[", ":GitGutterUndoHunk<cr>", { noremap = true })
map("n", "]o", ":GitGutterPreviewHunk<cr>", { noremap = true })
map("n", "<leader>hp", "<nop>", { noremap = true })

vim.cmd([[
  autocmd FileType harpoon    nnoremap <buffer> <C-c> <cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>
]])

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

-- -- Plugin: vista
-- vim.g["vista#renderer#enable_icon"] = 0
-- vim.cmd([[
--   function! NearestMethodOrFunction() abort
--     return get(b:, 'vista_nearest_method_or_function', '')
--   endfunction
--   autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
-- ]])

-- -- gitgutter
-- map("n", "]]", ":GitGutterStageHunk<cr>", { noremap = true })
-- map("n", "[[", ":GitGutterUndoHunk<cr>", { noremap = true })
-- map("n", "]o", ":GitGutterPreviewHunk<cr>", { noremap = true })
-- map("n", "<leader>hp", "<nop>", { noremap = true })

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
vim.g.lightline = {  -- ??
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

vim.cmd([[
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

-- -- Plugin: coc
-- map("n", "gd", "<Plug>(coc-definition)", { noremap = false })
-- map("n", "gy", "<Plug>(coc-type-definition)", { noremap = false })
-- map("n", "gi", "<Plug>(coc-implementation)", { noremap = false })
-- map("n", "gr", "<Plug>(coc-references)", { noremap = false })
-- map("n", "<f2>", "<Plug>(coc-rename)", { noremap = false })

-- Plugin: blamer
vim.g.blamer_enabled = 1
vim.g.blamer_show_in_visual_modes = 0
vim.g.blamer_show_in_insert_modes = 0

-- Plugin: rainbow
vim.g.rainbow_active = 0

-- Plugin: neoformat
vim.g.neoformat_only_msg_on_error = 1
vim.g.neoformat_verbose = 0
vim.g.neoformat_try_formatprg = 1
-- map("n", "<leader>f", ":Neoformat<cr>", { noremap = false })
map("n", "<leader>f", ":echo 'nop'<cr>", { noremap = false })
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

-- Closing pair
map("i", '"', '""<left>', { noremap = true })
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

map("n", "<m-c>", "<c-w>c", { noremap = true })
map("n", "<m-s-t>", "<c-w><s-t>", { noremap = true })

-- Leader grouped
map("n", "<leader>e", "<nop>", { noremap = true, silent = false })
map("n", "<leader>fe", ":e!<cr>", { noremap = true })
map("n", "<leader>s", "<nop>", { noremap = true })
map("n", "<leader>S", "<nop>", { noremap = true })
map("n", "<leader>fs", ":w<cr>", { noremap = true })

-- Buffer editing
map("v", "//", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>", { noremap = true })
map("n", "mm", "yygccp", { noremap = false })
map("v", "m", "ygvgcp", { noremap = false })
map("n", "Y", "y$", { noremap = true })
map("n", "g;", "<s-a>;<esc>", { noremap = true })
map("n", "g.", "<s-a>.<esc>", { noremap = true })
map("n", "g,", "<s-a>,<esc>", { noremap = true })
map("n", "g?", "<s-a>?<esc>", { noremap = true })
map("n", "gcp", "<s-O>PICKUP <esc>gcc<s-A>", { noremap = false })
map("n", "gc?", "<s-A><space><space>??<esc>gciw2f?", { noremap = false })

map("n", "<esc><esc>", ":nohlsearch<cr>", { noremap = true, silent = true })
map("t", "<esc><esc>", "<C-\\><C-n>", { noremap = true, silent = true })

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
vim.g.colorscheme_switcher_exclude_builtins = 1  -- ??

-- ok:
-- local lspconfig = require('lspconfig')
-- lspconfig.pyright.setup {}
-- lspconfig.rust_analyzer.setup {}
--
-- local servers = { 'pyright', 'racket_langserver', 'clangd', 'rust_analyzer', 'tsserver' }

-- ocaml user-setup install
vim.cmd([[
set rtp^="/home/tbmreza/.opam/default/share/ocp-indent/vim"

let g:opamshare = substitute(system('opam var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
]])

require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

  end
}
