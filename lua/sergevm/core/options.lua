vim.cmd 'let g:netrw_liststyle = 1'

local opt = vim.opt

-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

opt.relativenumber = true
opt.number = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = 'dark'
opt.signcolumn = 'yes'

-- opt.backspace = 'indent, eol, start'

opt.splitright = true
opt.splitbelow = true

opt.swapfile = false

vim.g.have_nerd_font = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
opt.clipboard = 'unnamedplus'

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
-- vim.opt.ignorecase = true
-- vim.opt.smartcase = true

-- Keep signcolumn on by default
-- vim.opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
-- vim.opt.splitright = true
-- vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Show which line your cursor is on
-- vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10
