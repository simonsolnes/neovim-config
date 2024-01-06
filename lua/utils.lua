local M = {}

function M.executable(name)
	if vim.fn.executable(name) > 0 then
		return true
	end
	return false
end

-- When using option key on mac it will render a new character, instead of <M-$key>
-- Therefore this map translates ⌥-$key to the special char that will be read by vim
M.macAltMap = {
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

return M
