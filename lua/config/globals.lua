vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Global file size thresholds (in bytes)
vim.g.MAX_FILE_SIZE = 1024 * 1024 -- 1MB - Used for disabling LSP, Copilot, Telescope preview
vim.g.LARGE_FILE_SIZE = 1024 * 1024 * 3 -- 3MB - Used for disabling syntax highlighting and treesitter

-- Diagnostic configuration (consolidated in one place)
vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}
