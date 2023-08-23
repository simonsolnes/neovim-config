local wk = require('which-key')
wk.register({
	name = 'henlo',
	t = { name = 'telescope' },
	k = { name = 'oiii' }
}, { prefix = '<leader>' })

function control(inp)
	return '<C-' .. inp .. '>'
end

local leader = function(inp)
	return '<Leader>' .. inp
end

-- When using option key on mac it will render a new character, instead of <M-$key>
-- Therefore this map translates ⌥-$key to the special char that will be read by vim
local alt = function(inp)
	local has_meta_key = false
	if has_meta_key then
		return '<M-' .. inp .. '>'
	else
		local t = {
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
		return t[inp]
	end
end
vim.keymap.set('n', '<leader>kk', function() print("real lua function") end, { desc = "heyy" })
vim.keymap.set('n', leader('u'), vim.cmd.UndotreeToggle, { desc = "Undo tree" })
vim.keymap.set('n', leader('h'), vim.cmd.HopChar1, { desc = "Hop" })
vim.keymap.set('n', leader('git'), vim.cmd.Git, { desc = "Git" })

vim.keymap.set('n', '>', '>>', { desc = "Indent right" })
vim.keymap.set('n', '<', '<<', { desc = "Indent left" })
vim.keymap.set('v', '>', '>gv', { desc = "Indent right" })
vim.keymap.set('v', '<', '<gv', { desc = "Indent left" })

-- Move lines
vim.keymap.set('v', 'J', ":m '>+1<cr>gv=gv", { desc = "Move lines down" })
vim.keymap.set('v', 'K', ":m '<-2<cr>gv=gv", { desc = "Move lines up" })

-- Keep cursor at the same spot
vim.keymap.set('n', control('d'), "<C-d>zz", { desc = "Scroll half down" })
vim.keymap.set('n', control('u'), "<C-u>zz", { desc = "Scroll half up" })
vim.keymap.set('n', control('f'), "<C-f>zz", { desc = "Scroll down" })
vim.keymap.set('n', control('b'), "<C-b>zz", { desc = "Scroll up" })

-- Git
vim.keymap.set('n', leader('gb'), function() vim.cmd.Gitsigns('blame_line') end, { desc = "Blame line" })

vim.keymap.set('n', '<C-n>', function() vim.cmd.Neotree('toggle') end, { desc = "Open filetree" })

vim.keymap.set('n', '<C-s>', vim.cmd.SymbolsOutline, { desc = "Open filetree" })

-- Window
vim.keymap.set('n', alt('h'), vim.cmd.bp, { desc = "previous buffer" })
vim.keymap.set('n', alt('l'), vim.cmd.bn, { desc = "next buffer" })


-- Telescope
vim.keymap.set('n', leader('tf'), function() vim.cmd.Telescope('find_files') end, { desc = "Find files" })
vim.keymap.set('n', leader('tg'), function() vim.cmd.Telescope('live_grep') end, { desc = "Grep string" })
vim.keymap.set('n', leader('to'), function() vim.cmd.Telescope('oldfiles') end, { desc = "Find oldfiles" })
vim.keymap.set('n', leader('tb'), function() vim.cmd.Telescope('buffers') end,
	{ desc = "Find buffer" })
vim.keymap.set('n', leader('ts'), function() vim.cmd.Telescope('lsp_dynamic_workspace_symbols') end,
	{ desc = "Find workspace symbols" })

vim.keymap.set('n', leader('a'), function() vim.cmd.Telescope('buffers') end)


vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, { desc = "previous diagnostic" })
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, { desc = "next diagnostic" })


return {
	lsp_keymap = function(buffnr)
		vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float() end,
			{ desc = "Open diagnostic float", buffer = buffnr })

		vim.keymap.set('n', leader('gr'), function() vim.cmd.Telescope('lsp_references') end,
			{ desc = "Show references", buffer = buffnr })
		--vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'go to definition', buffer = buffnr })
		--puts doc header info into a float page
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'hover', buffer = buffnr })

		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { buffer = buffnr })
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { buffer = buffnr })
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { buffer = buffnr })

		-- add LSP code actions
		vim.keymap.set({ 'n', 'v' }, leader('ca'), vim.lsp.buf.code_action, { buffer = buffnr })

		-- find references of a type
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = buffnr })

		vim.keymap.set('n', leader('z'), function() vim.cmd.Telescope('buffers') end, { buffer = buffnr })



		-- suggested by lspconfig
		-- -- Buffer local mappings.
		-- -- See `:help vim.lsp.*` for documentation on any of the below functions
		-- local opts = { buffer = ev.buf }
		-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		-- vim.keymap.set('n', '<space>wl', function()
		--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- end, opts)
		-- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		-- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		-- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		-- vim.keymap.set('n', '<space>f', function()
		--   vim.lsp.buf.format { async = true }
		-- end, opts)
	end
}
