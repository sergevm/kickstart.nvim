return {
  'zbirenbaum/copilot-cmp',
  event = 'InsertEnter',
  dependencies = {
    'zbirenbaum/copilot.lua',
  },
  config = function()
    require('copilot_cmp').setup {
      enable = true,
      formatters = {
        insert_text = require('copilot_cmp.format').format_insert_text,
      },
    }
  end,
}
