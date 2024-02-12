require('lazy').setup({
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

  { 'tbmreza/vim-sandwich' },  -- commit: bracket with spaces as default
  { 'tbmreza/lightline.vim' },  -- commit: display parent in tab filename
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

-- Server names at https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md;
-- search for: require'lspconfig'.
local servers = { 'ocamllsp', 'pyright', 'racket_langserver', 'clangd', 'rust_analyzer', 'tsserver' }
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
