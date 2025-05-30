return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require 'lspconfig'

    -- import mason_lspconfig plugin
    local mason_lspconfig = require 'mason-lspconfig'

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'

    local keymap = vim.keymap -- for conciseness

    -- set up go lsp ...
    lspconfig.gopls.setup {
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

        opts.desc = 'Go to previous diagnostic'
        keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = 'Go to next diagnostic'
        keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = 'Show documentation for what is under cursor'
        keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = 'Restart LSP'
        keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts) -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    local bicep_lsp_bin = '/usr/local/bin/bicep-langserver/Bicep.LangServer.dll'

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    mason_lspconfig.setup_handlers {
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
        }
      end,
      ['svelte'] = function()
        -- configure svelte server
        lspconfig['svelte'].setup {
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd('BufWritePost', {
              pattern = { '*.js', '*.ts' },
              callback = function(ctx)
                -- Here use ctx.match instead of ctx.file
                client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.match })
              end,
            })
          end,
        }
      end,
      -- You have to install PowerShellEditorServices manually: download and extract zip to .local/share/powershell
      ['powershell_es'] = function()
        local mason_registry = require 'mason-registry'

        lspconfig['powershell_es'].setup {
          bundle_path = mason_registry.get_package('powershell-editor-services'):get_install_path(),
          cmd = {
            'pwsh',
            '-NoLogo',
            '-NoProfile',
            '-Command',
            vim.fn.expand '~/.local/share/nvim/mason/packages/powershell-editor-services/PowerShellEditorServices/Start-EditorServices.ps1',
            '-HostName',
            'nvim',
            '-Stdio',
            '-HostProfileId',
            '0',
            '-HostVersion',
            '1.0.0',
            '-LogPath',
            vim.fn.stdpath 'cache' .. '/powershell_es.log',
            '-SessionDetailsPath',
            vim.fn.stdpath 'cache' .. '/powershell_es.session.json',
            '-BundledModulesPath',
            vim.fn.expand '~/.local/share/powershell/Modules',
            '-LogLevel',
            'Normal',
            '-FeatureFlags',
            '@()',
          },
          filetypes = { 'ps1', 'powershell' },
          shell = 'pwsh',
          init_options = {
            enableProfileLoading = false,
          },
        }
      end,
      ['graphql'] = function()
        -- configure graphql language server
        lspconfig['graphql'].setup {
          capabilities = capabilities,
          filetypes = { 'graphql', 'gql', 'svelte', 'typescriptreact', 'javascriptreact' },
        }
      end,
      ['emmet_ls'] = function()
        -- configure emmet language server
        lspconfig['emmet_ls'].setup {
          capabilities = capabilities,
          filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte' },
        }
      end,
      ['lua_ls'] = function()
        -- configure lua server (with special settings)
        lspconfig['lua_ls'].setup {
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
      end,
      ['angularls'] = function()
        lspconfig.angularls.setup {
          cmd = { 'ngserver', '--stdio' },
          on_new_config = function(new_config, new_root_dir)
            new_config.cmd = {
              'ngserver',
              '--stdio',
              '--tsProbeLocations',
              new_root_dir,
              '--ngProbeLocations',
              new_root_dir,
            }
          end,
          on_attach = function(client, bufnr)
            local function buf_set_option(...)
              vim.api.nvim_buf_set_option(bufnr, ...)
            end
            buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
          end,
          filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx' },
          root_dir = lspconfig.util.root_pattern 'angular.json',
          flags = {
            debounce_text_changes = 150,
          },
        }
      end,
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#bicep
      -- https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install
      ['bicep'] = function()
        lspconfig.bicep.setup {
          cmd = { 'dotnet', bicep_lsp_bin },
        }
      end,
      -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/azure_pipelines_ls.lua
      ['azure_pipelines_ls'] = function()
        lspconfig.azure_pipelines_ls.setup {
          root_dir = lspconfig.util.root_pattern 'azure-pipelines.yml',
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
      end,
    }
  end,
}
