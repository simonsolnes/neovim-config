-- Install lazy.nvim package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

	{
		'https://github.com/akinsho/bufferline.nvim',
		dependencies = 'https://github.com/nvim-tree/nvim-web-devicons',
		config = require('plugins.bufferline').config
	},
	{
		-- Onedarkpro: theme
		'https://github.com/olimorris/onedarkpro.nvim',
		priority = 1000,
		lazy = false,
		opts = require('theme').onedarkpro_opts,
	},
	{
		-- Treesitter: parser
		'https://github.com/nvim-treesitter/nvim-treesitter',
		priority = 999,
		lazy = false,
		dependencies = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
		build = ':TSUpdate',
		config = require('plugins.treesitter').config,
	},
	{
		-- nvim-lspconfig
		'https://github.com/neovim/nvim-lspconfig',
		dependencies = require('plugins.nvim-lspconfig').dependencies,
	},
	{
		-- null-ls
		'https://github.com/jose-elias-alvarez/null-ls.nvim',
		dependencies = {
			'https://github.com/williamboman/mason.nvim',
			'https://github.com/nvim-lua/plenary.nvim'
		},
	},
	{
		-- Autocompletion
		'https://github.com/hrsh7th/nvim-cmp',
		dependencies = {
			'https://github.com/L3MON4D3/LuaSnip',
			'https://github.com/saadparwaiz1/cmp_luasnip',
			'https://github.com/hrsh7th/cmp-nvim-lsp',
			'https://github.com/hrsh7th/cmp-buffer',
			'https://github.com/rafamadriz/friendly-snippets',
			'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help',
			'https://github.com/hrsh7th/cmp-path',
		},
		config = require('plugins.nvim-cmp').config,
	},
	{
		-- Telescope
		'https://github.com/nvim-telescope/telescope.nvim',
		dependencies = {
			'https://github.com/nvim-lua/plenary.nvim',
			require('plugins/telescope').fzf_dependency,
		},
		config = require('plugins.telescope').config,
	},
	{
		'https://github.com/elpiloto/telescope-vimwiki.nvim',
		config = function()
			require('telescope').load_extension('vimwiki')
		end
	},
	{
		'https://github.com/nvim-lualine/lualine.nvim',
		config = require('plugins.lualine').multiple_windows,
	},
	{
		-- Neo tree
		'http://github.com/nvim-neo-tree/neo-tree.nvim',
		branch = 'v3.x',
		dependencies = {
			'https://github.com/nvim-lua/plenary.nvim',
			'https://github.com/nvim-tree/nvim-web-devicons',
			'https://github.com/MunifTanjim/nui.nvim',
		},
		opts = require('plugins.neotree').opts,
	},
	{
		-- LSP status
		'https://github.com/j-hui/fidget.nvim',
		config = true,
	},
	{
		-- Switch theme based on system
		'https://github.com/f-person/auto-dark-mode.nvim',
		opts = require('plugins.auto-dark-mode').opts
	},
	{
		-- Commenting
		'https://github.com/numToStr/Comment.nvim',
		dependencies = {
			'https://github.com/JoosepAlviste/nvim-ts-context-commentstring',
			dependencies = {
				'https://github.com/nvim-treesitter/nvim-treesitter',
			},
		},
		lazy = false,
		opts = require('plugins.comment').opts,
	},
	{
		-- Show keymaps live
		'https://github.com/folke/which-key.nvim',
		event = 'VeryLazy',
		opts = require('plugins.which-key').opts
	},
	{
		'https://github.com/folke/flash.nvim',
	},
	{
		-- Show token tree
		'https://github.com/nvim-treesitter/playground'
	},
	{
		-- Undotree
		'https://github.com/mbbill/undotree'
	},
	{
		-- Git
		'https://github.com/tpope/vim-fugitive'
	},
	{
		-- Automatically infer indent-mode
		'https://github.com/tpope/vim-sleuth'
	},
	{
		'https://github.com/ruifm/gitlinker.nvim',
		dependencies = 'https://github.com/nvim-lua/plenary.nvim',
	},
	{
		'https://github.com/lewis6991/gitsigns.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		opts = require('plugins.gitsigns').opts,
	},
	{
		-- Highlight TODO, HACK, etc.
		'https://github.com/folke/todo-comments.nvim',
		dependencies = { 'https://github.com/nvim-lua/plenary.nvim' },
		config = true,
	},
	{
		-- Show the context parent that is scrolled off at the top
		'https://github.com/nvim-treesitter/nvim-treesitter-context',
		opts = require('plugins.nvim-treesitter-context').opts,
	},
	{
		-- Symbol tree
		'https://github.com/simrat39/symbols-outline.nvim',
		config = true,
	},
	{
		'https://github.com/simrat39/rust-tools.nvim',
	},
	{
		'https://github.com/folke/trouble.nvim',
		dependencies = 'https://github.com/nvim-tree/nvim-web-devicons',
		config = true,
	},
	{
		'https://github.com/m4xshen/hardtime.nvim',
		dependencies = {
			'https://MunifTanjim/nui.nvim',
			'https://nvim-lua/plenary.nvim'
		},
		opts = require('plugins.hardtime').opts,
	},
	{
		'https://github.com/stevanmilic/nvim-lspimport'
	},
	{
		'https://github.com/folke/noice.nvim',
		event = 'VeryLazy',
		dependencies = {
			'MunifTanjim/nui.nvim',
			--'rcarriga/nvim-notify',
		},
		opts = require('plugins.noice').opts
	},
	{
		'https://github.com/johmsalas/text-case.nvim',
		dependencies = 'https://github.com/nvim-telescope/telescope.nvim',
		config = require('plugins.text-case').config
	},
	{
		'https://github.com/chrisgrieser/nvim-spider',
	},
	{
		'https://github.com/chrisgrieser/nvim-various-textobjs',
		opts = require('plugins.various-textobjs').opts,
	},
	{
		'https://github.com/gsuuon/tshjkl.nvim',
		opts = {
			keymaps = {
				toggle = '<leader>tsu',
			}
		}
	},
	{
		'https://github.com/norcalli/nvim-colorizer.lua',
		opts = { '*' }
	},
	{
		'https://github.com/windwp/nvim-ts-autotag',
		opts = require('plugins.nvim-ts-autotag').opts,
	},
	{
		'https://github.com/stevearc/dressing.nvim',
		config = true,
	},
	{
		'https://github.com/kylechui/nvim-surround',
		event = 'VeryLazy',
		config = require('plugins.surround').config,
	},
	{
		'https://github.com/ThePrimeagen/harpoon',
		branch = 'harpoon2',
		dependencies = { 'https://github.com/nvim-lua/plenary.nvim' },
		config = require('plugins.harpoon').config
	},
	{
		'http://github.com/stevearc/aerial.nvim',
		dependencies = {
			'http://github.com/nvim-treesitter/nvim-treesitter',
			'http://github.com/nvim-tree/nvim-web-devicons'
		},
		config = true,
	},
	{
		-- TreeSJ
		'http://github.com/Wansmer/treesj',
		dependencies = { 'http://github.com/nvim-treesitter/nvim-treesitter' },
		config = require('plugins.treesj').config,
	},
	{
		-- Sibling-swap
		'http://github.com/Wansmer/sibling-swap.nvim',
		dependencies = { 'http://github.com/nvim-treesitter/nvim-treesitter' },
		config = require('plugins.sibling-swap').config,
	},
}, {})
