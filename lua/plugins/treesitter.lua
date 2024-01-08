require('nvim-treesitter.configs').setup({
	ensure_installed = {
		'bash',
		'css',
		'make',
		'c',
		'cpp',
		'go',
		'lua',
		'python',
		'rust',
		'tsx',
		'typescript',
		'vimdoc',
		'vim',
		'javascript',
		'rust',
		'python',
		'swift',
		'query'
	},
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
			init_selection = '<cr>',
			node_incremental = '<cr>',
			scope_incremental = '<C-s>',
			node_decremental = '<bs>',
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
		lsp_interop = {
			enable = true,
			border = 'none',
			floating_preview_opts = {},
			peek_definition_code = {
				["<leader>lp"] = "@function.outer",
				["<leader>lP"] = "@class.outer",
			},
		},
	},
	-- textsubjects = {
	-- 	enable = true,
	-- 	prev_selection = ',', -- (Optional) keymap to select the previous selection
	-- 	keymaps = {
	-- 		['.'] = 'textsubjects-smart',
	-- 		[';'] = 'textsubjects-container-outer',
	-- 		['i;'] = 'textsubjects-container-inner',
	-- 	},
	-- },
	extsubjects = {
	}
})
