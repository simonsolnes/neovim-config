local M = {}

function M.executable(name)
	if vim.fn.executable(name) > 0 then
		return true
	end
	return false
end

-- When using option key on mac it will render a new character, instead of <M-$key>
-- Therefore this map translates ⌥-$key to the special char that will be read by vim
local macAltMap = {
	a = 'å',
	A = 'Å',
	b = '∫',
	c = 'ç',
	d = '∂',
	f = 'ƒ',
	g = '©',
	h = '˙',
	j = '∆',
	k = '˚',
	l = '¬',
	m = 'µ',
	o = 'ø',
	p = 'π',
	q = 'œ',
	r = '®',
	s = 'ß',
	t = '†',
	v = '√',
	w = '∑',
	x = '≈',
	y = '\\',
	z = 'Ω',
}

function M.control(inp)
	return '<C-' .. inp .. '>'
end

function M.alt(inp)
	if macAltMap[inp] ~= nil then
		return macAltMap[inp]
	else
		return '<M-' .. inp .. '>'
	end
end

M.leader = "<leader>"

function M.get_visual_selection()
	local bufnr = 0
	local visual_modes = {
		v = true,
		V = true,
		-- [t'<C-v>'] = true, -- Visual block does not seem to be supported by vim.region
	}

	-- Return if not in visual mode
	if visual_modes[vim.api.nvim_get_mode().mode] == nil then return end

	local options = {}
	options.adjust = function(pos1, pos2)
		if vim.fn.visualmode() == "V" then
			pos1[3] = 1
			pos2[3] = 2 ^ 31 - 1
		end

		if pos1[2] > pos2[2] then
			pos2[3], pos1[3] = pos1[3], pos2[3]
			return pos2, pos1
		elseif pos1[2] == pos2[2] and pos1[3] > pos2[3] then
			return pos2, pos1
		else
			return pos1, pos2
		end
	end

	local region, start, finish = vim.get_marked_region('v', '.', options)

	-- Compute the number of chars to get from the first line,
	-- because vim.region returns -1 as the ending col if the
	-- end of the line is included in the selection
	local lines =
		 vim.api.nvim_buf_get_lines(bufnr, start[1], finish[1] + 1, false)
	local line1_end
	if region[start[1]][2] - region[start[1]][1] < 0 then
		line1_end = #lines[1] - region[start[1]][1]
	else
		line1_end = region[start[1]][2] - region[start[1]][1]
	end

	lines[1] = vim.fn.strpart(lines[1], region[start[1]][1], line1_end, true)
	if start[1] ~= finish[1] then
		lines[#lines] =
			 vim.fn.strpart(
				 lines[#lines],
				 region[finish[1]][1],
				 region[finish[1]][2] - region[finish[1]][1]
			 )
	end
	return table.concat(lines)
end

return M
