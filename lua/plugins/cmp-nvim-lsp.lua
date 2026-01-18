return {
  'hrsh7th/cmp-nvim-lsp',
  lazy = false,
  dependencies = {
    'neovim/nvim-lspconfig',
  },
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    vim.lsp.config.gopls = vim.tbl_extend('force', vim.lsp.config.gopls or {}, {
      capabilities = capabilities,
    })
  end,
}
