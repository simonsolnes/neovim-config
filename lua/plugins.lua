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
	--require('plugins.bufferline'),
	{
		-- Onedarkpro: theme
		'https://github.com/olimorris/onedarkpro.nvim',
		priority = 1000,
		lazy = false,
		opts = {
			colors = {
				dark = {
					bg = '#1C1C1C',
				},
			},
		},
	},
	{
		-- Treesitter: parser
		'https://github.com/nvim-treesitter/nvim-treesitter',
		priority = 999,
		lazy = false,
		dependencies = {
			'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
		config = function()
			require('plugins.treesitter')
		end,
	},
	{
		-- nvim-lspconfig
		'https://github.com/neovim/nvim-lspconfig',
		dependencies = {
			{
				'https://github.com/williamboman/mason-lspconfig.nvim',
				dependencies = {
					{
						'https://github.com/williamboman/mason.nvim',

						ensure_installed = {
							'clang-format',
							'isort',
							'lua-language-server',
							'markdownlint',
							'mdformat',
							'pyright',
							'python-lsp-server',
							'stylua',
							'typescript-language-server',
							'actionlint',
						},
					}
				},
				opts = {
					automatic_installation = true,
				}
			},
			{
				'https://github.com/jay-babu/mason-null-ls.nvim',
				cmd = { 'NullLsInstall', 'NullLsUninstall' },
				opts = {
					ensure_installed = {
						'stylua',
						'markdownlint',
						'mdformat',
						'cpplint',
						'clang_format',
					},
				},
			},
			{
				'https://github.com/folke/neodev.nvim',
				config = true
			}
		},
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
		},
		config = function()
			require('plugins.nvim-cmp')
		end,
	},
	{
		-- Fuzzyfinder
		'https://github.com/nvim-telescope/telescope.nvim',
		dependencies = {
			'https://github.com/nvim-lua/plenary.nvim',
			{
				'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = vim.fn.executable('make') == 1
			},
		},
		config = function()
			require('telescope').setup({
				defaults = {
					mappings = {
						i = {
							['<C-u>'] = false,
							['<C-d>'] = false,
						},
					},
					sorting_strategy = "ascending", -- display results top->bottom
					layout_config = {
						prompt_position = "top" -- search bar at the top
					}
				},
			})

			-- Enable telescope fzf native, if installed
			pcall(require('telescope').load_extension, 'fzf')
		end,
	},
	{
		-- Set lualine as statusline
		'https://github.com/nvim-lualine/lualine.nvim',
		-- See `:help lualine.txt`
		config = function()
			require('plugins.lualine').multiple_windows()
		end,
	},
	{
		-- File tree
		'http://github.com/nvim-neo-tree/neo-tree.nvim',
		branch = 'v3.x',
		dependencies = {
			'https://github.com/nvim-lua/plenary.nvim',
			'https://github.com/nvim-tree/nvim-web-devicons',
			'https://github.com/MunifTanjim/nui.nvim',
		},
		opts = {
			close_if_last_window = true,
			filesystem = {
				follow_current_file = { enabled = true },
			}
		}
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
			set_dark_mode = function()
				vim.api.nvim_set_option('background', 'dark')
				vim.cmd.colorscheme('onedark')
				require('lualine').setup({
					options = {
						theme = 'onedark'
					}
				})
				vim.api.nvim_set_hl(0, 'MatchParen', { bg = '#aaaa00', fg = '#101010' })

				-- vim.api.nvim_set_hl(0, 'LineNr', { fg = '#606060' })
				-- vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#909090' })
				-- vim.api.nvim_set_hl(0, 'BufferLineSelected', { fg = '#ff0000' })
				-- vim.api.nvim_set_hl(0, 'BufferLineFill', { fg = '#ff0000' })
				-- vim.api.nvim_set_hl(0, 'TabLinefill', { fg = '#ff0000' })
				-- vim.api.nvim_set_hl(0, 'ColorColumn', { fg = '#ff0000' })
				-- vim.api.nvim_set_hl(0, 'TabLine', { fg = '#ff0000' })
			end,
			set_light_mode = function()
				vim.api.nvim_set_option('background', 'light')
				vim.cmd.colorscheme('onelight')
				require('lualine').setup({
					options = {
						theme = 'onelight'
					}
				})
			end,
		}
	},
	{
		-- Commenting
		'https://github.com/numToStr/Comment.nvim',
		opts = {}
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
		-- Hop cursor to stuff
		'https://github.com/smoka7/hop.nvim',
		config = true,
	},
	{
		-- Automatically infer indent-mode
		'https://github.com/tpope/vim-sleuth'
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
	--TODO
	-- {
	-- 	-- Show the context parent that is scrolled off at the top
	-- 	'https://github.com/nvim-treesitter/nvim-treesitter-context',
	--
	-- 	-- opts = {
	-- 	-- 	separator = '-',
	-- 	-- },
	-- },
	{
		-- Symbol tree
		'https://github.com/simrat39/symbols-outline.nvim',
		config = true,
		opts = {
			autofold_depth = 0,
		}
	},
	{
		'https://github.com/simrat39/rust-tools.nvim',
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	--{
	--"m4xshen/hardtime.nvim",
	--dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	--opts = {
	--restricted_keys = {
	--['x'] = { 'n', 'x' }
	--}
	--}
	--},
	--
	{
		'https://github.com/VonHeikemen/searchbox.nvim',
		dependencies = {
			'https://github.com/MunifTanjim/nui.nvim'
		},
		config = true,
	},
	{ "stevanmilic/nvim-lspimport" },
	{
		"hachy/cmdpalette.nvim",
		lazy = true,
		cmd = "Cmdpalette",
		config = true,
	},
}, {})
