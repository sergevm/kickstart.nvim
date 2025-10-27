-- Override diagnostic keymaps. Specifically in collaboration with tiny inline diagnostics. We don't want to show the built-in inline diagnostics, so we need float to be false.
-- Doing this here, because it looks like a plugin sets somewhere the keymaps to jump to diagnostics, but it does not set float = false, which is needed for inline diagnostics.
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Override diagnostic keymaps on startup',
  group = vim.api.nvim_create_augroup('custom-diagnostic-maps', { clear = true }),
  callback = function()
    vim.keymap.set('n', ']d', function()
      vim.diagnostic.jump { count = 1, float = false }
    end, { desc = 'Go to next diagnostic' })

    vim.keymap.set('n', '[d', function()
      vim.diagnostic.jump { count = -1, float = false }
    end, { desc = 'Go to previous diagnostic' })
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('Highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
