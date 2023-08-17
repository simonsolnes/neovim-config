print("hello")

-- plugin wishlist
-- - undo tree
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

-- line numbers
vim.opt.number = true

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
"https://github.com/olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
  lazy = false,
  config = {
		colors = {
			dark = {
				bg = '#222222',
			},
		}
	}
  },
  {
	"https://github.com/f-person/auto-dark-mode.nvim",
	config = {
		update_interval = 5000,
			set_dark_mode = function()
			vim.api.nvim_set_option('background', 'dark')
			vim.cmd.colorscheme("onedark")
		 end,
		 set_light_mode = function()
			vim.api.nvim_set_option('background', 'light')
			vim.cmd.colorscheme("onelight")
		 end,
	}
},
{
	"https://github.com/folke/which-key.nvim",
	event = "VeryLazy",
	  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 150
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
},
{
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
}, opts)

local wk = require('which-key')
wk.register({
	name = 'henlo',
	f = {'<cmd>Telescope find_files<cr>', 'Find File'},
	k = {name = 'oiii'}
},{ prefix = '<leader>'})

vim.opt.termguicolors = true

vim.opt.laststatus = 3

-- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
vim.opt.signcolumn = "yes"

-- use OS clipboard
vim.opt.clipboard = 'unnamed'

-- keep undo history on disk
vim.opt.undofile = true


-- set tab to 3 space when entering a buffer with .lua file
vim.api.nvim_create_autocmd("BufEnter", {
   pattern = { "*.lua" },
   callback = function()
      vim.opt.shiftwidth = 3
      vim.opt.tabstop = 3

      vim.opt.softtabstop = 3
   end
}) 

vim.keymap.set('n', '<leader>kk', function() print("real lua function") end, {desc = "heyy"})
vim.keymap.set('n', '>', '>>', {desc = "Indent right"})
vim.keymap.set('n', '<', '<<', {desc = "Indent left"})
vim.keymap.set('v', '>', '>gv', {desc = "Indent right"})
vim.keymap.set('v', '<', '<gv', {desc = "Indent left"})

vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })

vim.api.nvim_create_autocmd("FocusLost", {
	command = ":wa",
			desc = "Autosave all buffers when focus is lost"
	})

-- # Mappings
