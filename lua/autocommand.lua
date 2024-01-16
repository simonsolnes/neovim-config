--[[
local function number_of_windows()
	local tabpage = vim.api.nvim_get_current_tabpage()
	local windows = vim.api.nvim_tabpage_list_wins(tabpage)
	local window_count = 0

	for _, w in pairs(windows) do
		local cfg = vim.api.nvim_win_get_config(w)
		local ft = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(w), "filetype")
		if cfg.focusable == false then
			break
		end
		if (cfg.relative == "" or cfg.external == false) and ft ~= "qf" then
			window_count = window_count + 1
		end
	end

	return window_count
end

vim.api.nvim_create_autocmd({ 'WinNew' }, {
	callback = function()
		if number_of_windows() > 1 then
			require('plugins.lualine').multiple_windows()
		end
	end
})

vim.api.nvim_create_autocmd({ 'WinClosed' }, {
	callback = function()
		local got_number_of_windows = number_of_windows()
		print('closed:', got_number_of_windows)

		if got_number_of_windows < 3 then
			print('running single')
			require('plugins.lualine').single_window()
		end
	end
})
]]

--[[
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argv(0) == "" then
			require("telescope.builtin").find_files()
		end
	end,
})
]]


-- set tab to 3 space when entering a buffer with .lua file
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.lua" },
	callback = function()
		vim.opt.shiftwidth = 3
		vim.opt.tabstop = 3

		vim.opt.softtabstop = 3
	end
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	command = ":wa",
	desc = "Autosave all buffers when focus is lost"
})


-- remember last position
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'FileType' }, {
	group    = vim.api.nvim_create_augroup('nvim-lastplace', {}),

	callback = function()
		local ignore_buftype = { "quickfix", "nofile", "help" }
		local ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" }
		if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
			return
		end

		if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
			-- reset cursor to first line
			vim.cmd [[normal! gg]]
			return
		end

		-- If a line has already been specified on the command line, we are done
		--   nvim file +num
		if vim.fn.line(".") > 1 then
			return
		end

		local last_line = vim.fn.line([['"]])
		local buff_last_line = vim.fn.line("$")

		-- If the last line is set and the less than the last line in the buffer
		if last_line > 0 and last_line <= buff_last_line then
			local win_last_line = vim.fn.line("w$")
			local win_first_line = vim.fn.line("w0")
			-- Check if the last line of the buffer is the same as the win
			if win_last_line == buff_last_line then
				-- Set line to last line edited
				vim.cmd [[normal! g`"]]
				-- Try to center
			elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
				vim.cmd [[normal! g`"zz]]
			else
				vim.cmd [[normal! G'"<c-e>]]
			end
		end
	end

})
