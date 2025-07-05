return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    require('mini.surround').setup()
    require('mini.bracketed').setup()
    require('mini.move').setup()
  end,
}
