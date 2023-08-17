-- plugin wishlist
-- - undo tree
vim.g.mapleader = " "
vim.g.maplocalleader = ' '

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
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		priority = 999,
		lazy = false,
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',

	},
	{

		"http://github.com/nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		}
	},
	{
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',
			'folke/neodev.nvim',


			-- Additional lua configuration, makes nvim stuff amazing!
			--'folke/neodev.nvim',
		},
	},

	{ 'https://github.com/j-hui/fidget.nvim', tag = 'legacy', opts = {} },
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
	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim', opts = {} },
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
	{ 'https://github.com/nvim-treesitter/playground' },
	{ 'https://github.com/mbbill/undotree' },
	{ 'https://github.com/tpope/vim-fugitive' },
}, {})

require("mason").setup()
require("mason-lspconfig").setup()
require('neodev').setup()

require('lspconfig').lua_ls.setup({})

require('nvim-treesitter.configs').setup({
	ensure_installed = { 'bash', 'css', 'make', 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc',
		'vim', 'javascript', 'rust', 'python', 'swift', 'query' },
	ignore_install = {},
	modules = {},
	auto_install = true,
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,

	},
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<S-space>',
			node_incremental = '<S-space>',
			scope_incremental = '<C-s>',
			node_decremental = '<M-space>',
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				['aa'] = '@parameter.outer',
				['ia'] = '@parameter.inner',
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				[']m'] = '@function.outer',
				[']]'] = '@class.outer',
			},
			goto_next_end = {
				[']M'] = '@function.outer',
				[']['] = '@class.outer',
			},
			goto_previous_start = {
				['[m'] = '@function.outer',
				['[['] = '@class.outer',
			},
			goto_previous_end = {
				['[M'] = '@function.outer',
				['[]'] = '@class.outer',
			},
		},
		swap = {
			enable = true,
			swap_next = {
				['<leader>a'] = '@parameter.inner',
			},
			swap_previous = {
				['<leader>A'] = '@parameter.inner',
			},
		},
	}
})


local wk = require('which-key')
wk.register({
	name = 'henlo',
	f = { '<cmd>Telescope find_files<cr>', 'Find File' },
	k = { name = 'oiii' }
}, { prefix = '<leader>' })

vim.opt.termguicolors = true

-- global statusline
vim.opt.laststatus = 3

-- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
vim.opt.signcolumn = "yes"

vim.opt.scrolloff = 10

vim.opt.breakindent = true

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

vim.keymap.set('n', '<leader>kk', function() print("real lua function") end, { desc = "heyy" })
vim.keymap.set('n', '>', '>>', { desc = "Indent right" })
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Undo tree" })
vim.keymap.set('n', '<leader>git', vim.cmd.Git, { desc = "Git" })
vim.keymap.set('n', '<', '<<', { desc = "Indent left" })
vim.keymap.set('v', '>', '>gv', { desc = "Indent right" })
vim.keymap.set('v', '<', '<gv', { desc = "Indent left" })


vim.api.nvim_create_autocmd("FocusLost", {
	command = ":wa",
	desc = "Autosave all buffers when focus is lost"
})

-- # Mappings
--
-- tfrintiufrntiufr
