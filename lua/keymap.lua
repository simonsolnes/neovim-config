local wk = require('which-key')
local macAltMap = require('utils').macAltMap

wk.register({
	name = 'henlo',
	t = { name = 'telescope' },
	k = { name = 'oiii' },
	["<leader>"] = { name = "leed" },
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


for mode, mappings in pairs(
	{
		normal = {
			[Xleader .. 'n' .. 'n'] = { 'Open filetree', function() vim.cmd.Neotree('toggle') end },
			[Xleader .. 'n' .. 'b'] = { 'Open filetree', function() vim.cmd.Neotree('toggle', 'buffers') end },

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
			[alt('Right')] = { 'Resize window left', ':vertical resize +3<cr>' },


		},
		visual = {
			['K'] = { 'Move lines up', ":m '<-2<cr>gv=gv" },
			['J'] = { 'Move lines down', ":m '>+1<cr>gv=gv" },
			['p'] = { 'Paste with preserve register', '"_dP' }
		}
	}

) do
	local modeShorthand = ({ normal = 'n', visual = 'v' })[mode]
	for keys, mapping in pairs(mappings) do
		vim.keymap.set(modeShorthand, keys, mapping[2], { desc = mapping[1], noremap = true })
	end
end




vim.keymap.set('n', leader('u'), vim.cmd.UndotreeToggle, { desc = "Undo tree" })
vim.keymap.set('n', leader('h'), vim.cmd.HopChar1, { desc = "Hop" })
vim.keymap.set('n', leader('git'), vim.cmd.Git, { desc = "Git" })

vim.keymap.set('n', '>', '>>', { desc = "Indent right" })
vim.keymap.set('n', '<', '<<', { desc = "Indent left" })
vim.keymap.set('v', '>', '>gv', { desc = "Indent right" })
vim.keymap.set('v', '<', '<gv', { desc = "Indent left" })


-- Keep cursor at the same spot
vim.keymap.set('n', control('d'), "<C-d>M", { desc = "Scroll half down" })
vim.keymap.set('n', control('u'), "<C-u>M", { desc = "Scroll half up" })
vim.keymap.set('n', control('f'), "<C-f>M", { desc = "Scroll down" })
vim.keymap.set('n', control('b'), "<C-b>M", { desc = "Scroll up" })

-- Git
vim.keymap.set('n', leader('gb'), function() vim.cmd.Gitsigns('blame_line') end, { desc = "Blame line" })
vim.keymap.set('n', ']h', function() vim.cmd.Gitsigns('next_hunk') end, { desc = "Next hunk" })
vim.keymap.set('n', '[h', function() vim.cmd.Gitsigns('prev_hunk') end, { desc = "Previous hunk" })

--
vim.keymap.set('n', leader('r'), "<cmd>!swift run<cr>", { desc = "run" })


vim.keymap.set('n', '<C-n>t', function() vim.cmd.Neotree('toggle') end, { desc = "Open filetree" })
vim.keymap.set('n', '<C-n>b', function() vim.cmd.Neotree('buffer') end, { desc = "Open buffers" })

vim.keymap.set('n', '<C-s>', vim.cmd.SymbolsOutline, { desc = "Open filetree" })

-- Window
vim.keymap.set('n', alt('h'), vim.cmd.bp, { desc = "previous buffer" })
vim.keymap.set('n', alt('l'), vim.cmd.bn, { desc = "next buffer" })
vim.keymap.set('n', alt('w'), ':bp<bar>sp<bar>bn<bar>bd<Enter>', { desc = "close buffer" })


-- Telescope
vim.keymap.set('n', leader('tf'), function() vim.cmd.Telescope('find_files') end, { desc = "Find files" })
vim.keymap.set('n', leader('tg'), function() vim.cmd.Telescope('live_grep') end, { desc = "Grep string" })
vim.keymap.set('n', leader('tr'), function() vim.cmd.Telescope('resume') end, { desc = "Resume telescope" })
vim.keymap.set('n', leader('to'), function() vim.cmd.Telescope('oldfiles') end, { desc = "Find oldfiles" })
vim.keymap.set('n', leader('b'), function() vim.cmd.Telescope('buffers') end,
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

		vim.keymap.set('n', 'gr', function() vim.cmd.Telescope('lsp_references') end,
			{ desc = "Show references", buffer = buffnr })
		vim.keymap.set('n', 'gd', function() vim.cmd.Telescope('lsp_definitions') end,
			{ desc = 'go to definition', buffer = buffnr })
		--puts doc header info into a float page
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'hover', buffer = buffnr })

		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { buffer = buffnr })
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { buffer = buffnr })
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { buffer = buffnr })

		vim.keymap.set('n', leader('lh'), vim.lsp.buf.signature_help, { buffer = buffnr })

		-- add LSP code actions
		vim.keymap.set({ 'n', 'v' }, leader('ca'), vim.lsp.buf.code_action, { buffer = buffnr })

		vim.keymap.set('n', leader('z'), function() vim.cmd.Telescope('buffers') end, { buffer = buffnr })



		-- suggested by lspconfig
		-- -- Buffer local mappings.
		-- -- See `:help vim.lsp.*` for documentation on any of the below functions
		-- local opts = { buffer = ev.buf }
		-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
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
		--
		-- some other random
		-- Displays hover information about the symbol under the cursor
		-- bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
		--
		-- -- Jump to the definition
		-- bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
		--
		-- -- Jump to declaration
		-- bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
		--
		-- -- Lists all the implementations for the symbol under the cursor
		-- bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
		--
		-- -- Jumps to the definition of the type symbol
		-- bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
		--
		-- -- Lists all the references
		-- bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
		--
		-- -- Displays a function's signature information
		-- bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
		--
		-- -- Renames all references to the symbol under the cursor
		-- bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
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
