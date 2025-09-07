vim.cmd 'let g:netrw_liststyle = 1'

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true -- Highlight the current line
opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
opt.sidescrolloff = 8 -- Minimal number of screen columns to keep to the left and right of the cursor if 'nowrap' is set.
opt.wrap = false -- Disable line wrapping
opt.spelllang = { 'en', 'nl' }
vim.g.winborder = 'rounded'

-- Tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search settings
opt.ignorecase = true -- Case insensitive searching
opt.smartcase = true -- Case-sensitive if expression contains a capital letter

-- Visual settings
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.signcolumn = 'yes' -- Always show the sign column, otherwise it would shift the text each time
opt.colorcolumn = '120' -- Line length marker at 120 columns
opt.showmatch = true -- Highlight matching parenthesis
opt.matchtime = 2 -- How long to show the matching paren
opt.showmode = false

-- Folding settings
opt.foldmethod = 'expr' -- Use expression for folding
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- Use treesitter for folding
opt.foldlevel = 99 -- Start with all folds open

-- text wrapping
vim.g.editorconfig = false
opt.textwidth = 0 -- Set text width to unlimited
opt.formatoptions:remove 't' -- No text auto-wrapping
opt.formatoptions:remove 'c' -- No comment auto-wrapping
opt.formatoptions:remove 'r' -- Don't auto-continue comments
opt.formatoptions:remove 'o' -- Don't auto-insert new lines

-- File handling
opt.autoread = true -- Auto-read files when changed outside of Neovim
opt.autowrite = false -- Auto-write files when leaving a buffer

-- Disable virtual text for diagnostics, because replacing it with tiny-inline-diagnostic.nvim
vim.diagnostic.config { virtual_text = false }

opt.mouse = 'a'
opt.background = 'dark'
opt.clipboard:append 'unnamedplus'

-- opt.backspace = 'indent, eol, start'
opt.splitright = true
opt.splitbelow = true

opt.swapfile = false

-- vim.g.have_nerd_font = true

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Sets how neovim will display certain whitespace characters in the editor.
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

vim.g.have_nerd_font = true
