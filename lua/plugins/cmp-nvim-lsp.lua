return {
  'hrsh7th/cmp-nvim-lsp',
  lazy = false,
  dependencies = {
    'neovim/nvim-lspconfig',
  },
  config = function()
    local lspconfig = require 'lspconfig'
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    lspconfig.gopls.setup {
      capabilities = capabilities,
    }
  end,
}
