return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    require('mini.surround').setup()
    require('mini.bracketed').setup() -- In ITerm2, I set the left option key no map to Meta instead of Normal. Revert this if it causes problems
    require('mini.move').setup()
  end,
}
