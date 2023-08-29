vim.g.mapleader = " "
vim.g.maplocalleader = ' '

print('he')


vim.opt.termguicolors = true


-- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
-- global statusline
--vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"

vim.opt.scrolloff = 10

vim.opt.breakindent = true

-- use OS clipboard
vim.opt.clipboard = 'unnamed'

-- keep undo history on disk
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.linebreak = true


-- line numbers
vim.opt.number = true

