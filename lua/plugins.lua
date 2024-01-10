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
		dependencies = {
			'https://github.com/nvim-tree/nvim-web-devicons',
		},
		config = require('plugins.bufferline')
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
		dependencies = {
			'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
			--'https://github.com/RRethy/nvim-treesitter-textsubjects',
		},
		build = ':TSUpdate',
		config = require('plugins.treesitter'),
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
		config = require('plugins.nvim-cmp'),
	},
	{
		-- Telescope
		'https://github.com/nvim-telescope/telescope.nvim',
		dependencies = {
			'https://github.com/nvim-lua/plenary.nvim',
			{
				'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = vim.fn.executable('make') == 1
			},
		},
		config = require('plugins.telescope'),
	},
	{
		'https://github.com/nvim-lualine/lualine.nvim',
		config = function()
			require('plugins.lualine').multiple_windows()
		end,
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
		opts = require('plugins.neotree')
	},
	{
		-- LSP status
		'https://github.com/j-hui/fidget.nvim',
		tag = 'legacy',
		opts = {}
	},
	{
		-- Switch theme based on system
		'https://github.com/f-person/auto-dark-mode.nvim',
		opts = {
			update_interval = 5000,
			set_dark_mode = require('theme').set_dark_mode,
			set_light_mode = require('theme').set_light_mode,
		}
	},
	{
		-- Commenting
		'https://github.com/numToStr/Comment.nvim',
		dependencies = {
			'https://github.com/JoosepAlviste/nvim-ts-context-commentstring',
			dependencies = {
				'https://github.com/nvim-treesitter/nvim-treesitter',
			},
			config = true,
		},
		opts = function()
			return { pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook() }
		end,
		lazy = false,
	},
	{
		-- Show keymaps live
		'https://github.com/folke/which-key.nvim',
		event = 'VeryLazy',
		opts = {
			window = {
				position = 'top',
				margin = { 4, 4, 4, 4 }
			}
		}
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
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
		'ruifm/gitlinker.nvim',
		dependencies = 'nvim-lua/plenary.nvim',
	},
	{
		'https://github.com/lewis6991/gitsigns.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		opts = {
			signs = {
				add = { text = '▎' },
				change = { text = '▎' },
				delete = { text = '' },
				topdelete = { text = '' },
				changedelete = { text = '▎' },
				untracked = { text = '▎' },
			},

			-- on_attach = function(buffer)
			-- 	local gs = package.loaded.gitsigns
			--
			-- 	local function map(mode, l, r, desc)
			-- 		vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
			-- 	end
			--
			-- 	-- stylua: ignore start
			-- 	map('n', ']h', gs.next_hunk, 'Next Hunk')
			-- 	map('n', '[h', gs.prev_hunk, 'Prev Hunk')
			-- 	map({ 'n', 'v' }, '<leader>ghs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
			-- 	map({ 'n', 'v' }, '<leader>ghr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
			-- 	map('n', '<leader>ghS', gs.stage_buffer, 'Stage Buffer')
			-- 	map('n', '<leader>ghu', gs.undo_stage_hunk, 'Undo Stage Hunk')
			-- 	map('n', '<leader>ghR', gs.reset_buffer, 'Reset Buffer')
			-- 	map('n', '<leader>ghp', gs.preview_hunk, 'Preview Hunk')
			-- 	map('n', '<leader>ghb', function() gs.blame_line({ full = true }) end, 'Blame Line')
			-- 	map('n', '<leader>ghd', gs.diffthis, 'Diff This')
			-- 	map('n', '<leader>ghD', function() gs.diffthis('~') end, 'Diff This ~')
			-- 	map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk')
			-- end,
		},
	},
	{
		-- Highlight TODO, HACK, etc.
		'https://github.com/folke/todo-comments.nvim',
		dependencies = { 'https://github.com/nvim-lua/plenary.nvim' },
		opts = {},
	},
	{
		-- Show the context parent that is scrolled off at the top
		'https://github.com/nvim-treesitter/nvim-treesitter-context',

		opts = {
			separator = nil,
			min_window_height = 50,
			max_lines = 1,
			mode = 'topline',
			trim_scope = 'inner',
		},
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
		"https://github.com/folke/trouble.nvim",
		dependencies = { "https://github.com/nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	--[[
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			restricted_keys = {
				['x'] = { 'n', 'x' }
			}
		}
	},]]

	{
		'https://github.com/VonHeikemen/searchbox.nvim',
		dependencies = {
			'https://github.com/MunifTanjim/nui.nvim'
		},
		opts = {
			defaults = {
				highlight_matches = true,
				clear_matches = false,
			}
		}
	},
	{ "https://github.com/stevanmilic/nvim-lspimport" },
	{
		"https://github.com/hachy/cmdpalette.nvim",
		lazy = true,
		cmd = "Cmdpalette",
		config = true,
	},
	{
		"https://github.com/johmsalas/text-case.nvim",
		dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
		config = function()
			require("textcase").setup({})
			require("telescope").load_extension("textcase")
		end,
	},
	{
		"https://github.com/chrisgrieser/nvim-spider",
	},
	{
		"https://github.com/chrisgrieser/nvim-various-textobjs",
		lazy = false,
		opts = { useDefaultKeymaps = true },
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
		opts = {
			autotag = { enable = false, enable_rename = true }
		}
	},
	{
		'https://github.com/stevearc/dressing.nvim',
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon"):setup()
		end
	},
	{
		'gsuuon/tshjkl.nvim',
		opts = {
			keymaps = {
				toggle = '<leader>p',
			}
		}
	},
}, {})
