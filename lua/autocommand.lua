-- set tab to 3 space when entering a buffer with .lua file
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.lua" },
	callback = function()
		vim.opt.shiftwidth = 3
		vim.opt.tabstop = 3

		vim.opt.softtabstop = 3
	end
})

vim.api.nvim_create_autocmd("FocusLost", {
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
