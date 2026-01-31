return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
  },
  config = function()
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'
    local keymap = vim.keymap

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    local util = require 'lspconfig.util'
    local lspconfig = require 'lspconfig'

    -- set up go lsp ...
    vim.lsp.config.gopls = {
      cmd = { 'gopls' },
      filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
      root_markers = { 'go.work', 'go.mod', '.git' },
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = 'Show LSP references'
        keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts) -- show definition, references

        opts.desc = 'Go to declaration'
        keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = 'Show LSP definitions'
        keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts) -- show lsp definitions

        opts.desc = 'Show LSP implementations'
        keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts) -- show lsp implementations

        opts.desc = 'Show LSP type definitions'
        keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts) -- show lsp type definitions

        opts.desc = 'See available code actions'
        keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = 'Smart rename'
        keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = 'Show buffer diagnostics'
        keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts) -- show  diagnostics for file

        opts.desc = 'Show line diagnostics'
        keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = 'Show documentation for what is under cursor'
        keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = 'Restart LSP'
        keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts) -- mapping to restart lsp if necessary
      end,
    })

    local bicep_lsp_bin = '/usr/local/bin/bicep-langserver/Bicep.LangServer.dll'

    vim.lsp.config.svelte = {
      capabilities = capabilities,
      on_attach = function(client)
        vim.api.nvim_create_autocmd('BufWritePost', {
          pattern = { '*.js', '*.ts' },
          callback = function(ctx)
            -- Here use ctx.match instead of ctx.file
            client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.match })
          end,
        })
      end,
    }
    -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/powershell_es.lua
    vim.lsp.config.powershell_es = {
      capabilities = capabilities,
      cmd = {
        'pwsh',
        '-NoLogo',
        '-NoProfile',
        '-Command',
        vim.fn.stdpath 'data' .. '/mason/packages/powershell-editor-services/PowerShellEditorServices/Start-EditorServices.ps1',
      },
      bundle_path = vim.fn.stdpath 'data' .. '/mason/packages/powershell-editor-services',
    }
    vim.lsp.config.graphql = {
      capabilities = capabilities,
      filetypes = { 'graphql', 'gql', 'svelte', 'typescriptreact', 'javascriptreact' },
    }
    -- vim.lsp.config.emmet_ls = {
    --   capabilities = capabilities,
    --   filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte' },
    -- }
    vim.lsp.config.lua_ls = {
      capabilities = capabilities,
      settings = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { 'vim' },
          },
          completion = {
            callSnippet = 'Replace',
          },
        },
      },
    }
    lspconfig.angularls = {
      cmd = {
        vim.fn.stdpath 'data' .. '/mason/packages/angular-language-server/node_modules/.bin/ngserver',
        '--stdio',
        '--tsProbeLocations',
        vim.fn.getcwd(),
        '--ngProbeLocations',
        vim.fn.getcwd(),
      },
      on_attach = function(_, bufnr)
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
      end,
      filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx' },
      root_dir = util.root_pattern('angular.json', '.git'),
      flags = {
        debounce_text_changes = 150,
        exit_timeout = 500,
      },
    }
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#bicep
    -- https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install
    vim.lsp.config.bicep = {
      cmd = { 'dotnet', bicep_lsp_bin },
    }
    -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/azure_pipelines_ls.lua
    vim.lsp.config.azure_pipelines_ls = {
      root_markers = { 'azure-pipelines.yml', '.git' },
      settings = {
        yaml = {
          schemas = {
            ['https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json'] = {
              '/azure-pipeline*.y*l',
              '/*.azure*',
              'Azure-Pipelines/**/*.y*l',
              'Pipelines/*.y*l',
            },
          },
        },
      },
    }

    -- Enable LSP servers
    vim.lsp.enable { 'gopls', 'svelte', 'powershell_es', 'graphql', 'emmet_ls', 'lua_ls', 'angularls', 'bicep', 'azure_pipelines_ls' }
  end,
}
