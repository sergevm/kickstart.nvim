return {
  'zbirenbaum/copilot-cmp',
  event = 'InsertEnter',
  dependencies = {
    'zbirenbaum/copilot.lua',
  },
  config = function()
    require('copilot_cmp').setup {
      -- Not enabling write now, first want to test the inline suggestions
      enable = false,
      formatters = {
        insert_text = require('copilot_cmp.format').format_insert_text,
      },
    }
  end,
}
