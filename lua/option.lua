vim.g.mapleader = " "
vim.g.maplocalleader = ' '

vim.opt.termguicolors = true

-- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
vim.opt.signcolumn = "yes"

vim.opt.scrolloff = 10

vim.opt.breakindent = true

-- use OS clipboard
vim.opt.clipboard = 'unnamed'

-- keep undo history on disk
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.linebreak = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- line numbers
vim.opt.number = true
