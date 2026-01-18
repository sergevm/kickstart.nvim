local logger = {
  file = vim.fn.stdpath 'log' .. '/copilot-lua.log',
  file_log_level = vim.log.levels.OFF,
  print_log_level = vim.log.levels.WARN,
  trace_lsp = 'off', -- "off" | "messages" | "verbose"
  trace_lsp_progress = false,
  log_lsp_messages = false,
}
return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',

  config = function()
    require('copilot').setup {

      copilot_node_command = vim.fn.expand '$HOME' .. '/.nvm/versions/node/v24.1.0/bin/node', -- Node.js version must be > 22

      suggestion = {
        enabled = false, -- set to false if you enable copilot-cmp.lua
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = '<Tab>',
          next = '<C-n>',
          prev = '<C-p>',
          dismiss = '<C-c>',
        },
      },

      filetypes = {
        ['*'] = true,
        ['markdown'] = false,
        ['text'] = false,
        ['TelescopePrompt'] = false,
        ['toggleterm'] = false,
        ['help'] = false,
        ['qf'] = false,
        ['Trouble'] = false,
      },

      logger = logger,

      panel = {
        enabled = false,
      },

      should_attach = function(_, bufname)
        if string.match(bufname, 'env') then
          return false
        end
        if not vim.bo.buflisted then
          return false
        end

        if vim.bo.buftype ~= '' then
          return false
        end

        return true
      end,
    }
  end,
}
