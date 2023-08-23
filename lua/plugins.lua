-- Install lazy.nvim package manager
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
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		-- Onedarkpro: theme
		"https://github.com/olimorris/onedarkpro.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			colors = {
				dark = {
					bg = '#1A1A1A',
				},
			}
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
			-- Automatically install LSPs to stdpath for neovim
			{
				'williamboman/mason-lspconfig.nvim',
				dependencies = {
					{
						'williamboman/mason.nvim',
						config = true,
					}
				},
				opts = {
					ensure_installed = {
						'lua_ls',
						'pylsp',
					},
					automatic_installation = true,
				}
			},
			{
				'folke/neodev.nvim',
				config = true
			}
		},
	},
	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		dependencies = {
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'rafamadriz/friendly-snippets',
		},
		config = function()
			require('plugins.nvim-cmp')
		end,
	},
	{
		-- Fuzzyfinder
		'https://github.com/nvim-telescope/telescope.nvim',
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
					},
				},
			})

			-- Enable telescope fzf native, if installed
			pcall(require("telescope").load_extension, "fzf")
		end,
	},
	{
		-- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				theme = 'onedark',
				component_separators = '|',
				section_separators = '',
			},
		},
	},
	{
		-- File tree
		"http://github.com/nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			close_if_last_window = true,
			buffers = {
				follow_current_file = true,
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
		"https://github.com/f-person/auto-dark-mode.nvim",
		opts = {
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
		-- Commenting
		'numToStr/Comment.nvim',
		opts = {}
	},
	{
		-- Show keymaps live
		"https://github.com/folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 150
		end,
		opts = {
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
		'https://github.com/phaazon/hop.nvim',
		config = true
	},
	{
		-- Automatically infer indent-mode
		'https://github.com/tpope/vim-sleuth'
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},

			-- on_attach = function(buffer)
			-- 	local gs = package.loaded.gitsigns
			--
			-- 	local function map(mode, l, r, desc)
			-- 		vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
			-- 	end
			--
			-- 	-- stylua: ignore start
			-- 	map("n", "]h", gs.next_hunk, "Next Hunk")
			-- 	map("n", "[h", gs.prev_hunk, "Prev Hunk")
			-- 	map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
			-- 	map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
			-- 	map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
			-- 	map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
			-- 	map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
			-- 	map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
			-- 	map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
			-- 	map("n", "<leader>ghd", gs.diffthis, "Diff This")
			-- 	map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
			-- 	map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			-- end,
		},
	},
	{
		-- Highlight TODO, HACK, etc.
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},
	{
		-- Show the context parent that is scrolled off at the top
		'https://github.com/nvim-treesitter/nvim-treesitter-context',
		opts = {
			separator = '-',
		},
	},
	{
		'https://github.com/akinsho/bufferline.nvim',
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = true,
	},
	{
		'https://github.com/simrat39/symbols-outline.nvim',
		config = true,
	}

}, {})
