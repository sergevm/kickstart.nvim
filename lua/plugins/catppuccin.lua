return {
  'catppuccin/nvim',
  name = 'catppuccin',
  enabled = true,
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
