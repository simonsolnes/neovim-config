return {
	colorscheme = 'onedark',
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
