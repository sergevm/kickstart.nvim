return {
  'ellisonleao/glow.nvim',
  cmd = { 'Glow' },
  config = function()
    require('glow').setup()
  end,
  keys = {
    { '<leader>gl', '<cmd>Glow<cr>', desc = 'Glow markdown preview' },
  },
}
