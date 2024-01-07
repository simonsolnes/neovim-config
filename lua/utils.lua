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

return M
