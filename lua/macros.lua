return {
	open_url_under_cursor = function()
		vim.cmd.normal('yL')
		local url = vim.fn.getreg('"')
		os.execute('open' .. ' ' .. url)
	end,
	git = {
		open_line_on_origin = function(mode)
			return function()
				require('gitlinker').get_buf_range_url(
					mode,
					{ action_callback = require('gitlinker.actions').open_in_browser }
				)
			end
		end,

		open_origin_repo = function()
			require('gitlinker').get_repo_url({
				action_callback = require('gitlinker.actions').open_in_browser
			})
		end,
	},
	textcase_word = function(arg)
		return function()
			require('textcase').current_word(arg)
		end
	end,
	spider_motion = function(motion)
		return "<cmd>lua require('spider').motion('" .. motion .. "')<cr>"
	end,
	surround = {
		change = '<Plug>(nvim-surround-change)',
		change_line = '<Plug>(nvim-surround-change-line)',
		delete = '<Plug>(nvim-surround-delete)',
		visual = '<Plug>(nvim-surround-visual)',
		visual_line = '<Plug>(nvim-surround-visual-line)',
		normal_cur_line = '<Plug>(nvim-surround-normal-cur-line)',
		normal_line = '<Plug>(nvim-surround-normal-line)',
		normal_cur = '<Plug>(nvim-surround-normal-cur)',
		normal = '<Plug>(nvim-surround-normal)',
	}

}
