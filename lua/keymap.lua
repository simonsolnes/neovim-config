local wk = require('which-key')
local macAltMap = require('utils').macAltMap

wk.register({
	t = { name = 'Telescope' },
	n = { name = 'Sidepanels' },
	g = { name = 'Git' },
}, { prefix = '<leader>' })

local function control(inp)
	return '<C-' .. inp .. '>'
end

local leader = function(inp)
	return '<Leader>' .. inp
end


local alt = function(inp)
	if macAltMap[inp] ~= nil then
		return macAltMap[inp]
	else
		return '<M-' .. inp .. '>'
	end
end


local Xleader = "<leader>"

local map = {
	normal = {
		-- System
		[Xleader .. 'w'] = { 'Write', ':w <cr>' },
		[Xleader .. 'q'] = { 'Quit', ':q <cr>' },
		[Xleader .. 'r'] = { 'Run', "<cmd>!swift run<cr>" },
		[':'] = { 'Command', vim.cmd.Cmdpalette },
		['/'] = { 'Serch', function() require('searchbox').match_all() end },

		-- Navigation
		['s'] = { 'Hop', vim.cmd.HopChar1 },

		-- Sidepanels
		[Xleader .. 'n' .. 'n'] = { 'Open filetree', function() vim.cmd.Neotree('toggle') end },
		[Xleader .. 'n' .. 'b'] = { 'Open buffertree', function() vim.cmd.Neotree('toggle', 'buffers') end },
		[Xleader .. 'n' .. 'u'] = { 'Open undotree', vim.cmd.UndotreeToggle },
		[Xleader .. 'n' .. 's'] = { 'Open symbols', vim.cmd.SymbolsOutline },

		-- Git
		[Xleader .. 'g' .. 'i' .. 't'] = { 'Git', vim.cmd.Git },
		[Xleader .. 'g' .. 'b'] = { 'Git blame', function() vim.cmd.Gitsigns('blame_line') end },
		[']' .. 'h'] = { 'Next hunk', function() vim.cmd.Gitsigns('next_hunk') end },
		['[' .. 'h'] = { 'Previous hunk', function() vim.cmd.Gitsigns('prev_hunk') end },

		-- Indentation
		['>'] = { 'Indent right', '>>' },
		['<'] = { 'Indent left', '<<' },

		-- Windows
		[control('k')] = { 'Window up', control('w') .. 'k' },
		[control('j')] = { 'Window down', control('w') .. 'j' },
		[control('h')] = { 'Window left', control('w') .. 'h' },
		[control('l')] = { 'Window right', control('w') .. 'l' },
		[control('w') .. 'k'] = { 'Move window up', control('w') .. 'K' },
		[control('w') .. 'j'] = { 'Move window down', control('w') .. 'J' },
		[control('w') .. 'h'] = { 'Move window left', control('w') .. 'H' },
		[control('w') .. 'l'] = { 'Move window right', control('w') .. 'L' },
		[alt('Up')] = { 'Resize window up', ':resize -3<cr>' },
		[alt('Down')] = { 'Resize window down', ':resize +3<cr>' },
		[alt('Left')] = { 'Resize window left', ':vertical resize -3<cr>' },
		[alt('Right')] = { 'Resize window right', ':vertical resize +3<cr>' },

		-- Buffers
		[alt('l')] = { 'Next buffer', vim.cmd.bn },
		[alt('h')] = { 'Previous buffer', vim.cmd.bp },
		[alt('w')] = { 'Close buffer', ':bp<bar>sp<bar>bn<bar>bd<Enter>' },

		-- Scroll
		[control('u')] = { 'Scroll half up', control('u') .. 'M' },
		[control('d')] = { 'Scroll half down', control('d') .. 'M' },
		[control('b')] = { 'Scroll up', control('b') .. 'M' },
		[control('f')] = { 'Scroll down', control('f') .. 'M' },
		[control('e')] = { 'Scroll down', control('e') .. control('e') .. control('e') },
		[control('y')] = { 'Scroll up', control('y') .. control('y') .. control('y') },


		-- Telescope
		[Xleader .. 't' .. 'f'] = { 'Find files', function() vim.cmd.Telescope('find_files') end },
		[Xleader .. 't' .. 'g'] = { 'Grep', function() vim.cmd.Telescope('live_grep') end },
		[Xleader .. 't' .. 'r'] = { 'Resume', function() vim.cmd.Telescope('resume') end },
		[Xleader .. 't' .. 'o'] = { 'Old files', function() vim.cmd.Telescope('oldfiles') end },
		[Xleader .. 't' .. 'b'] = { 'Old files', function() vim.cmd.Telescope('buffers') end },
		[Xleader .. 't' .. 's'] = { 'Symbols', function() vim.cmd.Telescope('lsp_dynamic_workspace_symbols') end },

		-- LSP
		[Xleader .. 'x' .. 'x'] = { 'Trouble', function() vim.cmd.TroubleToggle() end },
		[Xleader .. 'l' .. 's'] = { 'Signature', vim.lsp.buf.signature_help },
		[Xleader .. 'l' .. 'i'] = { 'Import', require("lspimport").import },
		[Xleader .. 'l' .. 'r'] = { 'Rename', vim.lsp.buf.rename },
		[Xleader .. 'c' .. 'a'] = { 'Signature', vim.lsp.buf.code_action },
		[']' .. 'd'] = { 'Next diagnostic', vim.diagnostic.goto_next },
		['[' .. 'd'] = { 'Previous diagnostic', vim.diagnostic.goto_prev },
		['g' .. 'l'] = { 'Diagnostic float', vim.diagnostic.open_float },
		['g' .. 'r'] = { 'References', function() vim.cmd.Telescope('lsp_references') end },
		['g' .. 'd'] = { 'Definition', function() vim.cmd.Telescope('lsp_definitions') end },
		['g' .. 'D'] = { 'Declaration', vim.lsp.buf.declaration },
		['g' .. 'i'] = { 'Implementation', vim.lsp.buf.implementation },
		['g' .. 't'] = { 'Type definiition', vim.lsp.buf.type_definition },
		['K'] = { 'Hover', vim.lsp.buf.hover },
	},
	visual = {
		['J'] = { 'Move lines down', ":m '>+1<cr>gv=gv" },
		['K'] = { 'Move lines up', ":m '<-2<cr>gv=gv" },
		['p'] = { 'Paste with preserve register', '"_dP' },

		['>'] = { 'Indent right', '>gv' },
		['<'] = { 'Indent left', '<gv' },
	}
}

for mode, mappings in pairs(map) do
	local modeShorthand = ({ normal = 'n', visual = 'v' })[mode]
	for keys, mapping in pairs(mappings) do
		vim.keymap.set(modeShorthand, keys, mapping[2], { desc = mapping[1], noremap = false })
	end
end

return {
	lsp_keymap = function(buffnr)
		-- suggested by lspconfig
		-- -- Buffer local mappings.
		-- -- See `:help vim.lsp.*` for documentation on any of the below functions
		-- local opts = { buffer = ev.buf }
		-- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		-- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		-- vim.keymap.set('n', '<space>f', function()
		--   vim.lsp.buf.format { async = true }
		-- end, opts)
		--
		-- -- Selects a code action available at the current cursor position
		-- bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
		-- bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
		--
		-- -- Show diagnostics in a floating window
		-- bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
		--
		-- -- Move to the previous diagnostic
		-- bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
		--
		-- -- Move to the next diagnostic
		-- bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
	end
}
