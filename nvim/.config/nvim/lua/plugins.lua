require('lazy').setup({
	{
		'Julian/lean.nvim',
		event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

		dependencies = {
			'neovim/nvim-lspconfig',
			'nvim-lua/plenary.nvim',

			-- optional dependencies:

			-- a completion engine
			--    hrsh7th/nvim-cmp or Saghen/blink.cmp are popular choices

			-- 'nvim-telescope/telescope.nvim', -- for 2 Lean-specific pickers
			-- 'andymass/vim-matchup',          -- for enhanced % motion behavior
			-- 'andrewradev/switch.vim',        -- for switch support
			-- 'tomtom/tcomment_vim',           -- for commenting
		},

		---@type lean.Config
		opts = { -- see below for full configuration options
			mappings = true,
		}
	},
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5'
                                -- , branch = '0.1.x'  -- or branch
                                   , dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'numToStr/Comment.nvim', opts = {}, lazy = false, },
  { 'dbakker/vim-paragraph-motion' },
  { 'neovim/nvim-lspconfig' },
  { 'lewis6991/gitsigns.nvim' },
  { 'tpope/vim-fugitive' },
  { 'leafOfTree/vim-svelte-plugin' },
  { 'rescript-lang/vim-rescript', ft="rescript" },
  { 'chaoren/vim-wordmotion' },  -- multiple words: CamelCaseACRONYMWords_underscore1234
  -- { 'mangelozzi/rgflow.nvim' },

  {
    'nvim-lualine/lualine.nvim',
    -- dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  -- {
  --   'mrcjkb/haskell-tools.nvim',
  --   version = '^4', -- Recommended
  --   lazy = false, -- This plugin is already lazy
  -- },
  { 'jecaro/ghcid-error-file.nvim' },
  { 'luc-tielen/telescope_hoogle' },

  { 'tbmreza/vim-sandwich' },  -- commit: bracket with spaces as default
  -- { 'https://gitlab.com/tbmreza/lightline.vim', branch = 'reza' },  -- commit: display parent in tab filename
  -- { 'tbmreza/lightline.vim' },  -- commit: display parent in tab filename
  -- { 'itchyny/lightline.vim' },

  -- colorschemes
  { 'rebelot/kanagawa.nvim' },
  { 'savq/melange-nvim' },

  {
    'hrsh7th/nvim-cmp',
    -- load cmp on InsertEnter
    event = 'InsertEnter',
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
    },
  },
})

-- nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

-- Server names at https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md;
-- search for: require'lspconfig'.
local servers = {
	'rescriptls', 'ocamllsp', 'pyright', 'racket_langserver', 'clangd', 'rust_analyzer', 'tsserver',
	'svelte',
  -- 'hls'
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  },
}
