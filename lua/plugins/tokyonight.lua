return {
  'folke/tokyonight.nvim',
  enabled = false,
  lazy = false,
  priority = 1000,
  config = function()
    require('tokyonight').setup()
    vim.cmd.colorscheme 'tokyonight'
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#FFFFFF' })
  end,
}
