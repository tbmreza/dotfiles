-- haskell lsp used imports, inline inferred types
-- vis replace with spaces, map p to <c-v> in insert mode
-- remember setfiletype, html tabsize
-- search text in dir without opening nv
-- windows app specific ahk keymaps: <c-n> to keydown
-- <c-f> rg cli options; include hidden files like .gitlab-ci.yml  https://github.com/mangelozzi/rgflow.nvim#quickstart-guide-tldr
-- cargo t, c. general lang-mode? t for tool
--   <leader>tt run
--   <leader>t? echoes something (MerlinTypeOfSel)
-- <c-f> and <c-p> on the fly switching
-- https://github.com/nvim-lualine/lualine.nvim  fork
-- tame fugitive X  use dedicated clients like gitbutler
-- undo X on untracked files  gitbutler
-- https://github.com/mhartington/formatter.nvim
-- running text for clamped statusline texts
-- buffer autoclose  https://github.com/axkirillov/hbac.nvim
-- next unidirection in visual mode  plugin territory

-- EXTERNAL
-- agda: comment, zsh path /home/tbmreza/.cabal/bin/agda-mode  use emacs
-- stack ghci template: doesn't care about exe, just reloading lib in repl  use emacs

-- DONE
-- buffer maps g; g. g,
-- conflict <c-k>, <leader>e
-- <c-p> telescope hidden files like .gitlab-ci.yml
-- sensible <c-w>
-- <leader>n?: no, nO, fy, fd
-- toggle visible lsp
-- n to always next, N always prev regardless # or *
-- keyboard mash: no tags file  <c-]> nop

-- HELP
-- undo closed pane
--   :ls to get N and :{vs,sp,tabe} +Nbuf
-- search hidden
--   :Telescope find_files hidden=true no_ignore=true
-- apply macro to all lines
--   :%normal @i

vim.opt.swapfile = false

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=v11.17.5", -- latest release
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
def("Notes", "tabe $HOME/notes", { nargs = 0 })  -- ??: stow private repo
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
-- def("Cmd", "FlowLauncher", { nargs = 0 })
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

map("i", "<c-l>", "->", { noremap = true })

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
map("n", "<s-u>", "<nop>", { noremap = true })
map("n", "<c-]>", ":echo 'Ctrl-]: unconfigured lsp definition'<cr>", { noremap = true })

-- Move lines, args
map("n", "<c-j>", ":m .+1<CR>==", { noremap = true })
map("n", "<c-k>", ":m .-2<CR>==", { noremap = true })
map("v", "<c-j>", ":m '>+1<CR>gv=gv", { noremap = true })
map("v", "<c-k>", ":m '<-2<CR>gv=gv", { noremap = true })
map("n", "<c-h>", ":ISwapWith<cr>", { noremap = true })

-- IDE
map("n", "<leader>b", ":Vexplore<cr>", { noremap = true })
map("n", "<leader>bv", ":Vexplore<cr>", { noremap = true })
map("n", "<leader>bb", ":sp<cr>:cf<cr>", { noremap = true })
map("n", "<leader>g", ":Git<space>", { noremap = true })

-- gitgutter
map("n", "]]", ":GitGutterStageHunk<cr>", { noremap = true })
map("n", "[[", ":GitGutterUndoHunk<cr>", { noremap = true })
map("n", "]o", ":GitGutterPreviewHunk<cr>", { noremap = true })
map("n", "<leader>hp", "<nop>", { noremap = true })

-- ??: stage disabling
-- vim.cmd([[
--   autocmd FileType harpoon    nnoremap <buffer> <C-c> <cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>
-- ]])

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

-- map("n", "p", "i", { noremap = true })  -- ??: nvim command paste, send ctrl+v key not visual select
-- Insert actions done normally
map("n", "<leader>no", "o<esc>", { noremap = true })
map("n", "<leader>nO", "O<esc>", { noremap = true })
map("n", "<leader>nc", "cc<esc>", { noremap = true })

-- Toggles
local toggle_lsp_b = true
function toggle_lsp()
  if toggle_lsp_b then
    vim.diagnostic.disable()
    toggle_lsp_b = false
  else
    vim.diagnostic.enable()
    toggle_lsp_b = true
  end
end
map("n", "<leader>xl", "<cmd>lua toggle_lsp()<cr>", { noremap = true })

function toggle_wrap()
  if vim.o.wrap then
    vim.o.wrap = false
  else
    vim.o.wrap = true
  end
end
map("n", "<leader>xw", "<cmd>lua toggle_wrap()<cr>", { noremap = true })

-- Plugin: context
vim.g.context_enabled = 0
vim.g.context_add_mappings = 0

-- Plugin: mundo
vim.g.mundo_help = 1
o.undofile = true
o.undodir = os.getenv("HOME") .. "/.vim/undo"
map("n", "<F5>", ":MundoToggle<cr>", { noremap = true })

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

-- https://github.com/nvim-lualine/lualine.nvim
require('lualine').setup{
	options = {
		icons_enabled = false
	},
	sections = {
		lualine_a = {'mode'},
		lualine_x = {}
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

-- Plugin: indentLine
vim.g.indentLine_char = "·"

-- Plugin: rust.vim
vim.g.rustfmt_autosave = 0

-- Plugin: blamer
vim.g.blamer_enabled = 1
vim.g.blamer_show_in_visual_modes = 0
vim.g.blamer_show_in_insert_modes = 0

-- Plugin: rainbow
vim.g.rainbow_active = 0

-- Decouple nN from #*: n always moves to next, N previous
map("n", 'n', ":call search(\'\', \'W\')<CR>", { noremap = true })
map("n", 'N', ":call search(\'\', \'bW\')<CR>", { noremap = true })

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
map("n", "<leader>fy", "Gygg<c-o><c-o>", { noremap = true })
map("n", "<leader>fd", "Gdgg", { noremap = true })

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
map("v", "<space>", ":echo", { noremap = false })  -- ??: nvim visual replace with spaces

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
vim.g.colorscheme_switcher_exclude_builtins = 1

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

-----------------
-- vim.lsp dev --
-----------------

vim.lsp.set_log_level("trace")

-- vim.keymap.set('n', '<leader>tc', function()
--     vim.lsp.for_each_buffer_client(0, function(client)
--         client.notify('workspace/didChangeConfiguration', {
--             settings = { testValue = "ping" }
--         })
--     end)
-- end, { desc = "Test LSP Config Change" })

vim.keymap.set('n', '<leader>tc', function()
    -- Filter for your specific server name
    local clients = vim.lsp.get_clients({ bufnr = 0, name = "hh200d" })
    if #clients == 0 then
        vim.notify("No matching LSP client found", vim.log.levels.WARN)
        return
    end
    for _, client in ipairs(clients) do
        client.notify('workspace/didChangeConfiguration', {
            settings = {
                -- This is the table that maps to your Haskell 'Config' data type
                exampleOption = "new_value",
                debugMode = true,
            }
        })
        vim.notify("LSP Config update sent to: " .. client.name)
    end
end, { desc = "LSP: Trigger Config Change" })
