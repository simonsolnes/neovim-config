local wk = require('which-key')
local utils = require('utils')
local cmp = require('cmp')
local luasnip = require('luasnip')
local alt = utils.alt
local control = utils.control
local leader = utils.leader

wk.register({
	t = { name = 'Telescope' },
	n = { name = 'Sidepanels' },
	g = { name = 'Git' },
}, { prefix = '<leader>' })

local map = {
	normal = {
		-- System
		[leader .. 'w'] = { 'Write', ':w <cr>' },
		[leader .. 'q'] = { 'Quit', ':q <cr>' },
		[leader .. 'r'] = { 'Run', "<cmd>!swift run<cr>" },
		[':'] = { 'Command', vim.cmd.Cmdpalette },
		['/'] = { 'Serch', function() require('searchbox').match_all() end },

		-- Navigation
		['s'] = { 'Hop', vim.cmd.HopChar1 },

		-- Sidepanels
		[leader .. 'n' .. 'n'] = { 'Open filetree', function() vim.cmd.Neotree('toggle') end },
		[leader .. 'n' .. 'b'] = { 'Open buffertree', function() vim.cmd.Neotree('toggle', 'buffers') end },
		[leader .. 'n' .. 'u'] = { 'Open undotree', vim.cmd.UndotreeToggle },
		[leader .. 'n' .. 's'] = { 'Open symbols', vim.cmd.SymbolsOutline },

		-- Git
		[leader .. 'g' .. 'i' .. 't'] = { 'Git', vim.cmd.Git },
		[leader .. 'g' .. 'b'] = { 'Git blame', function() vim.cmd.Gitsigns('blame_line') end },
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
		[leader .. 't' .. 'f'] = { 'Find files', function() vim.cmd.Telescope('find_files') end },
		[leader .. 't' .. 'g'] = { 'Grep', function() vim.cmd.Telescope('live_grep') end },
		[leader .. 't' .. 'r'] = { 'Resume', function() vim.cmd.Telescope('resume') end },
		[leader .. 't' .. 'o'] = { 'Old files', function() vim.cmd.Telescope('oldfiles') end },
		[leader .. 't' .. 'b'] = { 'Old files', function() vim.cmd.Telescope('buffers') end },
		[leader .. 't' .. 's'] = { 'Symbols', function() vim.cmd.Telescope('lsp_dynamic_workspace_symbols') end },

		-- LSP
		[leader .. 'x' .. 'x'] = { 'Trouble', function() vim.cmd.TroubleToggle() end },
		[leader .. 'l' .. 's'] = { 'Signature', vim.lsp.buf.signature_help },
		[leader .. 'l' .. 'i'] = { 'Import', require("lspimport").import },
		[leader .. 'l' .. 'r'] = { 'Rename', vim.lsp.buf.rename },
		[leader .. 'c' .. 'a'] = { 'Signature', vim.lsp.buf.code_action },
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
		['J'] = { 'Move lines down', ":m'>+<cr>gv=gv" },
		['K'] = { 'Move lines up', ":m-2<cr>gv=gv" },
		['p'] = { 'Paste with preserve register', '"_dP' },

		['>'] = { 'Indent right', '>gv' },
		['<'] = { 'Indent left', '<gv' },
	},
	cmp = {
		[control('n')] = cmp.mapping.select_next_item(),
		[control('p')] = cmp.mapping.select_prev_item(),
		[control('d')] = cmp.mapping.scroll_docs(-4),
		[control('f')] = cmp.mapping.scroll_docs(4),
		["<cr>"] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() and cmp.get_active_entry() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end,
			s = cmp.mapping.confirm({ select = true }),
			c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		}),
	}

}

for mode, mappings in pairs(map) do
	if mode == 'cmp' then
		cmp.setup({
			mapping = cmp.mapping.preset.insert(mappings)
		})
	else
		local modeShorthand = ({ normal = 'n', visual = 'v' })[mode]
		for keys, mapping in pairs(mappings) do
			vim.keymap.set(modeShorthand, keys, mapping[2], { desc = mapping[1], noremap = false })
		end
	end
end
