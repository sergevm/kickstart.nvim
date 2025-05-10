return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  build = ':TSUpdate',
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require 'nvim-treesitter.configs'

    local disable_large_file_features = function(buf)
      local max_filesize = 1024 * 1024 * 2
      local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(buf))

      if size > max_filesize then
        vim.b[buf].large_file = true
        vim.cmd 'syntax off'
        vim.cmd 'filetype off'
        pcall(vim.treesitter.stop)

        vim.api.nvim_create_autocmd('LspAttach', {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client then
              client.stop()
            end
          end,
          buffer = buf,
        })

        vim.notify('Large file detected: disabled syntax, LSP, and Treesitter', vim.log.levels.WARN)
      end
    end

    vim.api.nvim_create_autocmd('BufReadPre', {
      callback = function(args)
        disable_large_file_features(args.buf)
      end,
    })
    -- configure treesitter
    treesitter.setup { -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      modules = {},
      auto_install = true,
      sync_install = true,
      ignore_install = {},
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        'json',
        'javascript',
        'typescript',
        'tsx',
        'yaml',
        'html',
        'css',
        'prisma',
        'markdown',
        'markdown_inline',
        'svelte',
        'graphql',
        'bash',
        'lua',
        'vim',
        'dockerfile',
        'gitignore',
        'query',
        'vimdoc',
        'c',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    }
  end,
}
