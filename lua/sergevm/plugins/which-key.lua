return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    local wk = require 'which-key'

    wk.setup()

    wk.add {
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    }

    wk.add {
      { '<leader>tt', '<cmd>ToggleTerm direction=float<cr>', desc = 'Terminal Float' },
      { '<leader>tv', '<cmd>ToggleTerm size=80 direction=vertical<cr>', desc = 'Terminal Vertical' },
      { '<leader>th', '<cmd>ToggleTerm size=80 direction=horizontal size=20<cr>', desc = 'Terminal Horizontal' },
    }
  end,
}
