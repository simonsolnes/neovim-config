local wk = require('which-key')
local cmp = require('cmp')
local harpoon = require('harpoon')
local gitsigns = require('gitsigns')

local utils = require('utils')
local macros = require('macros')
local alt = utils.alt
local control = utils.control
local leader = utils.leader

local function textcase_word(arg)
	return function()
		require('textcase').current_word(arg)
	end
end

local function spider_motion(motion)
	return "<cmd>lua require('spider').motion('" .. motion .. "')<cr>"
end

wk.register({
	t = { name = 'Telescope' },
	n = { name = 'Sidepanels' },
	g = { name = 'Git' },
}, { prefix = '<leader>' })

-- Very free buttons:
-- C-j
-- ) and ( for sentences in md etc and something else in code
--
-- Start tracking frequency use of these mappings
local map = {
	-- https://github.com/chrisgrieser/nvim-various-textobjs
	-- https://github.com/numToStr/Comment.nvim
	-- https://github.com/kylechui/nvim-surround

	normal = {
		-- System
		[leader .. 'w']               = { 'Write', ':w <cr>' },
		[leader .. 'q']               = { 'Quit', ':q <cr>' },
		[leader .. 'r']               = { 'Run', "<cmd>!swift run<cr>" },
		-- [':']                         = { 'Command', vim.cmd.Cmdpalette },
		-- ['/']                         = { 'Serch', function() require('searchbox').match_all() end },

		-- Navigation
		--['s']                         = { 'Hop', vim.cmd.HopChar1 },
		['s']                         = { 'Jump', function() require("flash").jump() end },
		['S']                         = { 'Jump', function() require("flash").treesitter() end },

		-- Harpoon
		[leader .. 'h' .. 'a']        = { 'Harpoon add', function() harpoon:list():append() end },
		[leader .. 'h' .. 'l']        = { 'Harpoon list', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end },
		[alt('t')]                    = { 'Harpoon list', function() harpoon:list():select(1) end },
		[alt('s')]                    = { 'Harpoon list', function() harpoon:list():select(2) end },
		[alt('r')]                    = { 'Harpoon list', function() harpoon:list():select(3) end },
		[alt('a')]                    = { 'Harpoon list', function() harpoon:list():select(4) end },

		-- Replacements
		['w']                         = { 'Word', spider_motion('w') },
		['e']                         = { 'End', spider_motion('e') },
		['b']                         = { 'Back', spider_motion('b') },

		[leader .. 'o']               = { 'Open', macros.open_url_under_cursor },

		-- Sidepanels
		[leader .. 'n' .. 'n']        = { 'Open filetree', function() vim.cmd.Neotree('toggle') end },
		[leader .. 'n' .. 'b']        = { 'Open buffertree', function() vim.cmd.Neotree('toggle', 'buffers') end },
		[leader .. 'n' .. 'u']        = { 'Open undotree', vim.cmd.UndotreeToggle },
		[leader .. 'n' .. 's']        = { 'Open symbols', vim.cmd.SymbolsOutline },
		[leader .. 'n' .. 'a']        = { 'Open aerial', "<cmd>AerialToggle!<CR>" },
		['<Down>']                    = { 'Open aerial', "<cmd>AerialNext<CR>" },
		['<Up>']                      = { 'Open aerial', "<cmd>AerialPrev<CR>" },

		-- Text case conversion
		[leader .. 'c' .. 's']        = { 'Snake case (lorem_ipsum)', textcase_word('to_snake_case') },
		[leader .. 'c' .. 'k']        = { 'Kebab case (lorem-ipsum)', textcase_word('to_dash_case') },
		[leader .. 'c' .. 'f']        = { 'Title kebab case (Lorem-Ipsum)', textcase_word('to_title_dash_case') },
		[leader .. 'c' .. 'n']        = { 'Constant case (LOREM_IPSUM)', textcase_word('to_constant_case') },
		[leader .. 'c' .. 'd']        = { 'Dot case (lorem.ipsum)', textcase_word('to_dot_case') },
		[leader .. 'c' .. 'c']        = { 'Camel case (loremIpsum)', textcase_word('to_camel_case') },
		[leader .. 'c' .. 'p']        = { 'Pascal case (LoremIpsum)', textcase_word('to_pascal_case') },
		[leader .. 'c' .. 'h']        = { 'Path case (lorem/ipsum)', textcase_word('to_path_case') },
		[leader .. 'c' .. 'u']        = { 'Uppercase (LOREM IPSUM)', textcase_word('to_upper_case') },
		[leader .. 'c' .. 'l']        = { 'Lowercase (lorem ipsum)', textcase_word('to_lower_case') },
		[leader .. 'c' .. 't']        = { 'Title case (Lorem Ipsum)', textcase_word('to_title_case') },
		[leader .. 'c' .. 'r']        = { 'Phrase case (Lorem ipsum)', textcase_word('to_phrase_case') },

		-- Git
		[leader .. 'g' .. 'i' .. 't'] = { 'Git', vim.cmd.Git },
		[leader .. 'g' .. 'l' .. 'l'] = { 'Open link for line', macros.git.open_line_on_origin('n') },
		[leader .. 'g' .. 'l' .. 'r'] = { 'Open repo', macros.git.open_origin_repo },
		[leader .. 'g' .. 'b']        = { 'Git blame', function() gitsigns.blame_line { full = true } end },
		[']' .. 'h']                  = { 'Next hunk', gitsigns.next_hunk },
		['[' .. 'h']                  = { 'Previous hunk', gitsigns.prev_hunk },
		[leader .. 'g' .. 's']        = { 'Stage hunk', gitsigns.stage_hunk },
		[leader .. 'g' .. 'r']        = { 'Reset hunk', gitsigns.reset_hunk },
		[leader .. 'g' .. 'b' .. 's'] = { 'Stage buffer', gitsigns.stage_buffer },
		[leader .. 'g' .. 'h' .. 'p'] = { 'Preview hunk', gitsigns.preview_hunk },
		[leader .. 'g' .. 't']        = { 'Toggle line blame', gitsigns.toggle_current_line_blame },
		[leader .. 'g' .. 'd']        = { 'Diff', function() gitsigns.diffthis('~') end },
		[leader .. 'g' .. 'k']        = { 'Toggle deleted', gitsigns.toggle_deleted },

		-- Indentation
		['>']                         = { 'Indent right', '>>' },
		['<']                         = { 'Indent left', '<<' },

		-- Windows
		[control('k')]                = { 'Window up', control('w') .. 'k' },
		[control('j')]                = { 'Window down', control('w') .. 'j' },
		[control('h')]                = { 'Window left', control('w') .. 'h' },
		[control('l')]                = { 'Window right', control('w') .. 'l' },
		[control('w') .. 'k']         = { 'Move window up', control('w') .. 'K' },
		[control('w') .. 'j']         = { 'Move window down', control('w') .. 'J' },
		[control('w') .. 'h']         = { 'Move window left', control('w') .. 'H' },
		[control('w') .. 'l']         = { 'Move window right', control('w') .. 'L' },
		[alt('Up')]                   = { 'Resize window up', ':resize -3<cr>' },
		[alt('Down')]                 = { 'Resize window down', ':resize +3<cr>' },
		[alt('Left')]                 = { 'Resize window left', ':vertical resize -3<cr>' },
		[alt('Right')]                = { 'Resize window right', ':vertical resize +3<cr>' },

		-- Buffers
		[alt('l')]                    = { 'Next buffer', vim.cmd.bn },
		[alt('h')]                    = { 'Previous buffer', vim.cmd.bp },
		[alt('w')]                    = { 'Close buffer', ':bp<bar>sp<bar>bn<bar>bd<Enter>' },

		-- Scroll
		[control('u')]                = { 'Scroll half up', control('u') .. 'M' },
		[control('d')]                = { 'Scroll half down', control('d') .. 'M' },
		[control('b')]                = { 'Scroll up', control('b') .. 'M' },
		[control('f')]                = { 'Scroll down', control('f') .. 'M' },
		[control('e')]                = { 'Scroll down', control('e') .. control('e') .. control('e') },
		[control('y')]                = { 'Scroll up', control('y') .. control('y') .. control('y') },


		-- Telescope
		[leader .. 't' .. 'f'] = { 'Find files', function() vim.cmd.Telescope('find_files') end },
		[leader .. 't' .. 'g'] = { 'Grep', function() vim.cmd.Telescope('live_grep') end },
		[leader .. 't' .. 'r'] = { 'Resume', function() vim.cmd.Telescope('resume') end },
		[leader .. 't' .. 'o'] = { 'Old files', function() vim.cmd.Telescope('oldfiles') end },
		[leader .. 't' .. 's'] = { 'Symbols', function() vim.cmd.Telescope('lsp_dynamic_workspace_symbols') end },
		[leader .. 'u'] = { 'Buffers', function() vim.cmd.Telescope('buffers') end },

		-- LSP
		[leader .. 'x' .. 'x'] = { 'Trouble', function() vim.cmd.TroubleToggle() end },
		[leader .. 'l' .. 's'] = { 'Signature', vim.lsp.buf.signature_help },
		[leader .. 'l' .. 'i'] = { 'Import', require("lspimport").import },
		[leader .. 'l' .. 'r'] = { 'Rename', vim.lsp.buf.rename },
		[leader .. 'l' .. 'a'] = { 'Code action', vim.lsp.buf.code_action },
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
	visual_select = {
		['J']                         = { 'Move lines down', ":m'>+<cr>gv=gv" },
		['K']                         = { 'Move lines up', ":m-2<cr>gv=gv" },
		['p']                         = { 'Paste with preserve register', '"_dP' },

		['>']                         = { 'Indent right', '>gv' },
		['<']                         = { 'Indent left', '<gv' },

		[leader .. 'g' .. 'l' .. 'l'] = { 'Open link for lines', macros.git.open_line_on_origin('v') },
		['g' .. 'c' .. 'c']           = { '', function() print("hello") end },

		[leader .. 'g' .. 's']        = { 'Stage hunk', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end },
		[leader .. 'g' .. 'r']        = { 'Reset hunk', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end },
	},
	visual = {
		['w'] = { 'Word', spider_motion('w') },
		['e'] = { 'End', spider_motion('e') },
		['b'] = { 'Back', spider_motion('b') },
		['y'] = { 'Yank and retain position', 'ygv<esc>' },
		['s'] = { 'Jump', function() require("flash").jump() end },
		['i' .. 'h'] = { 'Hunk', gitsigns.select_hunk },
	},
	operator_pending = {
		['w'] = { 'Word', ('w') },
		['e'] = { 'End', spider_motion('e') },
		['b'] = { 'Back', spider_motion('b') },
		['s'] = { 'Jump', function() require("flash").jump() end },
		['i' .. 'h'] = { 'Hunk', gitsigns.select_hunk },
	},
	cmp = {
		[control('n')] = cmp.mapping.select_next_item(),
		[control('p')] = cmp.mapping.select_prev_item(),
		[control('d')] = cmp.mapping.scroll_docs(-4),
		[control('f')] = cmp.mapping.scroll_docs(4),
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
		["<cr>"] = require('plugins.nvim-cmp').special_cr_mapping(),
	}

}

for mode, mappings in pairs(map) do
	if mode == 'cmp' then
		cmp.setup({
			mapping = cmp.mapping.preset.insert(mappings)
		})
	else
		local modeShorthand = ({ normal = 'n', visual_select = 'v', visual = 'x', operator_pending = 'o' })[mode]
		for keys, mapping in pairs(mappings) do
			vim.keymap.set(modeShorthand, keys, mapping[2], { desc = mapping[1], noremap = false, silent = true })
		end
	end
end
