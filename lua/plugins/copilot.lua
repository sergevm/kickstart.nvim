local logger = {
  file = vim.fn.stdpath 'log' .. '/copilot-lua.log',
  file_log_level = vim.log.levels.OFF,
  print_log_level = vim.log.levels.WARN,
  trace_lsp = 'off', -- "off" | "messages" | "verbose"
  trace_lsp_progress = false,
  log_lsp_messages = false,
}

-- Dynamically detect node command (respects current nvm version)
local function get_node_command()
  local nvm_bin = os.getenv 'NVM_BIN'
  if nvm_bin and vim.fn.executable(nvm_bin .. '/node') == 1 then
    return nvm_bin .. '/node'
  end
  -- Fallback: use which node
  local node_path = vim.fn.system('which node'):gsub('\n', '')
  if vim.fn.executable(node_path) == 1 then
    return node_path
  end
  -- Last resort: use plain node
  return 'node'
end

return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',

  config = function()
    require('copilot').setup {

      copilot_node_command = get_node_command(), -- Node.js version must be > 22

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

      should_attach = function(bufnr, bufname)
        -- disable for large files
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
        if ok and stats and stats.size > 1024 * 1024 then -- 1MB
          return false
        end

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
