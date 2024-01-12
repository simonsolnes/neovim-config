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

	}

}
