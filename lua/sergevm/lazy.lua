local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)
-- Disable virtual text for diagnostics, because replacing it with tiny-inline-diagnostic.nvim
vim.diagnostic.config { virtual_text = false }
-- Load lazy.nvim
require('lazy').setup {
  spec = {
    -- import your plugins
    { import = 'sergevm.plugins' },
    { import = 'sergevm.plugins.lsp' },
  },
  -- automatically check for plugin updates
  change_detection = { notify = false },
  checker = { enabled = true, notify = false },
  colorscheme = 'catppuccin',
}
